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



// Clears the entire display, filling it with `color`.
clear :: #force_inline proc "contextless" (color: Color) {
    vtable.clear(_color_to_internal_color(color))
}



// Sets the background color shown when the display is offset (see `set_offset()`) or for clearing dirty areas in the sprite system.
set_background_color :: #force_inline proc "contextless" (color: Solid_Color) {
    vtable.set_background_color(color)
}

// Sets the stencil used for drawing. For a tiled stencil, use `set_stencil_image()` instead.
set_stencil :: #force_inline proc "contextless" (stencil: Bitmap) {
    set_stencil_image(stencil)
}

// Sets the mode used for drawing bitmaps. Note that text drawing uses bitmaps, so this affects how fonts are displayed as well. 
set_draw_mode :: #force_inline proc "contextless" (draw_mode: Bitmap_Draw_Mode) {
    vtable.set_draw_mode(draw_mode)
}

// Offsets the origin point for all drawing calls to `x, y` (can be negative).
// 
// This is useful, for example, for centering a "camera" on a sprite that is moving around a world larger than the screen.
set_draw_offset :: #force_inline proc "contextless" (delta_x, delta_y: i32) {
    vtable.set_draw_offset(delta_x, delta_y)
}

// Sets the clipping rectangle for sprite drawing.
set_clip_rect :: #force_inline proc "contextless" (x, y, width, height: i32) {
    vtable.set_clip_rect(x, y, width, height)
}

// Clears the sprite’s clipping rectangle.
clear_clip_rect :: #force_inline proc "contextless" () {
    vtable.clear_clip_rect()
}



// Sets the end cap style used in the line drawing procedures. `style` can be:
// 
// - `.butt`
// - `.square`
// - `.round`
set_line_cap_style :: #force_inline proc "contextless" (style: Line_Cap_Style) {
    vtable.set_line_cap_style(style)
}

// Sets the font to use in subsequent `draw_text()` calls.
set_font :: #force_inline proc "contextless" (font: Font) {
    vtable.set_font(font)
}

// Sets the tracking to use when drawing text.
set_text_tracking :: #force_inline proc "contextless" (tracking: i32) {
    vtable.set_text_tracking(tracking)
}

// Push a new drawing context for drawing into the given bitmap. 
// 
// If `target` is nil, the drawing procedures will use the display framebuffer.
push_context :: #force_inline proc "contextless" (target: Bitmap) {
    vtable.push_context(target)
}

// Pops a context off the stack (if any are left), restoring the drawing settings from before the context was pushed.
pop_context :: #force_inline proc "contextless" () {
    vtable.pop_context()
}


// Draws the `bitmap` with its upper-left corner at location `x, y`, using the given flip orientation.
draw_bitmap :: #force_inline proc "contextless" (bitmap: Bitmap, x, y: i32, flip: Bitmap_Flip = .unflipped) {
    vtable.draw_bitmap(bitmap, x, y, flip)
}

// Draws the `bitmap` with its upper-left corner at location `x, y` tiled inside a `width` by `height` rectangle.
tile_bitmap :: #force_inline proc "contextless" (bitmap: Bitmap, x, y, width, height: i32, flip: Bitmap_Flip = .unflipped) {
    vtable.tile_bitmap(bitmap, x, y, width, height, flip)
}

// Draws a line from `x_1, y_1` to `x_2, y_2` with a stroke width of `width`.
draw_line :: #force_inline proc "contextless" (x_1, y_1, x_2, y_2, width: i32, color: Color) {
    vtable.draw_line(x_1, y_1, x_2, y_2, width, _color_to_internal_color(color))
}

// Draws a filled triangle with points at `x_1, y_1`, `x_2, y_2`, and `x_3, y_3`.
fill_triangle :: #force_inline proc "contextless" (x_1, y_1, x_2, y_2, x_3, y_3: i32, color: Color) {
    vtable.fill_triangle(x_1, y_1, x_2, y_2, x_3, y_3, _color_to_internal_color(color))
}

// Draws a `width` by `height` rect at `x, y`.
draw_rect :: #force_inline proc "contextless" (x, y, width, height: i32, color: Color) {
    vtable.draw_rect(x, y, width, height, _color_to_internal_color(color))
}

// Draws a filled `width` by `height` rect at `x, y`.
fill_rect :: #force_inline proc "contextless" (x, y, width, height: i32, color: Color) {
    vtable.fill_rect(x, y, width, height, _color_to_internal_color(color))
}
// Draws an ellipse inside the rectangle `{x, y, width, height}` of width `line_width` (inset from the rectangle bounds). 
// 
// If `start_angle != end_angle`, this draws an arc between the given angles. 
// Angles are given in degrees, clockwise from due north.
draw_ellipse :: #force_inline proc "contextless" (x, y, width, height, line_width: i32, start_angle, end_angle: f32, color: Color) {
    vtable.draw_ellipse(x, y, width, height, line_width, start_angle, end_angle, _color_to_internal_color(color))
}

