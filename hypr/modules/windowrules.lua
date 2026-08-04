--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Pavucontrol flotante
hl.window_rule({
    name = "float-pavucontrol",
    match = { class = "pavucontrol" },
    float = true,
    size = "700 500",
    center = true,
})

-- Wofi flotante
hl.window_rule({
    name = "float-wofi",
    match = { class = "wofi" },
    float = true,
    center = true,
})

-- Waypaper flotante
hl.window_rule({
    name = "float-waypaper",
    match = { class = "waypaper" },
    float = true,
    center = true,
})

-- Nautilus flotante (comentado en tu .conf original, lo dejo igual)
-- hl.window_rule({
--     name = "float-nautilus",
--     match = { class = "org.gnome.Nautilus" },
--     float = true,
--     size = "900 600",
--     center = true,
-- })
