---------------------
---- KEYBINDINGS ----
---------------------
local programs = require("modules.programs")
local mainMod = programs.mainMod

-- ── Apps ─────────────────────────────────────────────
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(programs.menu))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(programs.browser))

-- ── Ventanas ─────────────────────────────────────────
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 0 })) -- ⚠ verificar
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + Tab", hl.dsp.window.cycle_next())

-- ── Sistema ──────────────────────────────────────────
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("waypaper --random"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("~/.config/waybar/power-menu.sh"))

-- ── Screenshots ──────────────────────────────────────
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("hyprshot -m window"))

-- ── Foco con flechas ─────────────────────────────────
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- ── Mover ventanas ───────────────────────────────────
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.swap({ direction = "left" }))   -- ⚠ verificar
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" })) -- ⚠ verificar
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.swap({ direction = "up" }))       -- ⚠ verificar
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.swap({ direction = "down" }))   -- ⚠ verificar

-- ── Redimensionar ventanas ───────────────────────────
hl.bind(mainMod .. " + ALT + left", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))  -- ⚠ verificar
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))  -- ⚠ verificar
hl.bind(mainMod .. " + ALT + up", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))    -- ⚠ verificar
hl.bind(mainMod .. " + ALT + down", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))   -- ⚠ verificar

-- ── Workspaces ───────────────────────────────────────
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- ── Scratchpad ───────────────────────────────────────
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- ── Mouse + workspace ────────────────────────────────
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ── Multimedia ───────────────────────────────────────
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
