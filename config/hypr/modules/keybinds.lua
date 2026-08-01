---@diagnostic disable: undefined-global

local vars = require("modules.variables")
local m = vars.mainMod

hl.bind(m .. " + RETURN", hl.dsp.exec_cmd(vars.terminal))
hl.bind(m .. " + C", hl.dsp.window.close())
-- hl.bind(m .. " + M",
--     hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"))
hl.bind(m .. " + M", hl.dsp.exit())
hl.bind(m .. " + E", hl.dsp.exec_cmd(vars.fileManager))
hl.bind(m .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(m .. " + R", hl.dsp.exec_cmd(vars.menu))
hl.bind(m .. " + P", hl.dsp.window.pseudo())
hl.bind(m .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(m .. " + F", hl.dsp.exec_cmd(vars.brave))
hl.bind(m .. " + Q", hl.dsp.exec_cmd(vars.code))
hl.bind(m .. " + BackSpace", hl.dsp.exec_cmd("ghostty"))
hl.bind(m .. " + D", hl.dsp.exec_cmd("bash ~/.config/rofi/launchers/type-1/launcher.sh"))

-- Mover foco con mainMod + flechas
hl.bind(m .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(m .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(m .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(m .. " + down", hl.dsp.focus({ direction = "down" }))

-- Cambiar / mover a workspaces 1-10
for i = 1, 10 do
    local key = i % 10 -- 10 → tecla 0
    hl.bind(m .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(m .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scratchpad
hl.bind(m .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(m .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll entre workspaces con rueda del ratón
hl.bind(m .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(m .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Mover/redimensionar ventanas con ratón
hl.bind(m .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(m .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia / brillo
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
