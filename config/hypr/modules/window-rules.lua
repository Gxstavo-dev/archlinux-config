---@diagnostic disable: undefined-global

-- Ignorar solicitudes de maximize
hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix arrastre en XWayland
hl.window_rule({
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- hyprland-run
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

-- Tamaño mínimo para ventanas flotantes
hl.window_rule({
    name     = "max-float-size",
    match    = { float = true, fullscreen = false },
    min_size = "1100 600",
})

-- Float por defecto para todas las ventanas
hl.window_rule({
    name   = "default-float",
    match  = { class = ".*" },
    float  = true,
    size   = "1100 600",
    center = true,
})
