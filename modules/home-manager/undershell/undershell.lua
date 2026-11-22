hl.on("hyprland.start", function()
    hl.exec_cmd("undershell")
end)

hl.bind("CTRL + ALT + SHIFT + E",hl.dsp.exec_cmd("undershell msg edit"))
