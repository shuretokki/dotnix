-- Defaults from Hyprland 0.57.1. Documentation: https://wiki.hypr.land/configuring/core/config-options/

hl.config({
    decoration = {
        motion_blur = {
            -- enable motion blur for moving and resizing windows
            enabled = false,

            -- amount of samples used for motion blur (range 1 to 64)
            samples = 7,
        },

        wobble = {
            -- enable wobble deformation for moving and resizing windows
            enabled = false,

            -- amount of wobble mesh vertices per edge (range 2 to 32)
            mesh = 12,

            -- spring stiffness for wobble deformation (range 0.0001 to 1000)
            stiffness = 200,

            -- spring damping for wobble deformation (range 0 to 1000)
            damping = 12,

            -- spring mass for wobble deformation (range 0.0001 to 1000)
            mass = 1,

            -- wobble deformation impulse multiplier (range 0 to 2)
            intensity = 0.2,

            -- position epsilon below which wobble is considered stable (range 0 to 100)
            value_epsilon = 0.25,

            -- velocity epsilon below which wobble is considered stable (range 0 to 1000)
            velocity_epsilon = 2,
        },
    },

    animations = {
        -- enable animations
        enabled = true,

        -- changes the direction of slide animations between the first and last workspaces
        workspace_wraparound = false,
    },
})
