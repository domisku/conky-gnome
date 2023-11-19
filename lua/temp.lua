---@diagnostic disable: lowercase-global, undefined-global
require 'cairo'
require 'conky/lua/widgets/draw_gauge_widget'

function conky_main ()
    if conky_window == nil then
        return
    end

    local width = conky_window.width
	local height = conky_window.height
    local cs = cairo_xlib_surface_create(conky_window.display,
                                         conky_window.drawable,
                                         conky_window.visual,
                                         width,
                                         height)
    cr = cairo_create(cs)

    draw_gauge_widget(width, height, conky_parse("${acpitemp}"), 100, "conky/icons/temp.png")

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr = nil
end

