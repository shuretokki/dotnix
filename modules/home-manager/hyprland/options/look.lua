-- 0.57.1
-- https://wiki.hypr.land/configuring/core/config-options/

hl.config({
    general = {
        -- size of the border around windows (range 0 to 20)
        border_size = 1,

        -- gaps between windows
        gaps_in = 2,

        -- gaps between windows and monitor edges
        gaps_out = 4,

        -- gaps between windows and monitor edges for floating windows
        float_gaps = 0,

        -- gaps between workspaces. Stacks with gaps_out. (range 0 to 100)
        gaps_workspaces = 0,

        col = {
            -- border color for inactive windows
            -- inactive_border is set by Stylix

            -- border color for the active window
            -- active_border is set by Stylix

            -- inactive border color for window that cannot be added to a group
            nogroup_border = "rgba(ffaaffff)",

            -- active border color for window that cannot be added to a group
            nogroup_border_active = "rgba(ff00ffff)",
        },

        -- which layout to use. [dwindle/master/scrolling/monocle/lua:<name>]
        layout = "dwindle",

        -- if true, will not fall back to the next available window when moving focus in a direction where no window was found
        no_focus_fallback = false,

        -- enables resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- extends the area around the border where you can click and drag on, only used when general:resize_on_border is on. (range 0 to 100)
        extend_border_grab_area = 15,

        -- show a cursor icon when hovering over borders, only used when general:resize_on_border is on.
        hover_icon_on_border = true,

        -- master switch for allowing tearing to occur.
        allow_tearing = false,

        -- force floating windows to use a specific corner when being resized (1-4 going clockwise from top left, 0 to disable) (range 0 to 4; options: disable = 0, top_left = 1, top_right = 2, bottom_right = 3, bottom_left = 4)
        resize_corner = 0,

        snap = {
            -- enable snapping for floating windows
            enabled = false,

            -- minimum gap in pixels between windows before snapping (range 0 to 100)
            window_gap = 10,

            -- minimum gap in pixels between window and monitor edges before snapping (range 0 to 100)
            monitor_gap = 10,

            -- if true, windows snap such that only one border's worth of space is between them
            border_overlap = false,

            -- if true, snapping will respect gaps between windows
            respect_gaps = false,
        },

        -- if true, parent windows of modals will not be interactive.
        modal_parent_blocking = true,

        -- overrides the system locale
        -- locale = "",
    },

    decoration = {
        -- rounded corners' radius (in layout px) (range 0 to 100)
        rounding = 16,

        -- rounding power of corners (2 is a circle) (range 1 to 10)
        rounding_power = 4,

        -- opacity of active windows. (range 0 to 1)
        active_opacity = 1,

        -- opacity of inactive windows. (range 0 to 1)
        inactive_opacity = 1,

        -- opacity of fullscreen windows. (range 0 to 1)
        fullscreen_opacity = 1,

        shadow = {
            -- enable drop shadows on windows
            enabled = true,

            -- Shadow range (size) in layout px (range 0 to 100)
            range = 3,

            -- in what power to render the falloff (more power, the faster the falloff) (range 1 to 4)
            render_power = 3,

            -- whether the shadow should be sharp or not.
            sharp = true,

            -- shadow's color. Alpha dictates shadow's opacity.
            -- color is set by Stylix

            -- inactive shadow color. (if not set, will fall back to col.shadow)
            -- color_inactive is unset by default

            -- shadow's rendering offset.
            offset = { 3, 3 },

            -- shadow's scale. (range 0.05 to 2)
            scale = 1,
        },

        glow = {
            -- enable inner glow on windows
            enabled = false,

            -- glow range (size) in layout px (range 0 to 100)
            range = 4,

            -- in what power to render the falloff (more power, the faster the falloff) (range 1 to 4)
            render_power = 1,

            -- glow's color. Alpha dictates glow's opacity.
            color = "rgba(ffaaffff)",

            -- inactive glow color. (if not set, will fall back to decoration:glow:color)
            -- color_inactive is unset by default
        },

        -- enables dimming of parents of modal windows
        dim_modal = true,

        -- enables dimming of inactive windows
        dim_inactive = false,

        -- how much inactive windows should be dimmed (range 0 to 1)
        dim_strength = 0.5,

        -- how much to dim the rest of the screen by when a special workspace is open. (range 0 to 1)
        dim_special = 0.2,

        -- how much the dimaround window rule should dim by. (range 0 to 1)
        dim_around = 0.4,

        -- a path to a custom shader to be applied at the end of rendering.
        -- screen_shader = "",

        -- whether the border should be treated as a part of the window.
        border_part_of_window = true,
    },
})
