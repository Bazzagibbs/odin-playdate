// The drawing functions use a context stack to select the drawing target, for setting a stencil, changing the draw mode, etc. 
// The stack is unwound at the beginning of each update cycle, with drawing restored to target the display.
package playdate_graphics

import "core:c"

// Clears the entire display, filling it with `color`.
clear                     : Proc_Clear

// Sets the background color shown when the display is offset (see `set_offset()`) or for clearing dirty areas in the sprite system.
set_background_color      : Proc_Set_Background_Color

// DEPRECATED in favor of `set_stenciL_image`, which adds a "tile" flag.
// 
// Sets the stencil used for drawing.
set_stencil               : Proc_Set_Stencil

// Sets the mode used for drawing bitmaps. Note that text drawing uses bitmaps, so this affects how fonts are displayed as well. 
set_draw_mode             : Proc_Set_Draw_Mode

// Offsets the origin point for all drawing calls to `dx, dy` (can be negative).
// 
// This is useful, for example, for centering a "camera" on a sprite that is moving around a world larger than the screen.
set_draw_offset           : Proc_Set_Draw_Offset

// Sets the clipping rectangle for sprite drawing.
set_clip_rect             : Proc_Set_Clip_Rect

// Clears the sprite’s clipping rectangle.
clear_clip_rect           : Proc_Clear_Clip_Rect

// Sets the end cap style used in the line drawing procedures.  
set_line_cap_style        : Proc_Set_Line_Cap_Style

// Sets the font to use in subsequent `draw_text()` calls.
set_font                  : Proc_Set_Font

// Sets the tracking to use when drawing text.
set_text_tracking         : Proc_Set_Text_Tracking

// Push a new drawing context for drawing into the given bitmap. 
// 
// If `target` is nil, the drawing procedures will use the display framebuffer.
push_context              : Proc_Push_Context

// Pops a context off the stack (if any are left), restoring the drawing settings from before the context was pushed.
pop_context               : Proc_Pop_Context



// Draws the `bitmap` with its upper-left corner at location `x, y`, using the given flip orientation.
draw_bitmap               : Proc_Draw_Bitmap

// Draws the `bitmap` with its upper-left corner at location `x, y` tiled inside a `width` by `height` rectangle.
tile_bitmap               : Proc_Tile_Bitmap

// Draws a line from `x1, y1` to `x2, y2` with a stroke width of `width`.
draw_line                 : Proc_Draw_Line

// Draws a filled triangle with points at `x1, y1`, `x2, y2`, and `x3, y3`.
fill_triangle             : Proc_Fill_Triangle

// Draws a `width` by `height` rect at `x, y`.
draw_rect                 : Proc_Draw_Rect

// Draws a filled `width` by `height` rect at `x, y`.
fill_rect                 : Proc_Fill_Rect

// Draws an ellipse inside the rectangle `{x, y, width, height}` of width `line_width` (inset from the rectangle bounds). 
// 
// If `start_angle != end_angle`, this draws an arc between the given angles. 
// Angles are given in degrees, clockwise from due north.
draw_ellipse              : Proc_Draw_Ellipse

// Fills an ellipse inside the rectangle `{x, y, width, height}`. 
// 
// If `start_angle != end_angle`, this draws a wedge/Pacman between the given angles. 
// Angles are given in degrees, clockwise from due north.
fill_ellipse              : Proc_Fill_Ellipse

// Draws the bitmap scaled to `x_scale` and `y_scale` with its upper-left corner at location `x, y`. 
// 
// Note that `flip` is not available when drawing scaled bitmaps but negative scale values will achieve the same effect.
draw_scaled_bitmap        : Proc_Draw_Scaled_Bitmap

// Draws the given text using the provided options. 
// If no font has been set with setFont, the default system font Asheville Sans 14 Light is used.
draw_text                 : Proc_Draw_Text

// Allocates and returns a new `width` by `height` Bitmap filled with `bg_color`.
new_bitmap                : Proc_New_Bitmap

