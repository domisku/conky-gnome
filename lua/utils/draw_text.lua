require 'conky/lua/utils/hex_to_rgb'
require 'conky/lua/consts/global'

function draw_text(cr, text, x, y, font_size)
    font = conky_parse("${font}")
    font_slant = CAIRO_FONT_SLANT_NORMAL
    font_face = CAIRO_FONT_WEIGHT_NORMAL

    cairo_select_font_face(cr, font, font_slant, font_face);
    cairo_set_font_size(cr, font_size)
    cairo_set_source_rgba(cr, hex_to_rgb(PRIMARY_COLOR, 1))
    cairo_move_to(cr, x, y)
    cairo_show_text(cr, text)
    cairo_stroke(cr)
end