require 'conky/lua/consts/global'

function get_gauge_color(value, max_value)
    local gauge_color

    if (tonumber(value) < max_value / 2) then
        gauge_color = GAUGE_LOW_COLOR
    elseif (tonumber(value) < max_value / 4 * 3) then
        gauge_color = GAUGE_MEDIUM_COLOR
    else
        gauge_color = GAUGE_HIGH_COLOR
    end

    return gauge_color
end