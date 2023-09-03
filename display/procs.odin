package playdate_display

// Returns the height of the display, taking the current scale into account; 
//
// e.g., if the scale is 2, this function returns 120 instead of 240. 
get_width :: proc() -> i32 {
    panic("Not implemented")
}
// Returns the width of the display, taking the current scale into account; 
// 
// e.g., if the scale is 2, this function returns 200 instead of 400.
get_height :: proc() -> i32 {
    panic("Not implemented")
}

set_refresh_rate :: proc(rate: f32) {
    panic("Not implemented")
}

// If `inverted` is true, the frame buffer is drawn inverted—black instead of white, and vice versa.
set_inverted :: proc(inverted: bool) {
    panic("Not implemented")
}

// Sets the display scale factor. Valid values for scale are 1, 2, 4, and 8.
// 
// The top-left corner of the frame buffer is scaled up to fill the display; 
// e.g., if the scale is set to 4, the pixels in rectangle [0,100] x [0,60] are drawn on the screen as 4 x 4 squares.
set_scale :: proc(scale: Scale_Flag) {
    panic("Not implemented")
}

// Adds a mosaic effect to the display. 
//
// Valid x and y values are between 0 and 3, inclusive.
set_mosaic :: proc(x, y: Mosaic_Flag) {
    panic("Not implemented")
}


// Flips the display on the x or y axis, or both.
set_flipped :: proc(x_flipped, y_flipped: bool) {
    panic("Not implemented")
}

// Offsets the display by the given amount. Areas outside of the displayed area are filled with the current background color.
set_offset :: proc(x, y: i32) {
    panic("Not implemented")
}