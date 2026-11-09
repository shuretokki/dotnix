-- Defaults from Hyprland 0.57.1. Documentation: https://wiki.hypr.land/configuring/core/config-options/

hl.config({
    input = {
        -- Appropriate XKB keymap parameter.
        kb_model = "",

        -- Appropriate XKB keymap parameter
        kb_layout = "us",

        -- Appropriate XKB keymap parameter
        kb_variant = "",

        -- Appropriate XKB keymap parameter
        kb_options = "",

        -- Appropriate XKB keymap parameter
        kb_rules = "",

        -- Appropriate XKB keymap file
        kb_file = "",

        -- Engage numlock by default.
        numlock_by_default = false,

        -- Determines how keybinds act when multiple layouts are used.
        resolve_binds_by_sym = false,

        -- The repeat rate for held-down keys, in repeats per second. (range 0 to 200)
        repeat_rate = 25,

        -- Delay before a held-down key is repeated, in milliseconds. (range 0 to 2000)
        repeat_delay = 600,

        -- Sets the mouse input sensitivity. Value is clamped to the range -1.0 to 1.0. (range -1 to 1)
        sensitivity = 0,

        -- Sets the cursor acceleration profile. [adaptive/flat/custom]
        accel_profile = "",

        -- Force no cursor acceleration.
        force_no_accel = false,

        -- Sets the rotation of a device in degrees clockwise. Value is clamped to the range 0 to 359. (range 0 to 359)
        rotation = 0,

        -- Switches RMB and LMB
        left_handed = false,

        -- Sets the scroll acceleration profile, when accel_profile is set to custom.
        scroll_points = "",

        -- Sets the scroll method. [2fg/edge/on_button_down/no_scroll]
        scroll_method = "",

        -- Sets the scroll button. 0 means default. (range 0 to 300)
        scroll_button = 0,

        -- If the scroll button lock is enabled, the button does not need to be held down.
        scroll_button_lock = false,

        -- Multiplier added to scroll movement for external mice. (range 0 to 100)
        scroll_factor = 1,

        -- Inverts scrolling direction.
        natural_scroll = false,

        -- Specify if and how cursor movement should affect window focus. (range 0 to 3; options: disabled = 0, follow = 1, detached = 2, separate = 3)
        follow_mouse = 1,

        -- The smallest distance in logical pixels the mouse needs to travel for the window under it to get focused.
        follow_mouse_threshold = 0,

        -- If enabled, the click that changes window focus is not forwarded to the window.
        swallow_focus_click = false,

        -- Controls the window focus behavior when a window is closed. (range 0 to 2; options: next = 0, cursor = 1, mru = 2)
        focus_on_close = 0,

        -- if disabled, mouse focus won't switch to the hovered window unless the mouse crosses a window boundary when follow_mouse=1.
        mouse_refocus = true,

        -- If enabled (1 or 2), focus will change to the window under the cursor when changing from tiled-to-floating and vice versa. If 2, focus will also follow mouse on float-to-float switches. (range 0 to 2)
        float_switch_override_focus = 1,

        -- if enabled, having only floating windows in the special workspace will not block focusing windows in the regular workspace.
        special_fallthrough = false,

        -- How to handle axis events around a focused window. (range 0 to 3; options: ignore = 0, send = 1, clamp = 2, warp = 3)
        off_window_axis_events = 1,

        -- Emulates discrete scrolling from high resolution scrolling events. (range 0 to 2; options: disable = 0, non_standard = 1, force_all = 2)
        emulate_discrete_scroll = 1,

        -- Shrinks the inactive window hitboxes used for focus detection by the specified number of pixels. This creates a dead zone in gaps between windows where moving the cursor will not change focus. Works only with follow_mouse = 1. (range 0 to 300)
        follow_mouse_shrink = 0,

        virtualkeyboard = {
            -- Unify key down states and modifier states with other keyboards. (range 0 to 2; options: disable = 0, enable = 1, only_non_ime = 2)
            share_states = 2,

            -- Release all pressed keys by virtual keyboard on close.
            release_pressed_on_close = false,
        },
    },
})
