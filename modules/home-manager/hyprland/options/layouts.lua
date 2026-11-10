-- Defaults from Hyprland 0.57.1. Documentation: https://wiki.hypr.land/configuring/core/config-options/

hl.config({
    layout = {
        -- If specified, whenever only a single window is open, it will be coerced into the specified aspect ratio.
        -- single_window_aspect_ratio has no simple default in the source (Config::VEC2{0, 0})

        -- Minimum distance for single_window_aspect_ratio to take effect. (range 0. to 1.)
        single_window_aspect_ratio_tolerance = 0.1,
    },

    dwindle = {
        -- force a split direction for new windows (range 0 to 2; options: follow_mouse = 0, left = 1, right = 2)
        force_split = 0,

        -- if enabled, the split will not change regardless of what happens to the container.
        preserve_split = false,

        -- if enabled, allows a more precise control over the window split direction based on the cursor's position.
        smart_split = false,

        -- if enabled, resizing direction will be determined by the mouse's position on the window.
        smart_resizing = true,

        -- if enabled, makes the preselect direction persist.
        permanent_direction_override = false,

        -- specifies the auto-split width multiplier (range 0.1 to 3)
        split_width_multiplier = 1,

        -- whether to prefer the active window or the mouse position for splits
        use_active_for_splits = true,

        -- the default split ratio on window open. (range 0.1 to 1.9)
        default_split_ratio = 1,

        -- specifies which window will receive the split ratio. (range 0 to 1; options: directional = 0, current = 1)
        split_bias = 0,

        -- if enabled, bindm movewindow will drop the window more precisely depending on where your mouse is.
        precise_mouse_move = false,
    },

    master = {
        -- enable adding additional master windows in a horizontal split style
        allow_small_split = false,

        -- the size as a percentage of the master window. (range 0 to 1)
        mfact = 0.55,

        -- `master`: new window becomes master; `slave`: new windows are added to slave stack; `inherit`: inherit from focused window
        new_status = "slave",

        -- whether a newly open window should be on the top of the stack
        new_on_top = false,

        -- `before`, `after`: place new window relative to the focused window; `none`: place new window according to new_on_top.
        new_on_active = "none",

        -- default placement of the master area
        orientation = "left",

        -- when using orientation=center, make the master window centered only when at least this many slave windows are open. (range 0 to 10)
        slave_count_for_center_master = 2,

        -- Set fallback for center master when slaves are less than slave_count_for_center_master
        center_master_fallback = "left",

        -- centers the master window on monitor ignoring reserved areas
        center_ignores_reserved = false,

        -- if enabled, resizing direction will be determined by the mouse's position on the window.
        smart_resizing = true,

        -- when enabled, dragging and dropping windows will put them at the cursor position.
        drop_at_cursor = true,

        -- whether to keep the master window in its configured position when there are no slave windows
        always_keep_position = false,

        -- when enabled, closing a window focuses the master window
        focus_master_on_close = false,
    },

    scrolling = {
        -- when enabled, a single column on a workspace will always span the entire screen.
        fullscreen_on_one_column = true,

        -- the default width of a column. (range 0.1 to 1.0)
        column_width = 0.5,

        -- When a column is focused, what method should be used to bring it into view (range 0 to 1; options: center = 0, fit = 1)
        focus_fit_method = 1,

        -- Behaviour of the scrolling tape when a window is in focus. 0: Focus doesn't cause tape move. 1: Focus may cause tape move, mouse click always moves the tape. 2: Focus may cause tape move.
        follow_focus = 1,

        -- when a window is focused, require that at least a given fraction of it is visible for focus to follow (range 0.0 to 1.0)
        follow_min_visible = 0.4,

        -- A comma-separated list of preconfigured widths for colresize +conf/-conf
        explicit_column_widths = "0.333, 0.5, 0.667, 1.0",

        -- Direction in which new windows appear and the layout scrolls
        direction = "right",

        -- Determines if column focus wraps around
        wrap_focus = true,

        -- Determines if column movement wraps around
        wrap_swapcol = true,
    },
})
