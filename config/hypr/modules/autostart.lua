---@diagnostic disable: undefined-global


hl.on("hyprland.start", function()
    hl.exec_cmd("swaybg -o eDP-1 -i /mnt/hdd/Descargas/montain.jpg -m fill")
    hl.exec_cmd("swaybg -o HDMI-A-1 -i /mnt/hdd/Descargas/montain.jpg -m fill")
    hl.exec_cmd("qs --path ~/.config/quickshell/shell.qml")
end)
