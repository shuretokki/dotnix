-- https://wiki.hypr.land/configuring/core/config-options/

hl.config({
    misc = {
        -- disables the random Hyprland logo / anime girl background. :(
        disable_hyprland_logo = true,

        -- disables the Hyprland splash rendering.
        disable_splash_rendering = true,

        col = {
            -- Changes the color of the splash text.
            splash = "rgba(ffffff55)",
        },

        -- Set the global default font to render the text.
        font_family = "Sans",

        -- Changes the font used to render the splash text.
        splash_font_family = "[[EMPTY]]",

        -- Force any of the 3 default wallpapers. [-1/0/1/2] (range -1 to 2)
        force_default_wallpaper = -1,

        -- controls the VRR (Adaptive Sync) of your monitors (range 0 to 3; options: off = 0, on = 1, fullscreen = 2, fullscreen_game = 3)
        vrr = 0,

        -- If DPMS is set to off, wake up the monitors if the mouse moves
        mouse_move_enables_dpms = false,

        -- If DPMS is set to off, wake up the monitors if a key is pressed.
        key_press_enables_dpms = false,

        -- Name virtual keyboards after the processes that create them.
        name_vk_after_proc = true,

        -- Will make mouse focus follow the mouse when drag and dropping.
        always_follow_on_dnd = true,

        -- If true, will make keyboard-interactive layers keep their focus on mouse move.
        layers_hog_keyboard_focus = true,

        -- If true, will animate manual window resizes/moves
        animate_manual_resizes = true,

        -- If true, will animate windows being dragged by mouse.
        animate_mouse_windowdragging = false,

        -- If true, the config will not reload automatically on save.
        disable_autoreload = false,

        -- Enable window swallowing
        enable_swallow = false,

        -- The class regex to be used for windows that should be swallowed.
        -- swallow_regex = "",

        -- The title regex to be used for windows that should not be swallowed.
        -- swallow_exception_regex = "",

        -- Whether Hyprland should focus an app that requests to be focused.
        focus_on_activate = false,

        -- Whether mouse moving into a different monitor should focus it
        mouse_move_focuses_monitor = true,

        -- if true, will allow you to restart a lockscreen app in case it crashes.
        -- allow_session_lock_restore is set in macshell.lua

        -- keep rendering workspaces below your lockscreen
        session_lock_xray = false,

        -- Enable blur for lockscreen. You probably want to enable `session_lock_xray`.
        session_lock_blur = false,

        -- change the background color.
        -- background_color is set by Stylix

        -- close the special workspace if the last window is removed
        close_special_on_empty = true,

        -- if there is a fullscreen or maximized window, decide whether a tiled window requested to focus should replace it. (range 0 to 2; options: ignore = 0, take_over = 1, exit_fullscreen = 2)
        on_focus_under_fullscreen = 2,

        -- whether closing a fullscreen window makes the next focused window to be fullscreened (range 0 to 3; options: disable = 0, enable = 1, only_when_grouped = 2, only_when_nongrouped = 3)
        exit_window_retains_fullscreen = 0,

        -- if enabled, windows will open on the workspace they were invoked on. (range 0 to 2)
        initial_workspace_tracking = 1,

        -- the time in seconds a window has to open on its invoked workspace before the tracking token expires. (range 1 to 3600)
        initial_workspace_token_timeout = 10,

        -- whether to enable middle-click-paste (aka primary selection)
        middle_click_paste = true,

        -- the maximum limit for renderunfocused windows' fps in the background (range 1 to 120)
        render_unfocused_fps = 15,

        -- disable the warning if XDG environment is externally managed
        disable_xdg_env_checks = false,

        -- disable the warning if hyprland-guiutils is missing
        disable_hyprland_guiutils_check = false,

        -- whether to disable the warning about not using start-hyprland.
        disable_watchdog_warning = false,

        -- the delay in ms after the lockdead screen appears. (range 0 to 5000)
        lockdead_screen_delay = 1000,

        -- whether to enable the ANR (app not responding) dialog when your apps hang
        enable_anr_dialog = true,

        -- number of missed pings before showing the ANR dialog (range 1 to 20)
        anr_missed_pings = 5,

        -- forces 8 bit screencopy
        screencopy_force_8b = true,

        -- disables notification popup when a monitor fails to set a suitable scale
        disable_scale_notification = false,

        -- whether to apply minsize and maxsize rules to tiled windows
        size_limits_tiled = false,

        -- path to custom wav/ogg system bell. `none` or an empty string mute it. `default` uses the system's current one.
        bell_sound = "default",

        -- whether new floating windows must be placed fully/partially on-screen
        new_float_force_onscreen = 2,

        -- whether existing floating windows must remain fully/partially on-screen
        float_force_onscreen = 0,
    },

    layers = {
        -- If false, newly mapped layers are not allowed to render over existing covering fullscreen window. Note that fullscreen hides all pre-existing top layers regardless of this setting
        allow_new_top_layers_over_existing_fullscreen = true,

        -- If true, will make keyboard-interactive layers keep their focus on mouse move.
        layers_hog_keyboard_focus = true,
    },

    binds = {
        -- if disabled, will not pass the mouse events to apps / dragging windows around if a keybind has been triggered.
        pass_mouse_when_bound = false,

        -- in ms, how many ms to wait after a scroll event to allow passing another one for the binds. (range 0 to 2000)
        scroll_event_delay = 300,

        -- An attempt to switch to the currently focused workspace will instead switch to the previous workspace. (range 0 to 2; options: disabled = 0, all_monitors = 1, per_monitor = 2)
        workspace_back_and_forth = 0,

        -- If enabled, changing the active workspace will hide the special workspace on the monitor.
        hide_special_on_workspace_change = false,

        -- If enabled, workspaces don't forget their previous workspace.
        allow_workspace_cycles = false,

        -- Whether switching workspaces should center the cursor on the workspace (0) or on the last active window (1) (range 0 to 1)
        workspace_center_on = 1,

        -- sets the preferred focus finding method when using focuswindow/movewindow/etc with a direction. (range 0 to 1)
        focus_preferred_method = 0,

        -- If enabled, dispatchers like moveintogroup, moveoutofgroup and movewindoworgroup will ignore lock per group.
        ignore_group_lock = false,

        -- If enabled, when on a fullscreen window, movefocus will cycle fullscreen.
        movefocus_cycles_fullscreen = false,

        -- If enabled, when in a grouped window, movefocus will cycle windows in the groups first.
        movefocus_cycles_groupfirst = false,

        -- If enabled, apps that request keybinds to be disabled will not be able to do so.
        disable_keybind_grabbing = false,

        -- If enabled, moving a window or focus over the edge of a monitor with a direction will move it to the next monitor.
        window_direction_monitor_fallback = true,

        -- Allows fullscreen to pinned windows, and restore their pinned status afterwards
        allow_pin_fullscreen = false,

        -- If false, client requested FS will use default FS handler
        client_requested_fs_uses_layout_handler = true,

        -- Movement threshold in pixels for window dragging and c/g bind flags. 0 to disable. (range 0 to None)
        drag_threshold = 0,

        -- If enabled, dragging a tiled or fullscreen window will center it on the cursor when it becomes floating.
        drag_center_window = true,
    },

    xwayland = {
        -- allow running applications using X11
        enabled = true,

        -- uses the nearest neighbor filtering for xwayland apps, making them pixelated rather than blurry
        use_nearest_neighbor = true,

        -- forces a scale of 1 on xwayland windows on scaled displays.
        force_zero_scaling = false,

        -- Create the abstract Unix domain socket for XWayland
        create_abstract_socket = false,
    },

    ecosystem = {
        -- disable the popup that shows up when you update hyprland to a new version.
        no_update_news = false,

        -- disable the popup that shows up twice a year encouraging to donate.
        no_donation_nag = false,

        -- whether to enable permission control.
        enforce_permissions = false,
    },

    input_capture = {
        -- If enabled, modifiers are also captured and sent to the program
        capture_modifiers = false,

        -- If enabled, throw a wayland error when a invalid barrier is received
        enforce_barriers = true,
    },

    quirks = {
        -- Prefer HDR mode. (range 0 to 2; options: disable = 0, enable = 1, gamescope_only = 2)
        prefer_hdr = 0,

        -- Do not report dmabuf formats which cannot be imported into KMS
        skip_non_kms_dmabuf_formats = false,
    },
})
