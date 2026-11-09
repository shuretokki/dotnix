-- Defaults from Hyprland 0.57.1. Documentation: https://wiki.hypr.land/configuring/core/config-options/

hl.config({
    input = {
        touchpad = {
            -- Disable the touchpad while typing.
            disable_while_typing = true,

            -- Inverts scrolling direction.
            natural_scroll = false,

            -- Multiplier applied to the amount of scroll movement. (range 0 to 100)
            scroll_factor = 1,

            -- Sending LMB and RMB simultaneously will be interpreted as a middle click.
            middle_button_emulation = false,

            -- Sets the tap button mapping for touchpad button emulation. [lrm/lmr]
            tap_button_map = "",

            -- Button presses with 1, 2, or 3 fingers will be mapped to LMB, RMB, and MMB respectively.
            clickfinger_behavior = false,

            -- Tapping on the touchpad with 1, 2, or 3 fingers will send LMB, RMB, and MMB respectively.
            tap_to_click = true,

            -- When enabled, lifting the finger off while dragging will not drop the dragged item. (range 0 to 2)
            drag_lock = 0,

            -- Sets the tap and drag mode for the touchpad
            tap_and_drag = true,

            -- Inverts the horizontal movement of the touchpad
            flip_x = false,

            -- Inverts the vertical movement of the touchpad
            flip_y = false,

            -- Whether to use 3 or 4 finger drag. (range 0 to 2; options: disable = 0, 3_finger = 1, 4_finger = 2)
            drag_3fg = 0,
        },

        touchdevice = {
            -- Transform the input from touchdevices. (range 0 to 6)
            transform = 0,

            -- The monitor to bind touch devices.
            output = "[[Auto]]",

            -- Whether input is enabled for touch devices.
            enabled = true,
        },

        tablet = {
            -- Whether input is enabled for tablets.
            enabled = true,

            -- transform the input from tablets. (range 0 to 6)
            transform = 0,

            -- the monitor to bind tablets.
            output = "",

            -- position of the mapped region in monitor layout.
            -- region_position has no simple default in the source (Config::VEC2{})

            -- whether to treat the region_position as an absolute position in monitor layout.
            absolute_region_position = false,

            -- size of the mapped region.
            -- region_size has no simple default in the source (Config::VEC2{})

            -- whether the input should be relative
            relative_input = false,

            -- if enabled, the tablet will be rotated 180 degrees
            left_handed = false,

            -- size of tablet's active area in mm
            -- active_area_size has no simple default in the source (Config::VEC2{})

            -- position of the active area in mm
            -- active_area_position has no simple default in the source (Config::VEC2{})
        },

        tablettool = {
            -- Change the eraser button behavior on the tool. When set to 0, use the default hardware behavior of the tool. When set to 1, the eraser button on the tool sends a button event instead. (range 0 to 6)
            eraser_button_mode = 0,

            -- Set a button to be button event when eraser_button_mode is set to 1. Has to be an int, cannot be a string. Must be a valid button (e.g. BTN_STYLUS) excluding fake buttons (e.g. BTN_TOOL_*) and keys (KEY_*). Check wev if you have any doubts regarding the ID. 0 means default. (range 0 to None)
            eraser_button_override = 0,

            -- Set the minimum pressure range for the tool, a negative number will set the default minimum pressure value. This is usually 0.0 (range -1.0 to 1.0)
            pressure_range_min = -1.0,

            -- Set the maximum pressure range for the tool, a negative number will set the default maximum pressure value. This is usually 1.0 (range -1.0 to 1.0)
            pressure_range_max = -1.0,
        },
    },

    gestures = {
        -- in px, the distance of the touchpad gesture (range 0 to 2000)
        workspace_swipe_distance = 300,

        -- enable workspace swiping from the edge of a touchscreen
        workspace_swipe_touch = false,

        -- invert the direction (touchpad only)
        workspace_swipe_invert = true,

        -- invert the direction (touchscreen only)
        workspace_swipe_touch_invert = false,

        -- minimum speed in px per timepoint to force the change ignoring cancel_ratio. (range 0 to 200)
        workspace_swipe_min_speed_to_force = 30,

        -- how much the swipe has to proceed in order to commence it. (range 0 to 1)
        workspace_swipe_cancel_ratio = 0.5,

        -- whether a swipe right on the last workspace should create a new one.
        workspace_swipe_create_new = true,

        -- if enabled, switching direction will be locked when you swipe past the direction_lock_threshold.
        workspace_swipe_direction_lock = true,

        -- in px, the distance to swipe before direction lock activates. (range 0 to 200)
        workspace_swipe_direction_lock_threshold = 10,

        -- if enabled, swiping will not clamp at the neighboring workspaces but continue to the further ones.
        workspace_swipe_forever = false,

        -- if enabled, swiping will use the r prefix instead of the m prefix for finding workspaces.
        workspace_swipe_use_r = false,

        -- Timeout for closing windows with the close gesture, in ms. (range 10 to 2000)
        close_max_timeout = 1000,

        scrolling = {
            -- When releasing the scroll move gesture, whether it shoud try to snap to the grid.
            move_snap_to_grid = true,

            -- When releasing the scroll move gesture, whether it shoud snap the cursor to the newly focused window.
            move_snap_cursor = true,
        },
    },
})
