-- Defaults from Hyprland 0.57.1. Documentation: https://wiki.hypr.land/configuring/core/config-options/

hl.config({
    group = {
        -- whether new windows in a group spawn after current or at group tail
        insert_after_current = true,

        -- whether Hyprland should focus on the window that has just been moved out of the group
        focus_removed_window = true,

        -- whether window groups can be dragged into other groups
        merge_groups_on_drag = true,

        -- whether one group will be merged with another when dragged into its groupbar
        merge_groups_on_groupbar = true,

        col = {
            -- active group border color
            border_active = "rgba(ffff0066)",

            -- inactive group border color
            border_inactive = "rgba(77770066)",

            -- inactive locked group border color
            border_locked_inactive = "rgba(ff550066)",

            -- active locked group border color
            border_locked_active = "rgba(77550066)",
        },

        -- automatically group new windows
        auto_group = true,

        -- whether dragging a window into a unlocked group will merge them. (range 0 to 2; options: disabled = 0, enabled = 1, only_into_groupbar = 2)
        drag_into_group = 1,

        -- whether dragging a floating window into a tiled window groupbar will merge them
        merge_floated_into_tiled_on_groupbar = false,

        -- whether using movetoworkspace[silent] will merge the window into the workspace's solitary unlocked group
        group_on_movetoworkspace = false,

        groupbar = {
            -- enables groupbars
            enabled = true,

            -- disable if contains single window. Considered only if enabled == true
            disable_when_only = false,

            -- font used to display groupbar titles
            font_family = "[[EMPTY]]",

            -- weight of the font used to display active groupbar titles
            -- font_weight_active has no simple default in the source (None)

            -- weight of the font used to display inactive groupbar titles
            -- font_weight_inactive has no simple default in the source (None)

            -- font size of groupbar title (range 2 to 64)
            font_size = 8,

            -- enables gradients
            gradients = false,

            -- height of the groupbar (range 1 to 64)
            height = 14,

            -- height of the gap between the groupbar indicator and title (range 0 to 64)
            indicator_gap = 0,

            -- height of the groupbar indicator (range 0 to 64)
            indicator_height = 3,

            -- render the groupbar as a vertical stack
            stacked = false,

            -- sets the decoration priority for groupbars (range 0 to 6)
            priority = 3,

            -- whether to render titles in the group bar decoration
            render_titles = true,

            -- whether scrolling in the groupbar changes group active window
            scrolling = true,

            -- whether middle clicking the groupbar closes the clicked window
            middle_click_close = true,

            -- how much to round the groupbar (range 0 to 40)
            rounding = 1,

            -- rounding power of groupbar corners (2 is a circle) (range 1 to 10)
            rounding_power = 2,

            -- how much to round the groupbar gradient (range 0 to 40)
            gradient_rounding = 2,

            -- rounding power of groupbar gradient corners (2 is a circle) (range 1 to 10)
            gradient_rounding_power = 2,

            -- if yes, will only round at the groupbar edges
            round_only_edges = true,

            -- if yes, will only round at the groupbar gradient edges
            gradient_round_only_edges = true,

            -- color for window titles in the groupbar
            text_color = "rgba(ffffffff)",

            -- color for inactive windows' titles in the groupbar
            -- text_color_inactive is unset by default

            -- color for the active window's title in a locked group
            -- text_color_locked_active is unset by default

            -- color for inactive windows' titles in locked groups
            -- text_color_locked_inactive is unset by default

            col = {
                -- active group border color
                active = "rgba(ffff0066)",

                -- inactive (out of focus) group border color
                inactive = "rgba(77770066)",

                -- active locked group border color
                locked_active = "rgba(ff550066)",

                -- inactive locked group border color
                locked_inactive = "rgba(77550066)",
            },

            -- gap between gradients and window (range 0 to 20)
            gaps_out = 2,

            -- gap between gradients (range 0 to 20)
            gaps_in = 2,

            -- keep an upper gap above gradient
            keep_upper_gap = true,

            -- set an offset for a text (range -20 to 20)
            text_offset = 0,

            -- set horizontal padding for a text (range 0 to 22)
            text_padding = 0,

            -- enable background blur for groupbars
            blur = false,
        },
    },
})
