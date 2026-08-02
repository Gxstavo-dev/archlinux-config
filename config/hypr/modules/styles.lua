---@diagnostic disable: undefined-global


hl.config({
    general = {
        gaps_in          = 5,
        gaps_out         = 15,
        border_size      = 0,
        col              = {
            active_border   = { colors = { "rgba(00000000)" }, angle = 45 },
            inactive_border = "rgba(00000000)",
        },
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding         = 10,
        rounding_power   = 10,
        active_opacity   = 0.88,
        inactive_opacity = 0.8,
        shadow           = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },
        blur             = {
            enabled  = true,
            size     = 8,
            passes   = 3,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },

    input = {
        kb_layout    = "es",
        kb_variant   = "",
        kb_model     = "",
        kb_options   = "",
        kb_rules     = "",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad     = {
            natural_scroll = false,
        },
    },
})

hl.layer_rule({
  match = { namespace = "^qs-.*" },
  blur = true,
  ignore_alpha = 0.0,
})

hl.layer_rule({
  match = { namespace = "^waybar.*" },
  blur = true,
  ignore_alpha = 0.0,
})