// Fills an ellipse inside the rectangle `{x, y, width, height}`. 
// 
// If `start_angle != end_angle`, this draws a wedge/Pacman between the given angles. 
// Angles are given in degrees, clockwise from due north.
fill_ellipse :: #force_inline proc "contextless" (x, y, width, height: i32, start_angle, end_angle: f32, color: Color) {
    vtable.fill_ellipse(x, y, width, height, start_angle, end_angle, _color_to_internal_color(color))
}

// Draws the bitmap scaled to `x_scale` and `y_scale` with its upper-left corner at location `x, y`. 
// 
// Note that `flip` is not available when drawing scaled bitmaps but negative scale values will achieve the same effect.
draw_scaled_bitmap :: #force_inline proc "contextless" (bitmap: Bitmap, x, y: i32, x_scale, y_scale: f32) {
    vtable.draw_scaled_bitmap(bitmap, x, y, x_scale, y_scale)
}

// Draws the given text using the provided options. 
// If no font has been set with setFont, the default system font Asheville Sans 14 Light is used.
draw_text :: #force_inline proc "contextless" (text: cstring, length: u32, encoding: String_Encoding, x, y: i32) -> i32 {
    return vtable.draw_text(text, length, encoding, x, y) // TODO: figure out what the return value does
} 

// Allocates and returns a new `width` by `height` Bitmap filled with `bg_color`.
new_bitmap :: #force_inline proc "contextless" (width, height: i32, background_color: Color) -> Bitmap {
    return vtable.new_bitmap(width, height, _color_to_internal_color(background_color))
}

// Frees the given `bitmap`.
free_bitmap :: #force_inline proc "contextless" (bitmap: Bitmap) {
    vtable.free_bitmap(bitmap)
}

// Allocates and returns a new Bitmap from the file at `path`. If there is no file at `path`, the procedure returns nil.
load_bitmap :: #force_inline proc "contextless" (path: cstring) -> (bitmap: Bitmap, err: cstring) {
    bitmap = vtable.load_bitmap(path, &err)
    return
}

// Returns a new Bitmap that is an exact copy of `bitmap`.
copy_bitmap :: #force_inline proc "contextless" (bitmap: Bitmap) -> Bitmap {
    return vtable.copy_bitmap(bitmap)
}

// Loads the image at `path` into the previously allocated `bitmap`.
load_into_bitmap :: #force_inline proc "contextless" (path: cstring, bitmap: Bitmap) -> (err: cstring) {
    vtable.load_into_bitmap(path, bitmap, &err)
    return
}

// Gets various info about `bitmap` including its `width` and `height` and raw pixel data. 
// 
// The data is 1 bit per pixel packed format, in MSB order; in other words, the high bit of the first byte in <code>data</code> is the top left pixel of the image. 
// If the bitmap has a mask, a slice of its data is returned in `mask`, else nil is returned.
get_bitmap_data :: #force_inline proc "contextless" (bitmap: Bitmap) -> Bitmap_Data {
    d: Bitmap_Data
    mask, data: [^]u8
    vtable.get_bitmap_data(bitmap, &d.width, &d.height, &d.row_bytes, mask, data)
    buffer_len := (d.row_bytes * d.height)
    d.mask = mask[:buffer_len]
    d.data = data[:buffer_len]
    return d
}

// Clears `bitmap`, filling with the given `background_color`.
clear_bitmap :: #force_inline proc "contextless" (bitmap: Bitmap, background_color: Color) {
    vtable.clear_bitmap(bitmap, _color_to_internal_color(background_color))
}

// Returns a new, rotated and scaled Bitmap based on the given `bitmap`.
rotated_bitmap :: #force_inline proc "contextless" (bitmap: Bitmap, rotation, x_scale, y_scale: f32) -> (rotated: Bitmap, alloced_size: i32) {
    // TODO: alloced_size might be the number of bytes in each row?
    rotated = vtable.rotated_bitmap(bitmap, rotation, x_scale, y_scale, &alloced_size)
    return
}

// Allocates and returns a new Bitmap_Table that can hold `count` `width` by `height` Bitmaps.
new_bitmap_table :: #force_inline proc "contextless" (count, width, height: i32) -> Bitmap_Table {
    return vtable.new_bitmap_table(count, width, height)
}

