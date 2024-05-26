// The drawing functions use a context stack to select the drawing target, for setting a stencil, changing the draw mode, etc. 
// The stack is unwound at the beginning of each update cycle, with drawing restored to target the display.
package playdate_graphics

import "core:c"
import "../bindings"

Rect                :: bindings.Rect

LCD_COLUMNS         :: bindings.LCD_COLUMNS
LCD_ROWS            :: bindings.LCD_ROWS
LCD_ROWSIZE         :: bindings.LCD_ROWSIZE
LCD_SCREEN_RECT     :: bindings.LCD_SCREEN_RECT 

Bitmap              :: bindings.Bitmap

Bitmap_Draw_Mode    :: bindings.Bitmap_Draw_Mode
Bitmap_Flip         :: bindings.Bitmap_Flip

Bitmap_Table        :: bindings.Gfx_Bitmap_Table
Font                :: bindings.Gfx_Font
Font_Data           :: bindings.Gfx_Font_Data
Font_Page           :: bindings.Gfx_Font_Page
Font_Glyph          :: bindings.Gfx_Font_Glyph

// Pixel data is in 1 bit per pixel packed format, in Most Significant Bit order.
// The high bit of the first byte in `data` is the top-left pixel of the image.
Bitmap_Data         :: bindings.Gfx_Bitmap_Data

Solid_Color         :: bindings.Gfx_Solid_Color

Line_Cap_Style      :: bindings.Gfx_Line_Cap_Style

Font_Language       :: bindings.Gfx_Font_Language

String_Encoding     :: bindings.Gfx_String_Encoding

// 8x8 pattern: 8 rows image data, 8 rows mask
Pattern             :: bindings.Gfx_Pattern
Color               :: bindings.Gfx_Color

Polygon_Fill_Rule   :: bindings.Gfx_Polygon_Fill_Rule

// =================================================================


// Clears the entire display, filling it with `color`.
clear :: proc "contextless" (color: Color) {
    bindings.graphics.clear(color)
}

// Sets the background color shown when the display is offset (see `set_offset()`) or for clearing dirty areas in the sprite system.
set_background_color :: proc "contextless" (color: Solid_Color) {
    bindings.graphics.set_background_color(color)
}

// DEPRECATED in favor of `set_stenciL_image`, which adds a "tile" flag.
// 
// Sets the stencil used for drawing.
set_stencil :: proc "contextless" (stencil: Bitmap) {
    bindings.graphics.set_stencil(stencil)
}

// Sets the mode used for drawing bitmaps. Note that text drawing uses bitmaps, so this affects how fonts are displayed as well. 
set_draw_mode :: proc "contextless" (mode: Bitmap_Draw_Mode) -> Bitmap_Draw_Mode {
    return bindings.graphics.set_draw_mode(mode)
}

// Offsets the origin point for all drawing calls to `dx, dy` (can be negative).
// 
// This is useful, for example, for centering a "camera" on a sprite that is moving around a world larger than the screen.
set_draw_offset :: proc "contextless" (dx, dy: i32) {
    bindings.graphics.set_draw_offset(dx, dy)
}


// Sets the clipping rectangle for sprite drawing.
set_clip_rect :: proc "contextless" (x, y, width, height: i32) {
    bindings.graphics.set_clip_rect(x, y, width, height)
}

// Clears the sprite’s clipping rectangle.
clear_clip_rect :: proc "contextless" () {
    bindings.graphics.clear_clip_rect()
}

// Sets the end cap style used in the line drawing procedures.  
set_line_cap_style :: proc "contextless" (end_cap_style: Line_Cap_Style) {
    bindings.graphics.set_line_cap_style(end_cap_style)
}

// Sets the font to use in subsequent `draw_text()` calls.
set_font :: proc "contextless" (font: Font) {
    bindings.graphics.set_font(font)
}

// Sets the tracking to use when drawing text.
set_text_tracking :: proc "contextless" (tracking: i32) {
    bindings.graphics.set_text_tracking(tracking)
}

// Push a new drawing context for drawing into the given bitmap. 
// 
// If `target` is nil, the drawing procedures will use the display framebuffer.
push_context :: proc "contextless" (target: Bitmap) {
    bindings.graphics.push_context(target)
}

