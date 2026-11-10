-- Defaults from Hyprland 0.57.1. Documentation: https://wiki.hypr.land/configuring/core/config-options/

hl.config({
    opengl = {
        -- reduces flickering on nvidia at the cost of possible frame drops on lower-end GPUs.
        nvidia_anti_flicker = true,
    },

    render = {
        -- Enables direct scanout. (range 0 to 2; options: disable = 0, enable = 1, auto = 2)
        direct_scanout = 0,

        -- Whether to expand textures that have not yet resized to be larger.
        expand_undersized_textures = true,

        -- Disable back buffer and bottom layer rendering.
        xp_mode = false,

        -- Whether to enable a fade animation for CTM changes. (range 0 to 2; options: disable = 0, enable = 1, auto = 2)
        ctm_animation = 2,

        -- Enable Color Management pipelines (requires restart to fully take effect)
        cm_enabled = true,

        -- Report content type to allow monitor profile autoswitch
        send_content_type = true,

        -- Auto-switch to hdr mode when fullscreen app is in hdr (range 0 to 2; options: disable = 0, hdr = 1, hdredid = 2)
        cm_auto_hdr = 1,

        -- enable new render scheduling, which should improve FPS on underpowered devices.
        new_render_scheduling = false,

        -- Submit eligible output commits asynchronously.
        async_commit = false,

        -- Enable CM without shader. (range 0 to 3; options: disable = 0, always = 1, ondemand = 2, ignore = 3)
        non_shader_cm = 3,

        -- Default transfer function for displaying SDR apps.
        cm_sdr_eotf = "default",

        -- Enable commit timing proto. Requires restart
        commit_timing_enabled = true,

        -- Enable sending VCGT ramps to KMS with ICC profiles
        icc_vcgt_enabled = true,

        -- Use experimental blurred bg blending
        use_shader_blur_blend = false,

        -- Use experimental internal FP16 buffer. (range 0 to 2; options: disable = 0, enable = 1, auto = 2)
        use_fp16 = 2,

        -- Keep umodified SDR frame copy for sreensharing. (range 0 to 2; options: disable = 0, enable = 1, auto = 2)
        keep_unmodified_copy = 2,

        -- non_shader_cm interaction with ctm proto (hyprsunset and similar). (range 0 to 2; options: disable = 0, enable = 1, auto = 2)
        non_shader_cm_interop = 2,

        -- Internal workbuffer transfer function for fp16 in SDR mode (range 0 to 1; options: monitor = 0, linear = 1)
        fp16_sdr_tf = 0,

        -- Control fifo locking for not shown surfaces. always - use fifo lock for any surface, ignore_unfocused - ignore render_unfocused windows, never - skip locking invisible surfaces (range 0 to 2; options: always = 0, ignore_unfocused = 1, never = 2)
        not_shown_fifo_lock = 0,
    },

    debug = {
        -- print the debug performance overlay.
        overlay = false,

        -- flash damaged areas
        damage_blink = false,

        -- enable OpenGL debugging and error checking.
        gl_debugging = false,

        -- disable logging to a file
        disable_logs = true,

        -- disables time logging
        disable_time = true,

        -- redraw only the needed bits of the display. (range 0 to 2; options: disable = 0, monitor = 1, full = 2)
        damage_tracking = 2,

        -- enables logging to stdout
        enable_stdout_logs = false,

        -- set to 1 and then back to 0 to crash Hyprland. (range 0 to 1)
        manual_crash = 0,

        -- if true, do not display config file parsing errors.
        suppress_errors = false,

        -- disables verification of the scale factors.
        disable_scale_checks = false,

        -- limits the number of displayed config file parsing errors. (range 0 to 20)
        error_limit = 5,

        -- sets the position of the error bar. (range 0 to 1; options: top = 0, bottom = 1)
        error_position = 0,

        -- enables colors in the stdout logs.
        colored_stdout_logs = true,

        -- enables logging the damage.
        log_damage = false,

        -- enables render pass debugging.
        pass = false,

        -- claims support for all cm proto features (requires restart)
        full_cm_proto = false,

        -- Special case for DS with unmodified buffer
        ds_handle_same_buffer = true,

        -- Special case for DS with unmodified buffer unlocks fifo
        ds_handle_same_buffer_fifo = true,

        -- Render solitary window with empty damage
        render_solitary_wo_damage = false,

        -- controls the VFR status of Hyprland. Do not turn off unless debugging
        vfr = true,

        -- allow buffer invalidation. (range 0 to 1; options: disable = 0, enable = 1)
        invalidate_buffers = 1,
    },

    experimental = {
        -- Allow wp-cm-v1 version 2
        wp_cm_1_2 = true,
    },
})
