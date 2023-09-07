package playdate_graphics

make_rect :: #force_inline proc "contextless" (x, y, width, height: i32) -> Rect {
    r := Rect { 
        left    = x, 
        right   = x + width, 
        top     = y, 
        bottom  = y + height,
    }

    return r
}

rect_translate :: #force_inline proc "contextless" (rect: Rect, delta_x, delta_y: i32) -> Rect {
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
make_pattern_full :: #force_inline proc "contextless" (r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, ra, rb, rc, rd, re, rf: u8) -> Pattern {
    return {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, ra, rb, rc, rd, re, rf}
}
make_pattern_opaque :: #force_inline proc "contextless" (r0, r1, r2, r3, r4, r5, r6, r7: u8) -> Pattern {
    return Pattern{r0, r1, r2, r3, r4, r5, r6, r7, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff}
}


clear :: #force_inline proc "contextless" (color: Color) {
    vtable.clear(color)
}

set_background_color :: #force_inline proc "contextless" (color: Solid_Color) {
    vtable.set_background_color(color)
}

@(deprecated="'set_stencil' deprecated in favor of 'set_stencil_image', which adds a 'tile' flag.")
set_stencil :: #force_inline proc "contextless" (stencil: Bitmap) {
    set_stencil_image(stencil)
}

set_draw_mode :: #force_inline proc "contextless" (draw_mode: Bitmap_Draw_Mode) {
    vtable.set_draw_mode(draw_mode)
}

set_draw_offset :: #force_inline proc "contextless" (delta_x, delta_y: i32) {
    vtable.set_draw_offset(delta_x, delta_y)
}

set_clip_rect :: #force_inline proc "contextless" (x, y, width, height: i32) {
    vtable.set_clip_rect(x, y, width, height)
}

clear_clip_rect :: #force_inline proc "contextless" () {
    vtable.clear_clip_rect()
}

set_line_cap_style :: #force_inline proc "contextless" (style: Line_Cap_Style) {
    vtable.set_line_cap_style(style)
}

set_font :: #force_inline proc "contextless" (font: Font) {
    vtable.set_font(font)
}

set_text_tracking :: #force_inline proc "contextless" (tracking: i32) {
    vtable.set_text_tracking(tracking)
}

push_context :: #force_inline proc "contextless" (target: Bitmap) {
    vtable.push_context(target)
}

pop_context :: #force_inline proc "contextless" () {
    vtable.pop_context()
}


draw_bitmap :: #force_inline proc "contextless" (bitmap: Bitmap, x, y: i32, flip: Bitmap_Flip = .unflipped) {
    vtable.draw_bitmap(bitmap, x, y, flip)
}

tile_bitmap :: #force_inline proc "contextless" (bitmap: Bitmap, x, y, width, height: i32, flip: Bitmap_Flip = .unflipped) {
    vtable.tile_bitmap(bitmap, x, y, width, height, flip)
}

draw_line :: #force_inline proc "contextless" (x1, y1, x2, y2, width: i32, color: Color) {
    vtable.draw_line(x1, y1, x2, y2, width, color)
}

fill_triangle :: #force_inline proc "contextless" (x1, y1, x2, y2, x3, y3: i32, color: Color) {
    vtable.fill_triangle(x1, y1, x2, y2, x3, y3, color)
}

draw_rect :: #force_inline proc "contextless" (x, y, width, height: i32, color: Color) {
    vtable.draw_rect(x, y, width, height, color)
}

fill_rect :: #force_inline proc "contextless" (x, y, width, height: i32, color: Color) {
    vtable.fill_rect(x, y, width, height, color)
}

draw_ellipse :: #force_inline proc "contextless" (x, y, width, height, line_width: i32, start_angle, end_angle: f32, color: Color) {
    vtable.draw_ellipse(x, y, width, height, line_width, start_angle, end_angle, color)
}