// Pops a context off the stack (if any are left), restoring the drawing settings from before the context was pushed.
pop_context :: proc "contextless" () {
    bindings.graphics.pop_context()
}



// Draws the `bitmap` with its upper-left corner at location `x, y`, using the given flip orientation.
draw_bitmap :: proc "contextless" (bitmap: Bitmap, x, y: i32, flip: Bitmap_Flip) {
    bindings.graphics.draw_bitmap(bitmap, x, y, flip)
}

// Draws the `bitmap` with its upper-left corner at location `x, y` tiled inside a `width` by `height` rectangle.
tile_bitmap :: proc "contextless" (bitmap: Bitmap, x, y, width, height: i32, flip: Bitmap_Flip) {
    bindings.graphics.tile_bitmap(bitmap, x, y, width, height, flip)
}

// Draws a line from `x1, y1` to `x2, y2` with a stroke width of `width`.
draw_line :: proc "contextless" (x1, y1, x2, y2, width: i32, color: Color) {
    bindings.graphics.draw_line(x1, y1, x2, y2, width, color)
}

// Draws a filled triangle with points at `x1, y1`, `x2, y2`, and `x3, y3`.
fill_triangle :: proc "contextless" (x1, y1, x2, y2, x3, y3: i32, color: Color) {
    bindings.graphics.fill_triangle(x1, y1, x2, y2, x3, y3, color)
}

// Draws a `width` by `height` rect at `x, y`.
draw_rect :: proc "contextless" (x, y, width, height: i32, color: Color) {
    bindings.graphics.draw_rect(x, y, width, height, color)
}

// Draws a filled `width` by `height` rect at `x, y`.
fill_rect :: proc "contextless" (x, y, width, height: i32, color: Color) {
    bindings.graphics.fill_rect(x, y, width, height, color)
}

// Draws an ellipse inside the rectangle `{x, y, width, height}` of width `line_width` (inset from the rectangle bounds). 
// 
// If `start_angle != end_angle`, this draws an arc between the given angles. 
// Angles are given in degrees, clockwise from due north.
draw_ellipse :: proc "contextless" (x, y, width, height, line_width: i32, start_angle, end_angle: f32, color: Color) {
    bindings.graphics.draw_ellipse(x, y, width, height, line_width, start_angle, end_angle, color)
}

// Fills an ellipse inside the rectangle `{x, y, width, height}`. 
// 
// If `start_angle != end_angle`, this draws a wedge/Pacman between the given angles. 
// Angles are given in degrees, clockwise from due north.
fill_ellipse :: proc "contextless" (x, y, width, height: i32, start_angle, end_angle: f32, color: Color) {
    bindings.graphics.fill_ellipse(x, y, width, height, start_angle, end_angle, color)
}

// Draws the bitmap scaled to `x_scale` and `y_scale` with its upper-left corner at location `x, y`. 
// 
// Note that `flip` is not available when drawing scaled bitmaps but negative scale values will achieve the same effect.
draw_scaled_bitmap :: proc "contextless" (bitmap: Bitmap, x, y: i32, x_scale, y_scale: f32) {
    bindings.graphics.draw_scaled_bitmap(bitmap, x, y, x_scale, y_scale)
}

// Draws the given text using the provided options. 
// If no font has been set with setFont, the default system font Asheville Sans 14 Light is used.
draw_text :: proc "contextless" (text: cstring, length: c.size_t, encoding: String_Encoding, x, y: i32) -> i32 {
    return bindings.graphics.draw_text(text, length, encoding, x, y)
}

// Allocates and returns a new `width` by `height` Bitmap filled with `bg_color`.
new_bitmap :: proc "contextless" (width, height: i32, bg_color: Color) -> Bitmap {
    return bindings.graphics.new_bitmap(width, height, bg_color)
}

// Frees the given `bitmap`.
free_bitmap :: proc "contextless" (bitmap: Bitmap) {
    bindings.graphics.free_bitmap(bitmap)
}

// Allocates and returns a new Bitmap from the file at `path`. If there is no file at `path`, the procedure returns nil.
load_bitmap :: proc "contextless" (path: cstring) -> (bitmap: Bitmap, err: cstring) {
    bitmap = bindings.graphics.load_bitmap(path, &err)
    return
}

