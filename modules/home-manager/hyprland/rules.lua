hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name  = "cap-no-bar",
    match = { class = "^[Cc]ap$" },

    ["hyprbars:no_bar"] = true,
})

hl.window_rule({
    name  = "border-flicker-opacity",
    match = { class = ".*" },

    opacity = "0.999 0.999",
})

hl.layer_rule({
    name  = "vicinae-liquid-glass",
    match = { namespace = "vicinae" },

    blur = true,
    ignore_alpha = 0.2,
    ["hyprliquid:effect"] = "liquid_glass",
    ["hyprliquid:corner_radius"] = 32,
    ["hyprliquid:highlight_style"] = 4,
    ["hyprliquid:glass_thickness"] = 1500,
})
