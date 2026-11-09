-- Defaults from Hyprland 0.57.1. Documentation: https://wiki.hypr.land/configuring/core/config-options/

hl.config({
    cursor = {
        -- don't render cursors
        invisible = false,

        -- disables hardware cursors. (range 0 to 2; options: Disabled = 0, Enabled = 1, Auto = 2)
        no_hardware_cursors = 2,

        -- disables scheduling new frames on cursor movement for fullscreen apps with VRR enabled. (range 0 to 2; options: disable = 0, enable = 1, auto = 2)
        no_break_fs_vrr = 2,

        -- minimum refresh rate for cursor movement when no_break_fs_vrr is active. (range 10 to 500)
        min_refresh_rate = 24,

        -- the padding, in logical px, between screen edges and the cursor (range 0 to 20)
        hotspot_padding = 0,

        -- in seconds, after how many seconds of cursor's inactivity to hide it. Set to 0 for never. (range 0 to 20)
        inactive_timeout = 0,

        -- if true, will not warp the cursor in many cases
        no_warps = false,

        -- When a window is refocused, the cursor returns to its last position relative to that window.
        persistent_warps = false,

        -- Move the cursor to the last focused window after changing the workspace. (range 0 to 2; options: disable = 0, enable = 1, force = 2)
        warp_on_change_workspace = 0,

        -- Move the cursor to the last focused window when focusing a different monitor. (range -1 to 2; options: same_as_warp_on_change_workspace = -1, disable = 0, enable = 1, force = 2)
        warp_on_monitor_change = -1,

        -- Move the cursor to the last focused window when toggling a special workspace. (range 0 to 2; options: disable = 0, enable = 1, force = 2)
        warp_on_toggle_special = 0,

        -- the name of a default monitor for the cursor to be set to on startup
        -- default_monitor = "",

        -- the factor to zoom by around the cursor. 1 means no zoom. (range 1 to 10)
        zoom_factor = 1,

        -- whether the zoom should follow the cursor rigidly or loosely
        zoom_rigid = false,

        -- If enabled, when zooming, no antialiasing will be used
        zoom_disable_aa = false,

        -- Detaches the camera from the mouse when zoomed in
        zoom_detached_camera = true,

        -- whether to enable hyprcursor support
        enable_hyprcursor = true,

        -- Hides the cursor when you press any key until the mouse is moved.
        hide_on_key_press = false,

        -- Hides the cursor when the last input was a touch input until a mouse input is done.
        hide_on_touch = true,

        -- Hides the cursor when the last input was a tablet input until a mouse input is done.
        hide_on_tablet = false,

        -- Makes HW cursors use a CPU buffer. (range 0 to 2; options: disable = 0, enable = 1, auto = 2)
        use_cpu_buffer = 2,

        -- sync xcursor theme with gsettings
        sync_gsettings_theme = true,

        -- warp the cursor back to where it was after using a non-mouse input to move it.
        warp_back_after_non_mouse_input = false,
    },
})
