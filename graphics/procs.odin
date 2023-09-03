package playdate_graphics

make_rect :: #force_inline proc(x, y, width, height: i32) -> Rect {
    r := Rect { 
        left    = x, 
        right   = x + width, 
        top     = y, 
        bottom  = y + height,
    }

    return r
}

rect_translate :: #force_inline proc (rect: Rect, delta_x, delta_y: i32) -> Rect {
    r := Rect {
        left    = rect.left + delta_x,
        right   = rect.right + delta_x,
        top     = rect.top + delta_y,
        bottom  = rect.bottom + delta_y,
    }
    return r
}

make_pattern :: proc {
    make_pattern_full,
    make_pattern_opaque,
}
make_pattern_full :: #force_inline proc(r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, ra, rb, rc, rd, re, rf: u8) -> Pattern {
    return {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, ra, rb, rc, rd, re, rf}
}
make_pattern_opaque :: #force_inline proc(r0, r1, r2, r3, r4, r5, r6, r7: u8) -> Pattern {
    return Pattern{r0, r1, r2, r3, r4, r5, r6, r7, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff}
}


clear :: proc(color: Color)

set_background_color :: proc(color: Solid_Color)

// DEPRECATED in favor of set_stencil_image, which adds a "tile" flag
set_stencil :: proc(stencil: ^Bitmap)

set_draw_mode :: proc(draw_mode: Bitmap_Draw_Mode)
set_draw_offset :: proc(delta_x, delta_y: i32)
set_clip_rect :: proc(x, y, width, height: i32) 
clear_clip_rect :: proc()
set_line_cap_style :: proc(style: Line_Cap_Style)
set_font :: proc(font: ^Font)
set_text_tracking :: proc(tracking: i32)
push_context :: proc(target: ^Bitmap)
pop_context :: proc()

draw_bitmap :: proc(bitmap: ^Bitmap, x, y: i32, flip: Bitmap_Flip = .unflipped)
tile_bitmap :: proc(bitmap: ^Bitmap, x, y, width, height: i32, flip: Bitmap_Flip = .unflipped)
draw_line :: proc(x1, y1, x2, y2, width: i32, color: Color)
fill_triangle :: proc(x1, y1, x2, y2, x3, y3: i32, color: Color)
draw_rect :: proc(x, y, width, height: i32, color: Color)
fill_rect :: proc(x, y, width, height: i32, color: Color)
draw_ellipse :: proc(x, y, width, height, line_width: i32, start_angle, end_angle: f32, color: Color)
fill_ellipse :: proc(x, y, width, height: i32, start_angle, end_angle: f32, color: Color)
draw_scaled_bitmap :: proc(bitmap: Bitmap, x, y: i32, x_scale, y_scale: f32)

draw_text :: proc {
    draw_text_cstring,
    draw_text_string,
}
draw_text_cstring :: proc(text: cstring, length: u32, encoding: String_Encoding, x, y: i32) -> i32 { panic("Not implemented")}
draw_text_string :: proc(text: string, encoding: String_Encoding = .utf8, x, y: i32) -> i32 {panic("Not implemented")}


new_bitmap :: proc(width, height: i32, background_color: Color) -> ^Bitmap
free_bitmap :: proc(bitmap: ^Bitmap)
load_bitmap :: proc(path: cstring, out_error: ^cstring) -> ^Bitmap
copy_bitmap :: proc(bitmap: ^Bitmap) -> ^Bitmap
load_into_bitmap :: proc(path: cstring, bitmap: ^Bitmap, out_error: ^cstring)
get_bitmap_data :: proc(bitmap: ^Bitmap, width, height, row_bytes: ^i32, mask: [^]u8, data: [^]u8)
clear_bitmap :: proc(bitmap: ^Bitmap, background_color: Color)
rotated_bitmap :: proc(bitmap: ^Bitmap, rotation, x_scale, y_scale: f32, allocated_size: ^i32) -> ^Bitmap

load_font :: proc(path: cstring, out_error: ^cstring) -> ^Font
get_font_page :: proc(font: ^Font, c: u32) -> ^Font_Page
get_page_glyph :: proc(page: ^Font_Page, c: u32, bitmap: ^^Bitmap) -> (glyph: ^Font_Glyph, advance: bool)
get_glyph_kerning :: proc()
get_text_width :: proc()

set_stencil_image :: proc(stencil: ^Bitmap, tile: bool)