// Returns a new Bitmap that is an exact copy of `bitmap`.
copy_bitmap :: proc "contextless" (bitmap: Bitmap) -> Bitmap {
    return bindings.graphics.copy_bitmap(bitmap)
}

// Loads the image at `path` into the previously allocated `bitmap`.
load_into_bitmap :: proc "contextless" (path: cstring, bitmap: Bitmap) -> (err: cstring) {
    bindings.graphics.load_into_bitmap(path, bitmap, &err)
    return
}

// Gets various info about `bitmap` including its `width` and `height` and raw pixel data. 
// 
// The data is 1 bit per pixel packed format, in MSB order; in other words, the high bit of the first byte in `data` is the top left pixel of the image. 
// If the bitmap has a mask, a multipointer of its data is returned in `mask`, else nil is returned.
get_bitmap_data :: proc "contextless" (bitmap: Bitmap) -> (width, height, row_bytes: i32, mask, data: []u8) {
    mask_mp: [^]u8
    data_mp: [^]u8
    bindings.graphics.get_bitmap_data(bitmap, &width, &height, &row_bytes, &mask_mp, &data_mp)
    mask = mask_mp[:row_bytes * height]
    data = data_mp[:row_bytes * height]
    return
}

// Clears `bitmap`, filling with the given `background_color`.
clear_bitmap :: proc "contextless" (bitmap: Bitmap, bg_color: Color) {
    bindings.graphics.clear_bitmap(bitmap, bg_color)
}

// Returns a new, rotated and scaled Bitmap based on the given `bitmap`.
rotated_bitmap :: proc "contextless" (bitmap: Bitmap, rotation, x_scale, y_scale: f32) -> (rotated: Bitmap, allocated_size: i32) {
    rotated = bindings.graphics.rotated_bitmap(bitmap, rotation, x_scale, y_scale, &allocated_size)
    return
}

// Allocates and returns a new Bitmap_Table that can hold `count` `width` by `height` Bitmaps.
new_bitmap_table :: proc "contextless" (count, width, height: i32) {
    bindings.graphics.new_bitmap_table(count, width, height)
}

// Frees the given Bitmap_Table.
free_bitmap_table :: proc "contextless" (table: Bitmap_Table) {
    bindings.graphics.free_bitmap_table(table)
}

// Loads the imagetable at `path` into the previously allocated `table`.
load_bitmap_table :: proc "contextless" (path: cstring) -> (table: Bitmap_Table, err: cstring) {
    table = bindings.graphics.load_bitmap_table(path, &err)
    return
}

// Returns the Font object for the font file at `path`. 
// In case of error, `err` points to a string describing the error.
load_into_bitmap_table :: proc "contextless" (path: cstring, table: Bitmap_Table) -> (err: cstring) {
    bindings.graphics.load_into_bitmap_table(path, table, &err)
    return
}

// Returns the `idx` bitmap in table, If `idx` is out of bounds, the function returns nil.
get_table_bitmap :: proc "contextless" (table: Bitmap_Table, idx: i32) -> Bitmap {
    return bindings.graphics.get_table_bitmap(table, idx)
}


// Returns the Font object for the font file at `path`. 
load_font :: proc "contextless" (path: cstring) -> (font: Font, err: cstring) {
    font = bindings.graphics.load_font(path, &err)
    return
}

// Returns a Font_Page object for the given character code. 
// 
// Each Font_Page contains information for 256 characters; 
// specifically, if `(ch1 & ~0xff) == (ch2 & ~0xff)` then `ch1` and `ch2` belong to the same page and the same 
// Font_Page can be used to fetch the character data for both instead of searching for the page twice.
get_font_page :: proc "contextless" (font: Font, ch: u32) -> Font_Page {
    return bindings.graphics.get_font_page(font, ch)
}

// Returns a Font_Glyph object for character `ch` in Font_Page `page`, and optionally returns the glyph's bitmap and advance value.
get_page_glyph :: proc "contextless" (page: Font_Page, ch: u32) -> (glyph: Font_Glyph, bitmap: Bitmap, advance: i32) {
    glyph = bindings.graphics.get_page_glyph(page, ch, &bitmap, &advance)
    return
}