// Frees the given `bitmap`.
free_bitmap               : Proc_Free_Bitmap

// Allocates and returns a new Bitmap from the file at `path`. If there is no file at `path`, the procedure returns nil.
load_bitmap               : Proc_Load_Bitmap

// Returns a new Bitmap that is an exact copy of `bitmap`.
copy_bitmap               : Proc_Copy_Bitmap

// Loads the image at `path` into the previously allocated `bitmap`.
load_into_bitmap          : Proc_Load_Into_Bitmap

// Gets various info about `bitmap` including its `width` and `height` and raw pixel data. 
// 
// The data is 1 bit per pixel packed format, in MSB order; in other words, the high bit of the first byte in `data` is the top left pixel of the image. 
// If the bitmap has a mask, a multipointer of its data is returned in `mask`, else nil is returned.
get_bitmap_data           : Proc_Get_Bitmap_Data

// Clears `bitmap`, filling with the given `background_color`.
clear_bitmap              : Proc_Clear_Bitmap

// Returns a new, rotated and scaled Bitmap based on the given `bitmap`.
rotated_bitmap            : Proc_Rotated_Bitmap

// Allocates and returns a new Bitmap_Table that can hold `count` `width` by `height` Bitmaps.
new_bitmap_table          : Proc_New_Bitmap_Table

// Frees the given Bitmap_Table.
free_bitmap_table         : Proc_Free_Bitmap_Table

// Loads the imagetable at `path` into the previously allocated `table`.
load_bitmap_table         : Proc_Load_Bitmap_Table

// Returns the Font object for the font file at `path`. 
// In case of error, `err` points to a string describing the error.
load_into_bitmap_table    : Proc_Load_Into_Bitmap_Table

// Returns the `idx` bitmap in table, If `idx` is out of bounds, the function returns nil.
get_table_bitmap          : Proc_Get_Table_Bitmap


// Returns the Font object for the font file at `path`. 
// In case of error, `err` points to a string describing the error.
load_font                 : Proc_Load_Font

// Returns a Font_Page object for the given character code. 
// 
// Each Font_Page contains information for 256 characters; 
// specifically, if `(ch1 & ~0xff) == (ch2 & ~0xff)` then `ch1` and `ch2` belong to the same page and the same 
// Font_Page can be used to fetch the character data for both instead of searching for the page twice.
get_font_page             : Proc_Get_Font_Page

// Returns a Font_Glyph object for character `ch` in Font_Page `page`, and optionally returns the glyph's bitmap and advance value.
get_page_glyph            : Proc_Get_Page_Glyph

// Returns the kerning adjustment between characters `glyph_code` and `next_code` as specified by the font.
get_glyph_kerning         : Proc_Get_Glyph_Kerning

// returns the width of the given text in the given font.
get_text_width            : Proc_Get_Text_Width


// Returns the current display frame buffer. 
// 
// Rows are 32-bit aligned, so the row stride is 52 bytes, with the extra 2 bytes per row ignored. 
// Bytes are MSB-ordered; i.e., the pixel in column 0 is the 0x80 bit of the first byte of the row.
get_frame                 : Proc_Get_Frame

// Returns the raw bits in the display buffer, the last completed frame.
// 
// Rows are 32-bit aligned, so the row stride is 52 bytes, with the extra 2 bytes per row ignored. 
// Bytes are MSB-ordered; i.e., the pixel in column 0 is the 0x80 bit of the first byte of the row.
get_display_frame         : Proc_Get_Display_Frame

// Only valid in the Simulator, returns the debug framebuffer as a bitmap. 
// Procedure is nil on device.
get_debug_bitmap          : Proc_Get_Debug_Bitmap

// Returns a copy the contents of the working frame buffer as a bitmap. 
// 
// Allocates: The caller is responsible for freeing the returned bitmap with `free_bitmap()`.
copy_frame_buffer_bitmap  : Proc_Copy_Frame_Buffer_Bitmap

