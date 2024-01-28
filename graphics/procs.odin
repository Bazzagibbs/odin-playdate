// The drawing functions use a context stack to select the drawing target, for setting a stencil, changing the draw mode, etc. 
// The stack is unwound at the beginning of each update cycle, with drawing restored to target the display.
package playdate_graphics

import "core:c"

// Clears the entire display, filling it with `color`.
clear                  : proc "c" (color: Color)

// Sets the background color shown when the display is offset (see `set_offset()`) or for clearing dirty areas in the sprite system.
set_background_color   : proc "c" (color: Solid_Color) 

// DEPRECATED in favor of `set_stenciL_image`, which adds a "tile" flag.
// 
// Sets the stencil used for drawing.
set_stencil            : proc "c" (stencil: Bitmap)

// Sets the mode used for drawing bitmaps. Note that text drawing uses bitmaps, so this affects how fonts are displayed as well. 
set_draw_mode          : proc "c" (draw_mode: Bitmap_Draw_Mode)

// Offsets the origin point for all drawing calls to `dx, dy` (can be negative).
// 
// This is useful, for example, for centering a "camera" on a sprite that is moving around a world larger than the screen.
set_draw_offset        : proc "c" (dx, dy: c.int)

// Sets the clipping rectangle for sprite drawing.
set_clip_rect          : proc "c" (x, y, width, height: c.int)

// Clears the sprite’s clipping rectangle.
clear_clip_rect        : proc "c" ()

// Sets the end cap style used in the line drawing procedures. `style` can be:
// 
// - `.butt`
// - `.square`
// - `.round`
set_line_cap_style     : proc "c" (end_cap_style: Line_Cap_Style)

// Sets the font to use in subsequent `draw_text()` calls.
set_font               : proc "c" (font: Font)

// Sets the tracking to use when drawing text.
set_text_tracking      : proc "c" (tracking: c.int)

// Push a new drawing context for drawing into the given bitmap. 
// 
// If `target` is nil, the drawing procedures will use the display framebuffer.
push_context           : proc "c" (target: Bitmap)

// Pops a context off the stack (if any are left), restoring the drawing settings from before the context was pushed.
pop_context            : proc "c" ()



// Draws the `bitmap` with its upper-left corner at location `x, y`, using the given flip orientation.
draw_bitmap        : proc "c" (bitmap: Bitmap, x, y: c.int, flip: Bitmap_Flip)

// Draws the `bitmap` with its upper-left corner at location `x, y` tiled inside a `width` by `height` rectangle.
tile_bitmap        : proc "c" (bitmap: Bitmap, x, y, width, height: c.int, flip: Bitmap_Flip)

// Draws a line from `x1, y1` to `x2, y2` with a stroke width of `width`.
draw_line          : proc "c" (x1, y1, x2, y2, width: c.int, color: Color)

// Draws a filled triangle with points at `x1, y1`, `x2, y2`, and `x3, y3`.
fill_triangle      : proc "c" (x1, y1, x2, y2, x3, y3: c.int, color: Color)

// Draws a `width` by `height` rect at `x, y`.
draw_rect          : proc "c" (x, y, width, height: c.int, color: Color)

// Draws a filled `width` by `height` rect at `x, y`.
fill_rect          : proc "c" (x, y, width, height: c.int, color: Color)

// Draws an ellipse inside the rectangle `{x, y, width, height}` of width `line_width` (inset from the rectangle bounds). 
// 
// If `start_angle != end_angle`, this draws an arc between the given angles. 
// Angles are given in degrees, clockwise from due north.
draw_ellipse       : proc "c" (x, y, width, height, line_width: c.int, start_angle, end_angle: f32, color: Color)

// Fills an ellipse inside the rectangle `{x, y, width, height}`. 
// 
// If `start_angle != end_angle`, this draws a wedge/Pacman between the given angles. 
// Angles are given in degrees, clockwise from due north.
fill_ellipse       : proc "c" (x, y, width, height: c.int, start_angle, end_angle: f32, color: Color)

// Draws the bitmap scaled to `x_scale` and `y_scale` with its upper-left corner at location `x, y`. 
// 
// Note that `flip` is not available when drawing scaled bitmaps but negative scale values will achieve the same effect.
draw_scaled_bitmap : proc "c" (bitmap: Bitmap, x, y: c.int, x_scale, y_scale: f32)

// Draws the given text using the provided options. 
// If no font has been set with setFont, the default system font Asheville Sans 14 Light is used.
draw_text          : proc "c" (text: cstring, len: u32, encoding: String_Encoding, x, y: c.int) -> i32

// Allocates and returns a new `width` by `height` Bitmap filled with `bg_color`.
new_bitmap         : proc "c" (width, height: c.int, bg_color: Color) -> Bitmap 

