--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- (tus reglas existentes: pavucontrol, wofi, waypaper — sin tocar)

-- ── Workspace 9 dedicado al monitor externo (TV / viajes) ────
hl.workspace_rule({
    workspace = "9",
    monitor = "HDMI-A-1",
    persistent = true,
})

-- ── Juegos → monitor externo en fullscreen automático ─────────
hl.window_rule({
    name = "hollow-knight-external",
    match = { class = "Hollow Knight" },
    workspace = "9",
    fullscreen = true,
})

hl.window_rule({
    name = "hollow-knight-silksong-external",
    match = { class = "Hollow Knight Silksong" },
    workspace = "9",
    fullscreen = true,
})

-- ── Reproductores de video → monitor externo en fullscreen ────
hl.window_rule({
    name = "mpv-external",
    match = { class = "mpv" },
    workspace = "9",
    fullscreen = true,
})

hl.window_rule({
    name = "vlc-external",
    match = { class = "vlc" },
    workspace = "9",
    fullscreen = true,
})
