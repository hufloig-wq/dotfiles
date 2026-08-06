--------------------
---- LOOK & FEEL ---
--------------------
hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 5,
        border_size = 2,
        col = {
            active_border = { colors = { "rgba(fabd2fee)", "rgba(fe8019ee)" }, angle = 45 },
            inactive_border = "rgba(504945aa)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 8,
        active_opacity = 1.0,
        inactive_opacity = 0.70,
        fullscreen_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 12,
            render_power = 3,
            color = 0xee1a1a1a,
            scale = 0.97,
        },

        blur = {
            enabled = true,
            size = 10,
            passes = 4,
            noise = 0.015,
            contrast = 1.2,
            brightness = 0.85,
            vibrancy = 0.35,
            vibrancy_darkness = 0.2,
        },
    },
})
