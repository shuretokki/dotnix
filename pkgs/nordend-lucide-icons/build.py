import copy
import json
import sys

from fontTools import subset
from fontTools.ttLib import TTFont

package, out = sys.argv[1], sys.argv[2]

mapping = {
    "adjustments-horizontal": "sliders-horizontal",
    "aperture": "aperture",
    "app-window": "app-window",
    "bookmark": "bookmark",
    "calendar": "calendar",
    "chevron-down": "chevron-down",
    "chevron-left": "chevron-left",
    "chevron-right": "chevron-right",
    "chevron-up": "chevron-up",
    "database": "database",
    "database-off": "database-x",
    "device-desktop": "monitor",
    "disc": "disc",
    "download": "download",
    "file": "file",
    "file-code": "file-code",
    "file-description": "file-text",
    "file-spreadsheet": "file-spreadsheet",
    "file-text": "file-text",
    "file-type-pdf": "file-type",
    "file-zip": "file-archive",
    "files": "files",
    "folder": "folder",
    "folder-symlink": "folder-symlink",
    "help": "circle-question-mark",
    "home": "house",
    "layout-columns": "columns-3",
    "layout-grid": "layout-grid",
    "link-off": "link-2-off",
    "list-details": "list",
    "mail": "mail",
    "markdown": "file-text",
    "minus": "minus",
    "movie": "film",
    "music": "music",
    "photo": "image",
    "player-eject": "eject",
    "plug": "plug",
    "presentation": "presentation",
    "server": "server",
    "square": "square",
    "squares": "copy",
    "terminal-2": "terminal",
    "trash": "trash",
    "typography": "type",
    "usb": "usb",
    "vector": "vector-square",
    "x": "x",
}

font = TTFont(f"{package}/font/lucide.ttf")
with open(f"{package}/font/codepoints.json") as handle:
    codepoints = json.load(handle)
cmap = font.getBestCmap()
glyf = font["glyf"]
hmtx = font["hmtx"]
order = list(font.getGlyphOrder())

sources = {
    name: (copy.deepcopy(glyf[cmap[codepoints[source]]]), hmtx.metrics[cmap[codepoints[source]]])
    for name, source in mapping.items()
}
for name, (outline, metrics) in sources.items():
    if name not in glyf.glyphs:
        order.append(name)
    glyf.glyphs[name] = outline
    hmtx.metrics[name] = metrics
font.setGlyphOrder(order)
glyf.glyphOrder = order
font["maxp"].numGlyphs = len(order)

options = subset.Options()
options.glyph_names = True
options.notdef_outline = True
options.layout_features = []
options.name_IDs = ["*"]
options.name_languages = ["*"]
subsetter = subset.Subsetter(options)
subsetter.populate(glyphs=list(mapping))
subsetter.subset(font)
font.save(out)
