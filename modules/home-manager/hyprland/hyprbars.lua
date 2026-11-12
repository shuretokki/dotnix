hl.plugin.hyprbars.add_button({
    bg_color = "rgb(ff5f57)",
    fg_color = "rgb(4d0000)",
    size = 12,
    icon = "",
    action = "hyprctl dispatch 'hl.dsp.window.close()'",
})

hl.plugin.hyprbars.add_button({
    bg_color = "rgb(febc2e)",
    fg_color = "rgb(5a3d00)",
    size = 12,
    icon = "",
    action = [[hyprctl dispatch 'hl.dsp.window.float({ action = "toggle" })']],
})

hl.plugin.hyprbars.add_button({
    bg_color = "rgb(28c840)",
    fg_color = "rgb(003d0a)",
    size = 12,
    icon = "",
    action = [[hyprctl dispatch 'hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })']],
})