// Frees the given `bitmap`.
free_bitmap        : proc "c" (bitmap: Bitmap) 

// Allocates and returns a new Bitmap from the file at `path`. If there is no file at `path`, the procedure returns nil.
load_bitmap        : proc "c" (path: cstring, out_err: ^cstring) -> Bitmap

// Returns a new Bitmap that is an exact copy of `bitmap`.
copy_bitmap        : proc "c" (bitmap: Bitmap) -> Bitmap

// Loads the image at `path` into the previously allocated `bitmap`.
load_into_bitmap   : proc "c" (path: cstring, bitmap: Bitmap, out_err: ^cstring) 

// Gets various info about `bitmap` including its `width` and `height` and raw pixel data. 
// 
// The data is 1 bit per pixel packed format, in MSB order; in other words, the high bit of the first byte in `data` is the top left pixel of the image. 
// If the bitmap has a mask, a multipointer of its data is returned in `mask`, else nil is returned.
get_bitmap_data    : proc "c" (bitmap: Bitmap, out_width, out_height, out_row_bytes: ^c.int, out_mask, out_data: ^[^]u8)

// Clears `bitmap`, filling with the given `background_color`.
clear_bitmap       : proc "c" (bitmap: Bitmap, bg_color: Color)

// Returns a new, rotated and scaled Bitmap based on the given `bitmap`.
rotated_bitmap     : proc "c" (bitmap: Bitmap, rotation, x_scale, y_scale: f32, out_alloced_size: ^c.int) -> Bitmap

// Allocates and returns a new Bitmap_Table that can hold `count` `width` by `height` Bitmaps.
new_bitmap_table       : proc "c" (count, width, height: c.int) -> Bitmap_Table

// Frees the given Bitmap_Table.
free_bitmap_table      : proc "c" (table: Bitmap_Table) 

// Loads the imagetable at `path` into the previously allocated `table`.
load_bitmap_table      : proc "c" (path: cstring, out_err: ^cstring) -> Bitmap_Table

// Returns the Font object for the font file at `path`. 
// In case of error, `err` points to a string describing the error.
load_into_bitmap_table : proc "c" (path: cstring, table: Bitmap_Table, out_err: ^cstring)

// Returns the `idx` bitmap in table, If `idx` is out of bounds, the function returns nil.
get_table_bitmap       : proc "c" (table: Bitmap_Table, idx: c.int) -> Bitmap


// Returns the Font object for the font file at `path`. 
// In case of error, `err` points to a string describing the error.
load_font          : proc "c" (path: cstring, out_err: ^cstring) -> Font

// Returns a Font_Page object for the given character code. 
// 
// Each Font_Page contains information for 256 characters; 
// specifically, if `(ch1 & ~0xff) == (ch2 & ~0xff)` then `ch1` and `ch2` belong to the same page and the same 
// Font_Page can be used to fetch the character data for both instead of searching for the page twice.
get_font_page      : proc "c" (font: Font, ch: u32) -> Font_Page

// Returns a Font_Glyph object for character `ch` in Font_Page `page`, and optionally returns the glyph's bitmap and advance value.
get_page_glyph     : proc "c" (page: Font_Page, ch: u32, bitmap: ^Bitmap, advance: ^(c.int)) -> Font_Glyph

// Returns the kerning adjustment between characters `glyph_code` and `next_code` as specified by the font.
get_glyph_kerning  : proc "c" (glyph: Font_Glyph, glyph_code, next_code: u32) -> c.int 

// returns the width of the given text in the given font.
get_text_width     : proc "c" (font: Font, text: cstring, len: u32, encoding: String_Encoding, tracking: c.int) -> i32


// Returns the current display frame buffer. 
// 
// Rows are 32-bit aligned, so the row stride is 52 bytes, with the extra 2 bytes per row ignored. 
// Bytes are MSB-ordered; i.e., the pixel in column 0 is the 0x80 bit of the first byte of the row.
get_frame                  : proc "c" () -> [^]u8

// Returns the raw bits in the display buffer, the last completed frame.
// 
// Rows are 32-bit aligned, so the row stride is 52 bytes, with the extra 2 bytes per row ignored. 
// Bytes are MSB-ordered; i.e., the pixel in column 0 is the 0x80 bit of the first byte of the row.
get_display_frame          : proc "c" () -> [^]u8

// Only valid in the Simulator, returns the debug framebuffer as a bitmap. 
// Procedure is nil on device.
get_debug_bitmap           : proc "c" () -> Bitmap 

