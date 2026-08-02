---@diagnostic disable: undefined-global

if hl.plugin.hyprglass then
    local hg = hl.plugin.hyprglass

    hg.config({
        default_theme  = "dark",
        default_preset = "clear",
        manage_window_blur = 1,
        layers         = { enabled = 1 },
    })

    hg.layer("waybar", { preset = "clear", mask_threshold = 0.05 })
end

-- Desactivar el efecto en pantalla completa (rendimiento)
hl.window_rule({
    match = { fullscreen = true },
    tag   = "+hyprglass_disabled",
})
