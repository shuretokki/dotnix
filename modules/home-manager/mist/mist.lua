local mist = "mist-ui-bin msg "
local scripts = os.getenv("HOME") .. "/.local/share/mist/shell/scripts/"
local mainMod = "SUPER"

-- autostart: the guard restarts mist-ui after a crash (gives up after 5 crashes in 2 min); mist-ui starts
-- mist-wall (wallpaper) and the mistd backends itself
hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("mistd tiles @start @trash @trash-full")
    hl.exec_cmd("mist-ui")
end)

hl.bind(mainMod .. " + Space",       hl.dsp.exec_cmd(mist .. "mist toggle spotlight"))
hl.bind(mainMod .. " + SUPER_L",     hl.dsp.exec_cmd(mist .. "mist toggle start"), { release = true })
hl.bind(mainMod .. " + Tab",         hl.dsp.exec_cmd(mist .. "switcher next"))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.exec_cmd(mist .. "switcher prev"))
hl.bind(mainMod .. " + CTRL + Tab",  hl.dsp.exec_cmd(mist .. "switcher windows"))
hl.bind(mainMod .. " + I",           hl.dsp.exec_cmd(mist .. "mist toggle control"))
hl.bind(mainMod .. " + A",           hl.dsp.exec_cmd(mist .. "mist toggle notifications"))
hl.bind(mainMod .. " + SHIFT + V",   hl.dsp.exec_cmd(mist .. "mist toggle clipboard"))
hl.bind(mainMod .. " + period",      hl.dsp.exec_cmd(mist .. "mist toggle emoji"))
hl.bind(mainMod .. " + Y",           hl.dsp.exec_cmd(mist .. "mist toggle phone"))
hl.bind(mainMod .. " + SHIFT + W",   hl.dsp.exec_cmd(mist .. "mist toggle wallpaper"))
hl.bind(mainMod .. " + ALT + C",     hl.dsp.exec_cmd(mist .. "mist toggle session"))
hl.bind(mainMod .. " + slash",       hl.dsp.exec_cmd(mist .. "mist toggle keys"))
hl.bind(mainMod .. " + L",           hl.dsp.exec_cmd("mist-ui-bin lock"))

-- Any earlier bind on the same key is dropped first, so a key never fires twice.
local media = {
    { "XF86AudioPlay",  mist .. "mist media toggle", { locked = true } },
    { "XF86AudioPause", mist .. "mist media toggle", { locked = true } },
    { "XF86AudioNext",  mist .. "mist media next",   { locked = true } },
    { "XF86AudioPrev",  mist .. "mist media prev",   { locked = true } },
    { "XF86MonBrightnessUp",   scripts .. "bright.sh up",   { locked = true, repeating = true } },
    { "XF86MonBrightnessDown", scripts .. "bright.sh down", { locked = true, repeating = true } },
}
for _, k in ipairs(media) do
    pcall(hl.unbind, k[1])
    hl.bind(k[1], hl.dsp.exec_cmd(k[2]), k[3])
end

hl.bind("Print",                   hl.dsp.exec_cmd(scripts .. "screenshot.sh region"))
hl.bind(mainMod .. " + Print",     hl.dsp.exec_cmd(scripts .. "screenshot.sh full"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(scripts .. "record.sh region"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd(scripts .. "ocr.sh"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd(scripts .. "pick.sh"))

-- glass: Hyprland blurs under the translucent surfaces; the shell animates its own layers
hl.layer_rule({
    name = "mist",
    match = { namespace = "^mist-(desktop|bar|dock|start|popup|spotlight|switcher|session)$" },
    ignore_alpha = 0.25,
    blur = true,
    blur_popups = true,
})
hl.layer_rule({ name = "mist-noanim", match = { namespace = "^mist-(desktop|bar|island|spotlight|switcher)$" }, no_anim = true })
hl.layer_rule({ name = "mist-snap", match = { namespace = "^mist-snap(-assist)?$" }, ignore_alpha = 0.1, blur = true, no_anim = true })
hl.layer_rule({ name = "mist-snap-catcher", match = { namespace = "^mist-snap-catcher$" }, no_anim = true })
hl.layer_rule({ name = "mist-gallery", match = { namespace = "^mist-gallery$" }, ignore_alpha = 0.45, blur = true, no_anim = true })
hl.layer_rule({ name = "mist-wallpreview", match = { namespace = "^mist-wallpreview$" }, no_anim = true })