fill_ellipse :: #force_inline proc "contextless" (x, y, width, height: i32, start_angle, end_angle: f32, color: Color) {
    vtable.fill_ellipse(x, y, width, height, start_angle, end_angle, color)
}

draw_scaled_bitmap :: #force_inline proc "contextless" (bitmap: Bitmap, x, y: i32, x_scale, y_scale: f32) {
    vtable.draw_scaled_bitmap(bitmap, x, y, x_scale, y_scale)
}

// Draws the given text using the provided options. 
// If no font has been set with setFont, the default system font Asheville Sans 14 Light is used.
draw_text :: #force_inline proc "contextless" (text: cstring, length: u32, encoding: String_Encoding, x, y: i32) -> i32 {
    return vtable.draw_text(text, length, encoding, x, y) // TODO: figure out what the return value does
} 


new_bitmap :: #force_inline proc "contextless" (width, height: i32, background_color: Color) -> Bitmap {
    return vtable.new_bitmap(width, height, background_color)
}

free_bitmap :: #force_inline proc "contextless" (bitmap: Bitmap) {
    vtable.free_bitmap(bitmap)
}

load_bitmap :: #force_inline proc "contextless" (path: cstring) -> (bitmap: Bitmap, err: cstring) {
    bitmap = vtable.load_bitmap(path, &err)
    return
}

copy_bitmap :: #force_inline proc "contextless" (bitmap: Bitmap) -> Bitmap {
    return vtable.copy_bitmap(bitmap)
}

load_into_bitmap :: #force_inline proc "contextless" (path: cstring, bitmap: Bitmap) -> (err: cstring) {
    vtable.load_into_bitmap(path, bitmap, &err)
    return
}

get_bitmap_data :: #force_inline proc "contextless" (bitmap: Bitmap) -> Bitmap_Data {
    d: Bitmap_Data
    mask, data: [^]u8
    vtable.get_bitmap_data(bitmap, &d.width, &d.height, &d.row_bytes, mask, data)
    buffer_len := (d.row_bytes * d.height)
    d.mask = mask[:buffer_len]
    d.data = data[:buffer_len]
    return d
}

clear_bitmap :: #force_inline proc "contextless" (bitmap: Bitmap, background_color: Color) {
    vtable.clear_bitmap(bitmap, background_color)
}

// alloced_size might be the number of bytes in each row?
rotated_bitmap :: #force_inline proc "contextless" (bitmap: Bitmap, rotation, x_scale, y_scale: f32) -> (rotated: Bitmap, alloced_size: i32) {
    rotated = vtable.rotated_bitmap(bitmap, rotation, x_scale, y_scale, &alloced_size)
    return
}

new_bitmap_table :: #force_inline proc "contextless" (count, width, height: i32) -> Bitmap_Table {
    return vtable.new_bitmap_table(count, width, height)
}

free_bitmap_table :: #force_inline proc "contextless" (table: Bitmap_Table) {
    vtable.free_bitmap_table(table)
}

load_into_bitmap_table :: #force_inline proc "contextless" (path: cstring, table: Bitmap_Table) -> (err: cstring){
    vtable.load_into_bitmap_table(path, table, &err)
    return
}


load_font :: #force_inline proc "contextless" (path: cstring) -> (font: Font, err: cstring) {
    font = vtable.load_font(path, &err)
    return
}

get_font_page :: #force_inline proc "contextless" (font: Font, c: u32) -> Font_Page {
    return vtable.get_font_page(font, c)
}

get_page_glyph :: #force_inline proc "contextless" (page: Font_Page, c: u32, bitmap: ^Bitmap) -> (glyph: Font_Glyph, advance: bool) {
    advance_int: i32
    glyph = vtable.get_page_glyph(page, c, bitmap, &advance_int)
    advance = bool(advance_int)
    return
}

get_glyph_kerning :: #force_inline proc "contextless" (glyph: Font_Glyph, glyph_code, next_code: u32) -> i32 {
    return vtable.get_glyph_kerning(glyph, glyph_code, next_code)
}