// Returns the kerning adjustment between characters `glyph_code` and `next_code` as specified by the font.
get_glyph_kerning :: proc "contextless" (glyph: Font_Glyph, glyph_code, next_code: u32) -> i32 {
    return bindings.graphics.get_glyph_kerning(glyph, glyph_code, next_code)
}

// returns the width of the given text in the given font.
get_text_width :: proc "contextless" (font: Font, text: cstring, length: c.size_t, encoding: String_Encoding, tracking: i32) -> i32 {
    return bindings.graphics.get_text_width(font, text, length, encoding, tracking)
}


// Returns the current display frame buffer. 
// 
// Rows are 32-bit aligned, so the row stride is 52 bytes, with the extra 2 bytes per row ignored. 
// Bytes are MSB-ordered; i.e., the pixel in column 0 is the 0x80 bit of the first byte of the row.
get_frame :: proc "contextless" () -> []u8 {
    frame_mp := bindings.graphics.get_frame()
    return frame_mp[:LCD_ROWS * LCD_ROWSIZE]
}

// Returns the raw bits in the display buffer, the last completed frame.
// 
// Rows are 32-bit aligned, so the row stride is 52 bytes, with the extra 2 bytes per row ignored. 
// Bytes are MSB-ordered; i.e., the pixel in column 0 is the 0x80 bit of the first byte of the row.
get_display_frame :: proc "contextless" () -> []u8 {
    frame_mp := bindings.graphics.get_display_frame()
    return frame_mp[:LCD_ROWS * LCD_ROWSIZE]
}

// Only valid in the Simulator, returns the debug framebuffer as a bitmap. 
// Procedure is nil on device.
get_debug_bitmap :: proc "contextless" () -> Bitmap {
    return bindings.graphics.get_debug_bitmap()
}

// Returns a copy the contents of the working frame buffer as a bitmap. 
// 
// Allocates: The caller is responsible for freeing the returned bitmap with `free_bitmap()`.
copy_frame_buffer_bitmap :: proc "contextless" () -> Bitmap {
    return bindings.graphics.copy_frame_buffer_bitmap()
}

// After updating pixels in the buffer returned by `get_frame()`, you must tell the graphics system which rows were updated. 
// This procedure marks a contiguous range of rows as updated (e.g., `mark_updated_rows(0,LCD_ROWS-1)` tells the system to update the entire display). 
// 
// Both “start” and “end” are included in the range.
mark_updated_rows :: proc "contextless" (start, end: i32) {
    bindings.graphics.mark_updated_rows(start, end)
}


// Manually flushes the current frame buffer out to the display. 
// This procedure is automatically called after each pass through the run loop, so there shouldn’t be any need to call it yourself.
display :: proc "contextless" () {
    bindings.graphics.display()
}


// misc util.

// Sets `color` to an 8 x 8 pattern using the given `bitmap`. 
// `x, y` indicates the top left corner of the 8 x 8 pattern.
set_color_to_pattern :: proc "contextless" (color: Color, bitmap: Bitmap, x, y: i32) {
    bindings.graphics.set_color_to_pattern(color, bitmap, x, y)
}

// Returns true if any of the opaque pixels in `bitmap_1` when positioned at `x_1, y1` with `flip_1` 
// overlap any of the opaque pixels in `bitmap_2` at `x_2, y_2` with `flip_2` within the non-empty `rect`, 
// or false if no pixels overlap or if one or both fall completely outside of `rect`.
check_mask_collision :: proc "contextless" (bitmap_1: Bitmap, x_1, y_1: i32, flip_1: Bitmap_Flip, 
                                            bitmap_2: Bitmap, x_2, y_2: i32, flip_2: Bitmap_Flip,
                                            rect: Rect) -> b32 {

    return bindings.graphics.check_mask_collision(bitmap_1, x_1, y_1, flip_1,
                                                  bitmap_2, x_2, y_2, flip_2,
                                                  rect)
}


// 1.1

// Sets the current clip rect in screen coordinates.
set_screen_clip_rect :: proc "contextless" (x, y, width, height: i32) {
    bindings.graphics.set_screen_clip_rect(x, y, width, height)
}


// 1.1.1

