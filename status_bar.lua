local wezterm = require('wezterm')

local nf = wezterm.nerdfonts
local M = {}

-- Separador para la barra de estado
local SEPARATOR_CHAR = nf.oct_dash .. ' '

-- Íconos de batería para diferentes niveles de carga
local discharging_icons = {
    nf.md_battery_10,
    nf.md_battery_20,
    nf.md_battery_30,
    nf.md_battery_40,
    nf.md_battery_50,
    nf.md_battery_60,
    nf.md_battery_70,
    nf.md_battery_80,
    nf.md_battery_90,
    nf.md_battery,
}

local charging_icons = {
    nf.md_battery_charging_10,
    nf.md_battery_charging_20,
    nf.md_battery_charging_30,
    nf.md_battery_charging_40,
    nf.md_battery_charging_50,
    nf.md_battery_charging_60,
    nf.md_battery_charging_70,
    nf.md_battery_charging_80,
    nf.md_battery_charging_90,
    nf.md_battery_charging,
}

-- Colores para la barra de estado
local colors = {
    date_fg = '#fab387',
    date_bg = 'rgba(0, 0, 0, 0.4)',
    battery_fg = '#f9e2af',
    battery_bg = 'rgba(0, 0, 0, 0.4)',
    separator_fg = '#74c7ec',
    separator_bg = 'rgba(0, 0, 0, 0.4)',
}

local __cells__ = {} -- Lista de celdas para el formato de la barra de estado

-- Función para agregar una celda de formato a la lista
---@param text string
---@param icon string
---@param fg string
---@param bg string
---@param separate boolean
local _push = function(text, icon, fg, bg, separate)
    table.insert(__cells__, { Foreground = { Color = fg } })
    table.insert(__cells__, { Background = { Color = bg } })
    table.insert(__cells__, { Attribute = { Intensity = 'Bold' } })
    table.insert(__cells__, { Text = icon .. ' ' .. text .. ' ' })

    if separate then
        table.insert(__cells__, { Foreground = { Color = colors.separator_fg } })
        table.insert(__cells__, { Background = { Color = colors.separator_bg } })
        table.insert(__cells__, { Text = SEPARATOR_CHAR })
    end
end

-- Función para agregar la fecha actual a la barra de estado
local _set_date = function()
    local date = wezterm.strftime(' %a %H:%M:%S')
    _push(date, nf.fa_calendar, colors.date_fg, colors.date_bg, true)
end

-- Función para agregar el estado de la batería a la barra de estado
local _set_battery = function()
    -- Información de la batería
    local charge = ''
    local icon = ''

    for _, b in ipairs(wezterm.battery_info()) do
        local idx = math.max(1, math.min(10, math.floor(b.state_of_charge * 10)))
        charge = string.format('%.0f%%', b.state_of_charge * 100)

        if b.state == 'Charging' then
            icon = charging_icons[idx]
        else
            icon = discharging_icons[idx]
        end
    end

    _push(charge, icon, colors.battery_fg, colors.battery_bg, false)
end

-- Configura el evento de actualización de la barra de estado
M.setup = function()
    wezterm.on('update-right-status', function(window, _pane)
        __cells__ = {}
        _set_date()
        _set_battery()

        window:set_right_status(wezterm.format(__cells__))
    end)
end

return M