get_text_width :: #force_inline proc "contextless" (font: Font, text: cstring, length: u32, encoding: String_Encoding, tracking: i32) -> i32 {
    return vtable.get_text_width(font, text, length, encoding, tracking)
}

get_frame :: #force_inline proc "contextless" () -> []u8 {
    buf := vtable.get_frame()
    return buf[:LCD_ROWSIZE * LCD_COLUMNS]
}

get_display_frame :: #force_inline proc "contextless" () -> []u8 {
    buf := vtable.get_display_frame()
    return buf[:LCD_ROWSIZE * LCD_COLUMNS]
}

// Only valid in simulator
get_debug_bitmap :: #force_inline proc "contextless" () -> Bitmap {
    return vtable.get_debug_bitmap()
}

copy_frame_buffer_bitmap :: #force_inline proc "contextless" () -> Bitmap {
    return vtable.copy_frame_buffer_bitmap()
}

mark_updated_rows :: #force_inline proc "contextless" (start, end: i32) {
    vtable.mark_updated_rows(start, end)
}

display :: #force_inline proc "contextless" () {
    vtable.display()
}

// Since 1.0
set_color_to_pattern :: #force_inline proc "contextless" (color: Color, bitmap: Bitmap, x, y: i32) {
    vtable.set_color_to_pattern(color, bitmap, x, y)
}

// Since 1.0
check_mask_collision :: #force_inline proc "contextless" (bitmap_1: Bitmap, x_1, y_1: i32, flip_1: Bitmap_Flip, bitmap_2: Bitmap, x_2, y_2: i32, flip_2: Bitmap_Flip, rect: Rect) -> bool {
    return vtable.check_mask_collision(bitmap_1, x_1, y_1, flip_1, bitmap_2, x_2, y_2, flip_2, rect) != 0
}


// Since 1.1
set_screen_clip_rect :: #force_inline proc "contextless" (x, y, width, height: i32) {
    vtable.set_screen_clip_rect(x, y, width, height)
}

// Since 1.1.1
fill_polygon :: #force_inline proc "contextless" (points: []i32, color: Color, fill_rule: Polygon_Fill_Rule = .even_odd) {
    n_points := i32(len(points) / 2)
    vtable.fill_polygon(n_points, raw_data(points), color, fill_rule)
}
// Since 1.1.1
get_font_height :: #force_inline proc "contextless" (font: Font) -> u8 {
    return vtable.get_font_height(font)
}


// Since 1.7
get_display_buffer_bitmap :: #force_inline proc "contextless" () -> Bitmap {
    return vtable.get_display_buffer_bitmap()
}

// Since 1.7
draw_rotated_bitmap :: #force_inline proc "contextless" (bitmap: Bitmap, x, y: i32, rotation, x_center, y_center, x_scale, y_scale: f32) {
    vtable.draw_rotated_bitmap(bitmap, x, y, rotation, x_center, y_center, x_scale, y_scale)
}

// Since 1.7
set_text_leading :: #force_inline proc "contextless" (line_height_adjustment: i32) {
    vtable.set_text_leading(line_height_adjustment)
}


// Sets a mask image for the given bitmap. The set mask must be the same size as the target bitmap.
// 
// Since 1.8
set_bitmap_mask :: #force_inline proc "contextless" (bitmap, mask: Bitmap) -> i32 {
    return vtable.set_bitmap_mask(bitmap, mask)
}

// Since 1.8
get_bitmap_mask :: #force_inline proc "contextless" (bitmap: Bitmap) -> Bitmap {
    return vtable.get_bitmap_mask(bitmap)
}

// Since 1.10
set_stencil_image :: #force_inline proc "contextless" (stencil: Bitmap, tile: bool = false) {
    vtable.set_stencil_image(stencil, i32(tile))
}


// Since 1.12
make_font_from_data :: #force_inline proc "contextless" (data: Font_Data, wide: bool = false) -> Font {
    return vtable.make_font_from_data(data, i32(wide))
}
