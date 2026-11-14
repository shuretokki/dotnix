import json
import os
import sys
import urllib.request
from html.parser import HTMLParser

STATE = os.path.join(
    os.environ.get("XDG_DATA_HOME", os.path.expanduser("~/.local/share")),
    "scrapling",
    "dicoding-state.json",
)
AGENT = "Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0"
BLOCK = {"p", "div", "li", "ul", "ol", "table", "tr", "blockquote", "br"}
SKIP = {"script", "style", "svg", "button", "noscript"}


class Article(HTMLParser):
    def __init__(self):
        super().__init__()
        self.depth = 0
        self.skip = 0
        self.pre = False
        self.out = []

    def handle_starttag(self, tag, attrs):
        if self.depth == 0:
            if tag == "main" and dict(attrs).get("id") == "article-content":
                self.depth = 1
            return
        if tag not in {"br", "img", "hr", "input", "meta", "link"}:
            self.depth += 1
        if tag in SKIP:
            self.skip += 1
        elif tag == "pre":
            self.pre = True
            self.out.append("\n```\n")
        elif tag in {"h1", "h2", "h3", "h4"}:
            self.out.append("\n\n" + "#" * int(tag[1]) + " ")
        elif tag == "li":
            self.out.append("\n- ")
        elif tag == "img":
            alt = dict(attrs).get("alt") or ""
            self.out.append(f"[image: {alt}]")
        elif tag in BLOCK:
            self.out.append("\n")

    def handle_endtag(self, tag):
        if self.depth == 0:
            return
        if tag in SKIP:
            self.skip -= 1
        elif tag == "pre":
            self.pre = False
            self.out.append("\n```\n")
        elif tag in BLOCK:
            self.out.append("\n")
        self.depth -= 1

    def handle_data(self, data):
        if self.depth and not self.skip:
            self.out.append(data if self.pre else " ".join(data.split()) + " ")


def fetch(url):
    with open(STATE) as f:
        cookies = json.load(f)["cookies"]
    header = "; ".join(f"{c['name']}={c['value']}" for c in cookies)
    request = urllib.request.Request(
        url, headers={"Cookie": header, "User-Agent": AGENT}
    )
    response = urllib.request.urlopen(request, timeout=30)
    if "/login" in response.geturl():
        sys.exit("LOGIN_EXPIRED: ask the owner to sign in again and re-export the cookies.")
    return response.read().decode()


def main():
    for url in sys.argv[1:]:
        parser = Article()
        parser.feed(fetch(url))
        text = "".join(parser.out).strip()
        print(f"<!-- {url} -->\n{text}\n")


main()
