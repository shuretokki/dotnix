-- 0.57.1
-- https://wiki.hypr.land/configuring/core/config-options/

hl.config({
    decoration = {
        blur = {
            -- enable window background blur
            enabled = false,

            -- set the blur variant. Blur variants enhance regular blur, but may increase GPU and CPU usage, significantly so if they are animated. (range 0 to 10; options: kawase = 0, frost = 1, ripple = 2, drops = 3, water = 4, fluid_jar = 5, prism = 6, heat_shimmer = 7, acrylic = 8, aurora = 9, haze = 10)
            variant = 0,

            -- blur size (distance) (range 0 to 100)
            size = 8,

            -- the amount of passes to perform (range 0 to 10)
            passes = 3,

            -- make the blur layer ignore the opacity of the window
            ignore_opacity = true,

            -- whether to enable further optimizations to the blur.
            new_optimizations = true,

            -- if enabled, floating windows will ignore tiled windows in their blur.
            xray = false,

            -- if enabled, blur strength will be proportional to pixel opacity
            proportional = false,

            -- how much noise to apply. (range 0 to 1)
            noise = 0.0117,

            -- contrast modulation for blur. (range 0 to 2)
            contrast = 0.8916,

            -- brightness modulation for blur. (range 0 to 2)
            brightness = 1,

            -- Increase saturation of blurred colors. (range 0 to 1)
            vibrancy = 0.1696,

            -- How strong the effect of vibrancy is on dark areas. (range 0 to 1)
            vibrancy_darkness = 0,

            -- whether to blur behind the special workspace (note: expensive)
            special = false,

            -- whether to blur popups (e.g. right-click menus)
            popups = false,

            -- works like ignorealpha in layer rules. If pixel opacity is below set value, will not blur. (range 0 to 1)
            popups_ignorealpha = 0.2,

            -- whether to blur input methods (e.g. fcitx5)
            input_methods = false,

            -- works like ignorealpha in layer rules. If pixel opacity is below set value, will not blur. (range 0 to 1)
            input_methods_ignorealpha = 0.2,

            glass = {
                -- maximum refraction displacement for glass blur types in pixels (range 0 to 20)
                refraction = 20.0,

                -- pattern size for glass blur types in pixels (range 4 to 512)
                size = 40.0,

                -- strength of the glass relief shading (range 0 to 1)
                roughness = 1.0,
            },

            acrylic = {
                -- maximum acrylic lens displacement in pixels (range 0 to 48)
                refraction = 24.0,

                -- width of the curved acrylic edge in pixels (range 4 to 256)
                bulb = 48.0,

                -- amount of sharp backdrop transmitted through the acrylic surface (range 0 to 1)
                clarity = 0.82,

                -- relative chromatic separation in the acrylic lens (range 0 to 0.25)
                aberration = 0.025,

                -- acrylic tint color. Alpha controls optical absorption.
                tint = "rgba(eef5ff14)",
            },

            drops = {
                -- animation speed for drops blur. 0 disables the animation. Enabling will significantly increase GPU usage. (range 0 to 10)
                speed = 3.0,
            },

            heat_shimmer = {
                -- animation speed for heat shimmer blur. 0 disables the animation. Enabling will increase GPU usage. (range 0 to 10)
                speed = 1.0,
            },

            aurora = {
                -- animation speed for aurora blur. 0 freezes the animation. Enabling will increase GPU usage. (range 0 to 10)
                speed = 1.0,

                -- strength of the aurora color contribution (range 0 to 1)
                intensity = 0.35,

                -- first aurora curtain color. Alpha controls its contribution.
                color1 = "rgba(f0a0ff29)",

                -- second aurora curtain color. Alpha controls its contribution.
                color2 = "rgba(4dffff7a)",
            },

            haze = {
                -- strength of the haze pearlescent sheen (range 0 to 1)
                intensity = 0.35,

                -- strength of the haze pearlescent color shift (range 0 to 1)
                iridescence = 0.7,
            },

            ripple = {
                -- maximum refraction displacement of click ripples in pixels (range 0 to 32)
                strength = 30.0,

                -- maximum radius of click ripples in pixels (range 1 to 1000)
                radius = 400.0,

                -- width of click ripple waves in pixels (range 1 to 200)
                width = 32.0,

                -- duration of click ripples in seconds (range 0.05 to 5)
                duration = 0.45,
            },

            water = {
                -- maximum refraction displacement and injection strength for water blur in pixels (range 0 to 32)
                strength = 32.0,

                -- pointer radius for water blur in pixels (range 1 to 1000)
                radius = 20.0,

                -- propagation speed for water blur (range 0 to 10)
                speed = 0.76,

                -- decay damping for water blur (range 0 to 1)
                damping = 0.95,

                -- maximum water blur animation duration in seconds (range 0.5 to 60)
                duration = 12.0,
            },

            fluid_jar = {
                -- fluid color for fluid jar blur
                color = "rgba(3399ffcc)",

                -- animation speed for fluid jar blur (range 0 to 10)
                speed = 3.7,

                -- fill amount for fluid jar blur (range 0 to 1)
                fill_amount = 0.5,

                -- inertial mass for fluid jar blur (range 0.1 to 10)
                mass = 1.4,

                -- fluid simulation precision multiplier. 2x is a good compromise. 4x is expensive. 8x is extreme and unnecessary. (range 0.5 to 8)
                precision = 2.0,

                -- interior fluid turbulence multiplier (range 0 to 5)
                turbulence = 1.2,

                -- fluid refraction distortion multiplier (range 0 to 10)
                distortion = 8.0,
            },
        },
    },
})
