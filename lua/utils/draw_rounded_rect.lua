require 'conky/lua/utils/hex_to_rgb'
require 'conky/lua/consts/global'

function draw_rounded_rect(cr, width, height, border_radius, y)
    cairo_move_to(cr, border_radius, y)
	cairo_line_to(cr, width - border_radius, y)
	cairo_curve_to(cr, width, y, width, y, width, border_radius)
	cairo_line_to(cr, width, height - border_radius)
	cairo_curve_to(cr, width, height, width, height, width - border_radius, height)
	cairo_line_to(cr, border_radius, height)
	cairo_curve_to(cr, y, height, y, height, y, height - border_radius)
	cairo_line_to(cr, y, border_radius)
	cairo_curve_to(cr, y, y, y, y, border_radius, y)
	cairo_close_path(cr)

	cairo_set_source_rgba(cr, hex_to_rgb(BACKGROUND_COLOR, 0.8))
	cairo_fill(cr)
end