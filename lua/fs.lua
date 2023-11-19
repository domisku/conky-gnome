---@diagnostic disable: lowercase-global, undefined-global
require 'cairo'
require 'conky/lua/widgets/draw_gauge_widget'
require 'conky/lua/utils/draw_text'
require 'conky/lua/utils/draw_image'
require 'conky/lua/utils/hex_to_rgb'
require 'conky/lua/consts/global'
require 'conky/lua/utils/get_gauge_color'

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

    draw_rounded_rect(cr, width, height, 25)

    -- fs part starts here

    draw_image(cr, "conky/icons/fs.png", 17, 17, 36, 36)
    
    local rect_start_x = 65
    cairo_rectangle(cr, rect_start_x, 17, width - 41 * 2, 6.5)
    cairo_set_source_rgba(cr, hex_to_rgb(PRIMARY_COLOR, 1))
    cairo_fill(cr)

    local fs_used = tonumber(conky_parse("${fs_used_perc}"))
    local total_fs = 100
    local gauge_length = (width - 41 * 2) / total_fs * fs_used

    cairo_rectangle(cr, rect_start_x, 17, gauge_length, 6.5)
    cairo_set_source_rgba(cr, hex_to_rgb(get_gauge_color(fs_used, total_fs), 1))
    cairo_fill(cr)

    local fs_left = conky_parse("${fs_free}")
    local fs_total = conky_parse("${fs_size}")

    draw_text(cr, fs_left .. " of " .. fs_total .. " remaining", rect_start_x, 46, "15")

    -- swap part starts here

    draw_image(cr, "conky/icons/swap.png", 17, 62, 36, 36)

    cairo_rectangle(cr, rect_start_x, 65, width - 41 * 2, 6.5)
    cairo_set_source_rgba(cr, hex_to_rgb(PRIMARY_COLOR, 1))
    cairo_fill(cr)

    local swap_perc = tonumber(conky_parse("${swapperc}"))
    local swap_used = conky_parse("${swap}")
    local swap_max = conky_parse("${swapmax}")
    local total_swap = 100
    local gauge_length = (width - 41 * 2) / total_swap * swap_perc

    cairo_rectangle(cr, rect_start_x, 65, gauge_length, 6.5)
    cairo_set_source_rgba(cr, hex_to_rgb(get_gauge_color(swap_perc, total_swap), 1))
    cairo_fill(cr)

    draw_text(cr, swap_used .. " of " .. swap_max .. " used", rect_start_x, 93, "15")

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr = nil
end

