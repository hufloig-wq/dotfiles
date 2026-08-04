-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("pkill -9 -f dropbox; true")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("snixembed --fork")
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("waypaper --restore")
    hl.exec_cmd("while true; do ~/.config/waybar/battery-notify.sh; sleep 60; done &")
    hl.exec_cmd("hyprsunset")
end)