// After updating pixels in the buffer returned by `get_frame()`, you must tell the graphics system which rows were updated. 
// This procedure marks a contiguous range of rows as updated (e.g., `mark_updated_rows(0,LCD_ROWS-1)` tells the system to update the entire display). 
// 
// Both “start” and “end” are included in the range.
mark_updated_rows         : Proc_Mark_Updated_Rows

// Manually flushes the current frame buffer out to the display. 
// This procedure is automatically called after each pass through the run loop, so there shouldn’t be any need to call it yourself.
display                   : Proc_Display


// ==============================================================================================================

// Sets `color` to an 8 x 8 pattern using the given `bitmap`. 
// `x, y` indicates the top left corner of the 8 x 8 pattern.
//
// Since 1.0
set_color_to_pattern      : Proc_Set_Color_To_Pattern

// Returns true if any of the opaque pixels in `bitmap_1` when positioned at `x_1, y1` with `flip_1` 
// overlap any of the opaque pixels in `bitmap_2` at `x_2, y_2` with `flip_2` within the non-empty `rect`, 
// or false if no pixels overlap or if one or both fall completely outside of `rect`.
//
// Since 1.0
check_mask_collision      : Proc_Check_Mask_Collision


// ==============================================================================================================

// Sets the current clip rect in screen coordinates.
//
// Since 1.1
set_screen_clip_rect      : Proc_Set_Screen_Clip_Rect


// ==============================================================================================================

// Fills the polygon with vertices at the given coordinates (an array of `2 * nPoints` ints containing alternating x and y values) 
// using the given color and fill, or winding, rule. See [Wikipedia: Nonzero-rule](https://en.wikipedia.org/wiki/Nonzero-rule) for an explanation of the winding rule.
//
// Since 1.1.1
fill_polygon              : Proc_Fill_Polygon

// Returns the height of the given font.
// 
// Since 1.1.1
get_font_height           : Proc_Get_Font_Height


// ==============================================================================================================

// Returns a bitmap containing the contents of the display buffer. 
// 
// The system owns this bitmap - do not free it!
// 
// Since 1.7
get_display_buffer_bitmap : Proc_Get_Display_Buffer_Bitmap

// Draws the `bitmap` scaled to `x_scale` and `y_scale` then rotated by `degrees` with its center 
// as given by proportions `x_center` and `y_center` at `x`, `y`; that is: if `x_center` and 
// `y_center` are both 0.5 the center of the image is at (`x`,`y`), if `x_cetner` and `y_center` 
// are both 0 the top left corner of the image (before rotation) is at (`x`,`y`), etc.
// 
// Since 1.7
draw_rotated_bitmap       : Proc_Draw_Rotated_Bitmap

// Sets the leading adjustment (added to the leading specified in the font) to use when drawing text.
//
// Since 1.7
set_text_leading          : Proc_Set_Text_Leading


// ==============================================================================================================

// Sets a mask image for the given bitmap. The set mask must be the same size as the target bitmap.
// 
// Since 1.8
set_bitmap_mask           : Proc_Set_Bitmap_Mask

// Gets a mask image for the given `bitmap`. 
//
// if the image doesn't have a mask, `get_bitmap_mask()` returns nil.
//
// Since 1.8
get_bitmap_mask           : Proc_Get_Bitmap_Mask


// ==============================================================================================================

// Sets the stencil used for drawing. If `tile` is true the stencil image will be tiled. 
// 
// Tiled stencils must have width equal to a multiple of 32 pixels.
// 
// Since 1.10
set_stencil_image         : Proc_Set_Stencil_Image


// ==============================================================================================================

// Returns a Font object wrapping the Font_Data `data` comprising the contents (minus 16-byte header) of an uncompressed pft file. 
// 
// `wide` corresponds to the flag in the header indicating whether the font contains glyphs at codepoints above U+1FFFF.
// 
// Since 1.12
make_font_from_data       : Proc_Make_Font_From_Data


// ==============================================================================================================
// 2.1
get_text_tracking         : Proc_Get_Text_Tracking