// Frees the given Bitmap_Table.
free_bitmap_table :: #force_inline proc "contextless" (table: Bitmap_Table) {
    // Note: not documented on website
    vtable.free_bitmap_table(table)
}


// Loads the imagetable at `path` into the previously allocated `table`.
load_into_bitmap_table :: #force_inline proc "contextless" (path: cstring, table: Bitmap_Table) -> (err: cstring){
    vtable.load_into_bitmap_table(path, table, &err)
    return
}


// Returns the Font object for the font file at `path`. 
// In case of error, `err` points to a string describing the error.
load_font :: #force_inline proc "contextless" (path: cstring) -> (font: Font, err: cstring) {
    font = vtable.load_font(path, &err)
    return
}

// Returns a Font_Page object for the given character code. 
// 
// Each Font_Page contains information for 256 characters; 
// specifically, if `(c1 & ~0xff) == (c2 & ~0xff)` then `c1` and `c2` belong to the same page and the same 
// Font_Page can be used to fetch the character data for both instead of searching for the page twice.
get_font_page :: #force_inline proc "contextless" (font: Font, c: u32) -> Font_Page {
    return vtable.get_font_page(font, c)
}

// Returns a Font_Glyph object for character `c` in Font_Page `page`, and optionally returns the glyph's bitmap and advance value.
get_page_glyph :: #force_inline proc "contextless" (page: Font_Page, c: u32) -> (glyph: Font_Glyph, bitmap: Bitmap, advance: i32) {
    glyph = vtable.get_page_glyph(page, c, &bitmap, &advance)
    return
}

// Returns the kerning adjustment between characters `glyph_code` and `next_code` as specified by the font.
get_glyph_kerning :: #force_inline proc "contextless" (glyph: Font_Glyph, glyph_code, next_code: u32) -> i32 {
    return vtable.get_glyph_kerning(glyph, glyph_code, next_code)
}

// returns the width of the given text in the given font.
get_text_width :: #force_inline proc "contextless" (font: Font, text: cstring, length: u32, encoding: String_Encoding, tracking: i32) -> i32 {
    return vtable.get_text_width(font, text, length, encoding, tracking)
}

// Returns the current display frame buffer. 
// 
// Rows are 32-bit aligned, so the row stride is 52 bytes, with the extra 2 bytes per row ignored. 
// Bytes are MSB-ordered; i.e., the pixel in column 0 is the 0x80 bit of the first byte of the row.
get_frame :: #force_inline proc "contextless" () -> []u8 {
    buf := vtable.get_frame()
    return buf[:LCD_ROWSIZE * LCD_COLUMNS]
}

// Returns the raw bits in the display buffer, the last completed frame.
get_display_frame :: #force_inline proc "contextless" () -> []u8 {
    buf := vtable.get_display_frame()
    return buf[:LCD_ROWSIZE * LCD_COLUMNS]
}

// Only valid in the Simulator, returns the debug framebuffer as a bitmap. 
// Procedure is nil on device.
get_debug_bitmap :: #force_inline proc "contextless" () -> Bitmap {
    return vtable.get_debug_bitmap()
}

// Returns a copy the contents of the working frame buffer as a bitmap. 
// 
// Allocates: The caller is responsible for freeing the returned bitmap with `free_bitmap()`.
copy_frame_buffer_bitmap :: #force_inline proc "contextless" () -> Bitmap {
    return vtable.copy_frame_buffer_bitmap()
}

// After updating pixels in the buffer returned by `get_frame()`, you must tell the graphics system which rows were updated. 
// This procedure marks a contiguous range of rows as updated (e.g., `mark_updated_rows(0,LCD_ROWS-1)` tells the system to update the entire display). 
// 
// Both “start” and “end” are included in the range.
mark_updated_rows :: #force_inline proc "contextless" (start, end: i32) {
    vtable.mark_updated_rows(start, end)
}

// Manually flushes the current frame buffer out to the display. 
// This procedure is automatically called after each pass through the run loop, so there shouldn’t be any need to call it yourself.
display :: #force_inline proc "contextless" () {
    vtable.display()
}

// Sets `color` to an 8 x 8 pattern using the given `bitmap`. 
// `x, y` indicates the top left corner of the 8 x 8 pattern.
//
// Since 1.0
set_color_to_pattern :: #force_inline proc "contextless" (color: Color, bitmap: Bitmap, x, y: i32) {
    vtable.set_color_to_pattern(_color_to_internal_color(color), bitmap, x, y)
}

