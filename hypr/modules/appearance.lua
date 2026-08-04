--------------------
---- LOOK & FEEL ---
--------------------
hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 5,
        border_size = 2,
        col = {
            active_border = { colors = { "rgba(ffffffff)", "rgba(888888ee)" }, angle = 45 },
            inactive_border = "rgba(444444aa)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 8,
        active_opacity = 1.0,
        inactive_opacity = 0.92,
        fullscreen_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 8,
            render_power = 3,
            color = 0xee1a1a1a,
        },

        blur = {
            enabled = true,
            size = 8,
            passes = 3,
            noise = 0.02,
            contrast = 1.15,
            brightness = 0.9,
            vibrancy = 0.2,
        },
    },
})
