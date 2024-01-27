package playdate_display

import "core:c"


// Returns the height of the display, taking the current scale into account; 
//
// e.g., if the scale is 2, this function returns 120 instead of 240. 
get_width: proc "c" () -> i32 


// Returns the width of the display, taking the current scale into account; 
// 
// e.g., if the scale is 2, this function returns 200 instead of 400.
get_height: proc "c" () -> i32


// Sets the nominal refresh rate in frames per second. 
// The default is 30 fps, which is a recommended figure that balances animation smoothness with performance and power considerations. 
// Maximum is 50 fps.
//
// If rate is 0, the game’s update callback (either Lua’s `playdate.update()` or the function specified by `system.setUpdateCallback()`) is called as soon as possible. 
// Since the display refreshes line-by-line, and unchanged lines aren’t sent to the display, the update cycle will be faster than 30 times a second but at an indeterminate rate.
set_refresh_rate: proc "c" (rate: f32) 


// If `inverted` is true, the frame buffer is drawn inverted—black instead of white, and vice versa.
set_inverted: proc "c" (inverted: b32)


// Sets the display scale factor. Valid values for scale are 1, 2, 4, and 8.
// 
// The top-left corner of the frame buffer is scaled up to fill the display; 
// e.g., if the scale is set to 4, the pixels in rectangle [0,100] x [0,60] are drawn on the screen as 4 x 4 squares.
set_scale: proc "c" (scale: Scale_Flag) 


// Adds a mosaic effect to the display. 
//
// Valid x and y values are between 0 and 3, inclusive.
set_mosaic: proc "c" (x, y: Mosaic_Flag)


// Flips the display on the x or y axis, or both.
set_flipped: proc "c" (x_flipped, y_flipped: bool) 


// Offsets the display by the given amount. 
// Areas outside of the displayed area are filled with the current background color.
set_offset: proc "c" (x, y: i32)
