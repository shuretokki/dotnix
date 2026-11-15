import json
import os
import re
import sys

lucide, vicinae_icons, out = sys.argv[1:4]

brands = {
    "apple",
    "atom",
    "blender",
    "chrome",
    "codepen",
    "eclipse",
    "facebook",
    "figma",
    "github",
    "gitlab",
    "linkedin",
    "slack",
    "trello",
    "twitter",
}

aliases = {
    "arrow-clockwise": "rotate-cw",
    "arrow-counter-clockwise": "rotate-ccw",
    "blank-document": "file",
    "bullet-points": "list",
    "cd": "disc",
    "checkmark": "check",
    "cog": "settings",
    "computer-chip": "cpu",
    "copy-clipboard": "clipboard-copy",
    "desktop": "monitor",
    "duplicate": "copy",
    "envelope": "mail",
    "magnifying-glass": "search",
    "plus-circle": "circle-plus",
    "trash": "trash-2",
    "xmark": "x",
}

header = (
    '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" '
    'fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">'
)

lucide_names = set(json.load(open(f"{lucide}/font/codepoints.json")))
vicinae_names = {name[:-4] for name in os.listdir(vicinae_icons) if name.endswith(".svg")}

mapping = {
    name: name for name in sorted(vicinae_names & lucide_names) if name not in brands
}
mapping.update(
    {name: target for name, target in aliases.items() if name in vicinae_names and target in lucide_names}
)

os.makedirs(out)
for name, target in mapping.items():
    source = open(f"{lucide}/icons/{target}.svg").read()
    body = re.search(r"<svg[^>]*>(.*)</svg>", source, re.S).group(1)
    body = re.sub(r"<!--.*?-->", "", body, flags=re.S).replace("currentColor", "#fff")
    with open(f"{out}/{name}.svg", "w") as handle:
        handle.write(header + body.strip() + "</svg>\n")

print(len(mapping), "icons replaced")
