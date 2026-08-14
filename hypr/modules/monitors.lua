------------------
---- MONITORS ----
------------------
hl.monitor({
    output = "eDP-1",
    mode = "1366x768@60",
    position = "0x0",
    scale = 1,
})

-- ── Reacción dinámica a monitores externos ──────────────────
hl.on("monitor.added", function(m)
    hl.exec_cmd("~/.config/hypr/scripts/monitor-autodetect.sh " .. m.name)

    hl.timer(function()
        local f = io.open("/tmp/hypr-monitor-make", "r")
        local make = f and f:read("*l") or nil
        if f then f:close() end

        local matched = make and make:lower():find("lg")

        if matched then
            hl.monitor({ output = m.name, mode = "1920x1080@60", position = "0x0", scale = 1, mirror = "eDP-1" })
            hl.notification.create({ text = "🖥️ TV LG detectada — modo espejo", timeout = 3000, icon = "ok" })
        else
            hl.monitor({ output = m.name, mode = "preferred", position = "auto-right", scale = 1 })
            hl.notification.create({ text = "🖥️ Monitor externo detectado — modo extendido", timeout = 3000, icon = "ok" })
        end
    end, { timeout = 600, type = "oneshot" })
end)