// Returns a copy the contents of the working frame buffer as a bitmap. 
// 
// Allocates: The caller is responsible for freeing the returned bitmap with `free_bitmap()`.
copy_frame_buffer_bitmap   : proc "c" () -> Bitmap 

// After updating pixels in the buffer returned by `get_frame()`, you must tell the graphics system which rows were updated. 
// This procedure marks a contiguous range of rows as updated (e.g., `mark_updated_rows(0,LCD_ROWS-1)` tells the system to update the entire display). 
// 
// Both “start” and “end” are included in the range.
mark_updated_rows          : proc "c" (start, end: c.int) 

// Manually flushes the current frame buffer out to the display. 
// This procedure is automatically called after each pass through the run loop, so there shouldn’t be any need to call it yourself.
display                    : proc "c" ()


// ==============================================================================================================

// Sets `color` to an 8 x 8 pattern using the given `bitmap`. 
// `x, y` indicates the top left corner of the 8 x 8 pattern.
//
// Since 1.0
set_color_to_pattern : proc "c" (color: Color, bitmap: Bitmap, x, y: c.int) 

// Returns true if any of the opaque pixels in `bitmap_1` when positioned at `x_1, y1` with `flip_1` 
// overlap any of the opaque pixels in `bitmap_2` at `x_2, y_2` with `flip_2` within the non-empty `rect`, 
// or false if no pixels overlap or if one or both fall completely outside of `rect`.
//
// Since 1.0
check_mask_collision : proc "c" (bitmap_1: Bitmap, x_1, y_1: c.int, flip_1: Bitmap_Flip, bitmap_2: Bitmap, x_2, y_2: i32, flip_2: Bitmap_Flip, rect: Rect) -> i32


// ==============================================================================================================

// Sets the current clip rect in screen coordinates.
//
// Since 1.1
set_screen_clip_rect : proc "c" (x, y, width, height: c.int)


// ==============================================================================================================

// Fills the polygon with vertices at the given coordinates (an array of `2 * nPoints` ints containing alternating x and y values) 
// using the given color and fill, or winding, rule. See [Wikipedia: Nonzero-rule](https://en.wikipedia.org/wiki/Nonzero-rule) for an explanation of the winding rule.
//
// Since 1.1.1
fill_polygon       : proc "c" (n_points: c.int, coords: [^]i32, color: Color, fill_rule: Polygon_Fill_Rule) 

// Returns the height of the given font.
// 
// Since 1.1.1
get_font_height    : proc "c" (font: Font) -> u8


// ==============================================================================================================

// Returns a bitmap containing the contents of the display buffer. 
// 
// The system owns this bitmap - do not free it!
// 
// Since 1.7
get_display_buffer_bitmap  : proc "c" () -> Bitmap

// Draws the `bitmap` scaled to `x_scale` and `y_scale` then rotated by `degrees` with its center 
// as given by proportions `x_center` and `y_center` at `x`, `y`; that is: if `x_center` and 
// `y_center` are both 0.5 the center of the image is at (`x`,`y`), if `x_cetner` and `y_center` 
// are both 0 the top left corner of the image (before rotation) is at (`x`,`y`), etc.
// 
// Since 1.7
draw_rotated_bitmap        : proc "c" (bitmap: Bitmap, x, y: c.int, rotation, center_x, center_y, x_scale, y_scale: f32)

// Sets the leading adjustment (added to the leading specified in the font) to use when drawing text.
//
// Since 1.7
set_text_leading           : proc "c" (line_height_adjustment: c.int) 


// ==============================================================================================================

// Sets a mask image for the given bitmap. The set mask must be the same size as the target bitmap.
// 
// Since 1.8
set_bitmap_mask : proc "c" (bitmap, mask: Bitmap) -> c.int

// Gets a mask image for the given `bitmap`. 
//
// if the image doesn't have a mask, `get_bitmap_mask()` returns nil.
//
// Since 1.8
get_bitmap_mask : proc "c" (bitmap: Bitmap) -> Bitmap 


// ==============================================================================================================

// Sets the stencil used for drawing. If `tile` is true the stencil image will be tiled. 
// 
// Tiled stencils must have width equal to a multiple of 32 pixels.
// 
// Since 1.10
set_stencil_image : proc "c" (stencil: Bitmap, tile: c.int)


// ==============================================================================================================

// Returns a Font object wrapping the Font_Data `data` comprising the contents (minus 16-byte header) of an uncompressed pft file. 
// 
// `wide` corresponds to the flag in the header indicating whether the font contains glyphs at codepoints above U+1FFFF.
// 
// Since 1.12
make_font_from_data : proc "c" (data: Font_Data, wide: c.int) -> Font


// ==============================================================================================================
// 2.1
get_text_tracking : proc "c" () -> c.int
