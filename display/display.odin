package playdate_display

import "../common"
import ".."

Scale_Flag  :: common.Display_Scale_Flag

Mosaic_Flag :: common.Display_Mosaic_Flag

// =================================================================


// Returns the height of the display, taking the current scale into account; 
//
// e.g., if the scale is 2, this function returns 120 instead of 240. 
get_width : common.Proc_Display_Get_Width


// Returns the width of the display, taking the current scale into account; 
// 
// e.g., if the scale is 2, this function returns 200 instead of 400.
get_height : common.Proc_Display_Get_Height


// Sets the nominal refresh rate in frames per second. 
// The default is 30 fps, which is a recommended figure that balances animation smoothness with performance and power considerations. 
// Maximum is 50 fps.
//
// If rate is 0, the game’s update callback (either Lua’s `playdate.update()` or the function specified by `system.setUpdateCallback()`) is called as soon as possible. 
// Since the display refreshes line-by-line, and unchanged lines aren’t sent to the display, the update cycle will be faster than 30 times a second but at an indeterminate rate.
set_refresh_rate : common.Proc_Display_Set_Refresh_Rate


// If `inverted` is true, the frame buffer is drawn inverted—black instead of white, and vice versa.
set_inverted : common.Proc_Display_Set_Inverted


// Sets the display scale factor. Valid values for scale are 1, 2, 4, and 8.
// 
// The top-left corner of the frame buffer is scaled up to fill the display; 
// e.g., if the scale is set to 4, the pixels in rectangle [0,100] x [0,60] are drawn on the screen as 4 x 4 squares.
set_scale : common.Proc_Display_Set_Scale


// Adds a mosaic effect to the display. 
//
// Valid x and y values are between 0 and 3, inclusive.
set_mosaic : common.Proc_Display_Set_Mosaic


// Flips the display on the x or y axis, or both.
set_flipped : common.Proc_Display_Set_Flipped


// Offsets the display by the given amount. 
// Areas outside of the displayed area are filled with the current background color.
set_offset : common.Proc_Display_Set_Offset

// =================================================================


//   /////////////////
//  // LOADER PROC //
// /////////////////

// Position in PlaydateAPI struct (see pd_api.h)
API_INDEX :: 4

@(init)
_register :: proc() {
    playdate._loaders[API_INDEX] = _load_procs
}

_load_procs :: proc "contextless" (api: ^playdate.Api) {
    get_width        = api.display.get_width
    get_height       = api.display.get_height
    set_refresh_rate = api.display.set_refresh_rate
    set_inverted     = api.display.set_inverted
    set_scale        = api.display.set_scale
    set_mosaic       = api.display.set_mosaic
    set_flipped      = api.display.set_flipped
    set_offset       = api.display.set_offset
}
