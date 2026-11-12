local ipc = "chillpill-shell-ipc call "
local mainMod = "SUPER"

hl.on("hyprland.start", function()
    hl.exec_cmd("chillpill-shell")
end)

hl.bind(mainMod .. " + CTRL + C",    hl.dsp.exec_cmd(ipc .. "controlCenter toggle"))
hl.bind(mainMod .. " + CTRL + V",    hl.dsp.exec_cmd(ipc .. "cliphist toggle"))
hl.bind(mainMod .. " + CTRL + B",    hl.dsp.exec_cmd(ipc .. "dashboard toggle"))
hl.bind(mainMod .. " + D",           hl.dsp.exec_cmd(ipc .. "spotlight toggle"))
hl.bind(mainMod .. " + W",           hl.dsp.exec_cmd(ipc .. "wallpaperSwitcher toggle"))
hl.bind(mainMod .. " + Escape",      hl.dsp.exec_cmd(ipc .. "powerMenu toggle"))
hl.bind(mainMod .. " + SHIFT + W",   hl.dsp.exec_cmd(ipc .. "wifiState toggle"))
hl.bind(mainMod .. " + SHIFT + B",   hl.dsp.exec_cmd(ipc .. "bluetoothState toggle"))
hl.bind(mainMod .. " + T",           hl.dsp.exec_cmd(ipc .. "theme toggle"))
