---@diagnostic disable: lowercase-global, undefined-global
require 'cairo'
require 'conky/lua/widgets/draw_gauge_widget'
require 'conky/lua/utils/draw_text'
require 'conky/lua/utils/hex_to_rgb'

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

    local line_count = get_first_item(conky_parse("${exec wc -l conky/todos.txt}"))
    
    local total_lines;

    if (line_count == nil or line_count == '0') then
        total_lines = 0
    else
        total_lines = tonumber(line_count)
    end

    if (total_lines ~= 0) then
        local widget_height = tonumber(total_lines) * 25 + 34 - 2
        draw_rounded_rect(cr, width, widget_height, 25)

        local number_of_lines = 0
        local y = 34
        for line in io.lines("conky/todos.txt") do
            number_of_lines = number_of_lines + 1
            if (number_of_lines > 29) then
                draw_text(cr, "...", 17, y, "15")
                break
            end

            if (#line > 36) then
                line = string.sub(line, 1, 34) .. "..."
            end
            draw_text(cr, line, 17, y, "15")
            y = y + 25
        end
    end

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr = nil
end

function get_first_item(str)
    for word in string.gmatch(str, "%S+") do
        return word
    end
end

