local wezterm = require("wezterm")
local status_bar = require("status_bar")

-- Define la tabla de configuración
local config = {}

-- Configura la opacidad del fondo de la ventana
config.window_background_opacity = 0.90

-- Tamaño de la fuente
config.font_size = 9

-- Configura el esquema de colores
config.color_scheme = "Synthwave (Gogh)"

-- Configura la fuente
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold", italic = true })

-- Llamar al metodo de la configuracion de la barra de tarea de la terminal
status_bar.setup()

-- Configura el cursor
config.cursor_blink_rate = 700
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- Configuración de la barra de estado
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = true
config.tab_max_width = 25
config.show_tab_index_in_tab_bar = true
config.switch_to_last_active_tab_when_closing_tab = true

-- Define el menú de lanzamiento

config.launch_menu = {
	{
		-- Comando para abrir el terminal en Ubuntu nativo
		label = "Ubuntu Terminal",
		args = { "/bin/zsh" }, -- O "/bin/zsh" si usas zsh como shell
	},
}

-- Devuelve la tabla de configuración
return config