// Returns true if any of the opaque pixels in `bitmap_1` when positioned at `x_1, y1` with `flip_1` 
// overlap any of the opaque pixels in `bitmap_2` at `x_2, y_2` with `flip_2` within the non-empty `rect`, 
// or false if no pixels overlap or if one or both fall completely outside of `rect`.
//
// Since 1.0
check_mask_collision :: #force_inline proc "contextless" (bitmap_1: Bitmap, x_1, y_1: i32, flip_1: Bitmap_Flip, bitmap_2: Bitmap, x_2, y_2: i32, flip_2: Bitmap_Flip, rect: Rect) -> bool {
    return vtable.check_mask_collision(bitmap_1, x_1, y_1, flip_1, bitmap_2, x_2, y_2, flip_2, rect) != 0
}


// Sets the current clip rect in screen coordinates.
//
// Since 1.1
set_screen_clip_rect :: #force_inline proc "contextless" (x, y, width, height: i32) {
    vtable.set_screen_clip_rect(x, y, width, height)
}

// Fills the polygon with vertices at the given coordinates (an array of `2 * nPoints` ints containing alternating x and y values) 
// using the given color and fill, or winding, rule. See [Wikipedia: Nonzero-rule](https://en.wikipedia.org/wiki/Nonzero-rule) for an explanation of the winding rule.
//
// Since 1.1.1
fill_polygon :: #force_inline proc "contextless" (points: []i32, color: Color, fill_rule: Polygon_Fill_Rule = .even_odd) {
    n_points := i32(len(points) / 2)
    vtable.fill_polygon(n_points, raw_data(points), _color_to_internal_color(color), fill_rule)
}

// Returns the height of the given font.
// 
// Since 1.1.1
get_font_height :: #force_inline proc "contextless" (font: Font) -> u8 {
    return vtable.get_font_height(font)
}


// Returns a bitmap containing the contents of the display buffer. 
// 
// The system owns this bitmap - do not free it!
// 
// Since 1.7
get_display_buffer_bitmap :: #force_inline proc "contextless" () -> Bitmap {
    // Note: documented on website as "getDisplayFrameBitmap", while SDK header has "getDisplayBufferBitmap".
    return vtable.get_display_buffer_bitmap()
}

// Draws the `bitmap` scaled to `x_scale` and `y_scale` then rotated by `degrees` with its center 
// as given by proportions `x_center` and `y_center` at `x`, `y`; that is: if `x_center` and 
// `y_center` are both 0.5 the center of the image is at (`x`,`y`), if `x_cetner` and `y_center` 
// are both 0 the top left corner of the image (before rotation) is at (`x`,`y`), etc.
// 
// Since 1.7
draw_rotated_bitmap :: #force_inline proc "contextless" (bitmap: Bitmap, x, y: i32, rotation, x_center, y_center, x_scale, y_scale: f32) {
    vtable.draw_rotated_bitmap(bitmap, x, y, rotation, x_center, y_center, x_scale, y_scale)
}

// Sets the leading adjustment (added to the leading specified in the font) to use when drawing text.
//
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

// Gets a mask image for the given `bitmap`. 
//
// if the image doesn't have a mask, `get_bitmap_mask()` returns nil.
//
// Since 1.8
get_bitmap_mask :: #force_inline proc "contextless" (bitmap: Bitmap) -> Bitmap {
    return vtable.get_bitmap_mask(bitmap)
}

 
// Sets the stencil used for drawing. If `tile` is true the stencil image will be tiled. 
// 
// Tiled stencils must have width equal to a multiple of 32 pixels.
// 
// Since 1.10
set_stencil_image :: #force_inline proc "contextless" (stencil: Bitmap, tile: bool = false) {
    vtable.set_stencil_image(stencil, i32(tile))
}

// Returns a Font object wrapping the Font_Data `data` comprising the contents (minus 16-byte header) of an uncompressed pft file. 
// 
// `wide` corresponds to the flag in the header indicating whether the font contains glyphs at codepoints above U+1FFFF.
// 
// Since 1.12
make_font_from_data :: #force_inline proc "contextless" (data: Font_Data, wide: bool = false) -> Font {
    return vtable.make_font_from_data(data, i32(wide))
}


@(private)
_color_to_internal_color :: #force_inline proc "contextless" (color: Color) -> _Color_Internal {
    color_internal: _Color_Internal
    switch val in color {
        case Solid_Color:
            color_internal.solid_color = val
        case ^Pattern: 
            color_internal.pattern = val
    }
    return color_internal
}

// ///////////////////////////
// // Odin procedure groups //
// ///////////////////////////

free :: proc {
    free_bitmap,
    free_bitmap_table,
}