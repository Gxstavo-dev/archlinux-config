---@diagnostic disable: undefined-global


hl.on("hyprland.start", function()
    hl.exec_cmd("python3 /home/ale/.local/bin/kill-on-close.py")
    hl.exec_cmd("hyprctl plugin load /home/ale/.local/share/hyprglass/hyprglass.so")
    hl.exec_cmd("hyprctl reload")
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaybg -o eDP-1 -i /home/ale/Descargas/miku.jpg -m fill")
    hl.exec_cmd("swaybg -o HDMI-A-1 -i /home/ale/Descargas/miku.jpg -m fill")
end)
