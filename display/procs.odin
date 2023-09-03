package playdate_display

// Returns the height of the display, taking the current scale into account; 
//
// e.g., if the scale is 2, this function returns 120 instead of 240. 
get_width :: #force_inline proc "c" () -> i32 {
    return vtable.get_width()
}
// Returns the width of the display, taking the current scale into account; 
// 
// e.g., if the scale is 2, this function returns 200 instead of 400.
get_height :: #force_inline proc "c" () -> i32 {
    return vtable.get_height()
}

set_refresh_rate :: #force_inline proc "c" (rate: f32) {
    vtable.set_refresh_rate(rate)
}

// If `inverted` is true, the frame buffer is drawn inverted—black instead of white, and vice versa.
set_inverted :: #force_inline proc "c" (inverted: bool) {
    vtable.set_inverted(i32(inverted))
}

// Sets the display scale factor. Valid values for scale are 1, 2, 4, and 8.
// 
// The top-left corner of the frame buffer is scaled up to fill the display; 
// e.g., if the scale is set to 4, the pixels in rectangle [0,100] x [0,60] are drawn on the screen as 4 x 4 squares.
set_scale :: #force_inline proc "c" (scale: Scale_Flag) {
    vtable.set_scale(u32(scale))
}

// Adds a mosaic effect to the display. 
//
// Valid x and y values are between 0 and 3, inclusive.
set_mosaic :: #force_inline proc "c" (x, y: Mosaic_Flag) {
    vtable.set_mosaic(u32(x), u32(y))
}


// Flips the display on the x or y axis, or both.
set_flipped :: #force_inline proc "c" (x_flipped, y_flipped: bool) {
    vtable.set_flipped(i32(x_flipped), i32(y_flipped))
}

// Offsets the display by the given amount. 
// Areas outside of the displayed area are filled with the current background color.
set_offset :: #force_inline proc "c" (x, y: i32) {
    vtable.set_offset(x, y)
}