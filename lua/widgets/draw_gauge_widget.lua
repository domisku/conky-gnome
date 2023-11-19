require 'conky/lua/utils/draw_rounded_rect'
require 'conky/lua/utils/draw_image'
require 'conky/lua/utils/draw_circle'
require 'conky/lua/consts/global'
require 'conky/lua/utils/get_gauge_color'

function draw_gauge_widget(width, height, value, max_value, img_url)
    draw_rounded_rect(cr, width, height, BORDER_RADIUS)

    draw_circle(cr, width, height, 30, 6.5, 0, 2 * math.pi, PRIMARY_COLOR)

    max_value = max_value or 100
    local end_angle = (value / max_value) * 360
    local gauge_color = get_gauge_color(value, max_value)

    draw_circle(cr, width, height, 30, 7, (-90) *
    (math.pi / 180), (end_angle - 90) * (math.pi / 180), gauge_color)

    draw_image(cr, img_url, 30.5, 30, 36, 36)
end