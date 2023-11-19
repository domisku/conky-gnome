require 'conky/lua/utils/hex_to_rgb'

function draw_circle(cr, width, height, radius, line_width, start_angle, end_angle, color, opacity) 
    local opacity = opacity or 1

    cairo_set_source_rgba(cr, hex_to_rgb(color, opacity))
    cairo_set_line_width(cr, line_width)
    cairo_arc(cr, width / 2, height / 2, radius, start_angle, end_angle)
    cairo_stroke(cr)
end