// Fills the polygon with vertices at the given coordinates using the given color and fill, or winding, rule. 
//
// See [Wikipedia: Nonzero-rule](https://en.wikipedia.org/wiki/Nonzero-rule) for an explanation of the winding rule.
fill_polygon :: proc "contextless" (points: [][2]i32, color: Color, fill_rule: Polygon_Fill_Rule) {
    bindings.graphics.fill_polygon(i32(len(points)), transmute(^i32)(raw_data(points)), color, fill_rule)
}

// Returns the height of the given font.
get_font_height :: proc "contextless" (font: Font) -> u8 {
    return bindings.graphics.get_font_height(font)
}


// 1.7

// Returns a bitmap containing the contents of the display buffer. 
// 
// The system owns this bitmap - do not free it!
get_display_buffer_bitmap :: proc "contextless" () -> Bitmap {
    return bindings.graphics.get_display_buffer_bitmap()
}

// Draws the `bitmap` scaled to `x_scale` and `y_scale` then rotated by `degrees` with its center 
// as given by proportions `x_center` and `y_center` at `x`, `y`; that is: if `x_center` and 
// `y_center` are both 0.5 the center of the image is at (`x`,`y`), if `x_cetner` and `y_center` 
// are both 0 the top left corner of the image (before rotation) is at (`x`,`y`), etc.
draw_rotated_bitmap :: proc "contextless" (bitmap: Bitmap, x, y: i32, rotation: f32, center_x, center_y, x_scale, y_scale: f32) {
    bindings.graphics.draw_rotated_bitmap(bitmap, x, y, rotation, center_x, center_y, x_scale, y_scale)
}

// Sets the leading adjustment (added to the leading specified in the font) to use when drawing text.
set_text_leading :: proc "contextless" (line_height_adjustment: i32) {
    bindings.graphics.set_text_leading(line_height_adjustment)
}


// 1.8

// Sets a mask image for the given bitmap. The set mask must be the same size as the target bitmap.
set_bitmap_mask :: proc "contextless" (bitmap, mask: Bitmap) -> i32 {
    return bindings.graphics.set_bitmap_mask(bitmap, mask)
}


// Gets a mask image for the given `bitmap`. 
//
// If the image doesn't have a mask, `get_bitmap_mask()` returns nil.
get_bitmap_mask :: proc "contextless" (bitmap: Bitmap) -> Bitmap {
    return bindings.graphics.get_bitmap_mask(bitmap)
}

// 1.10

// Sets the stencil used for drawing. If `tile` is true the stencil image will be tiled. 
// 
// Tiled stencils must have width equal to a multiple of 32 pixels.
set_stencil_image :: proc "contextless" (stencil: Bitmap, tile: i32) {
    bindings.graphics.set_stencil_image(stencil, tile)
}


// 1.12

// Returns a Font object wrapping the Font_Data `data` comprising the contents (minus 16-byte header) of an uncompressed pft file. 
// 
// `wide` corresponds to the flag in the header indicating whether the font contains glyphs at codepoints above U+1FFFF.
make_font_from_data :: proc "contextless" (data: Font_Data, wide: b32) -> Font {
    return bindings.graphics.make_font_from_data(data, wide)
}


// 2.1

// Gets the tracking used when drawing text
get_text_tracking :: proc "contextless" () -> i32 {
    return bindings.graphics.get_text_tracking()
}


// 2.5

// Sets the pixel at (x,y) in the current drawing context (by default the screen) to the given color. 
// 
// Be aware that setting a pixel at a time is not very efficient: In our testing, more than around 20,000 calls 
// in a tight loop will drop the frame rate below 30 fps.
set_pixel :: proc "contextless" (x, y: i32, color: Color) {
    bindings.graphics.set_pixel(x, y, color)
}

// Gets the color of the pixel at (x,y) in the given bitmap. 
// If the coordinate is outside the bounds of the bitmap, or if the bitmap has a mask and the pixel is marked transparent, 
// the function returns .clear; otherwise the return value is .white or .black.
get_bitmap_pixel :: proc "contextless" (bitmap: Bitmap, x, y: i32) -> Solid_Color {
    return bindings.graphics.get_bitmap_pixel(bitmap, x, y)
}

// Returns the bitmap table’s image count (if not nil) and number of cells across (ditto).
get_bitmap_table_info :: proc "contextless" (table: Bitmap_Table) -> (count, cells_wide: i32) {
    bindings.graphics.get_bitmap_table_info(table, &count, &cells_wide)
    return
}
