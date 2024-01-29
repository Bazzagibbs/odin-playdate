package playdate_common

import "core:c"

//   ///////////
//  // TYPES //
// ///////////

Display_Scale_Flag :: enum u32 {
    _1 = 1,
    _2 = 2,
    _4 = 4,
    _8 = 8,
}

Display_Mosaic_Flag :: enum u32 {
    _0 = 0,
    _1 = 1,
    _2 = 2,
    _3 = 3,
}

// =================================================================


//   ////////////////
//  // PROC TYPES //
// ////////////////

Proc_Display_Get_Width        :: #type proc "c" () -> c.int 
Proc_Display_Get_Height       :: #type proc "c" () -> c.int
Proc_Display_Set_Refresh_Rate :: #type proc "c" (rate: f32) 
Proc_Display_Set_Inverted     :: #type proc "c" (inverted: b32)
Proc_Display_Set_Scale        :: #type proc "c" (scale: Display_Scale_Flag) 
Proc_Display_Set_Mosaic       :: #type proc "c" (x, y: Display_Mosaic_Flag)
Proc_Display_Set_Flipped      :: #type proc "c" (x_flipped, y_flipped: b32) 
Proc_Display_Set_Offset       :: #type proc "c" (x, y: c.int)

// =================================================================


//   ////////////////
//  // API STRUCT //
// ////////////////

Api_Display_Procs :: struct {
    get_width        : Proc_Display_Get_Width,
    get_height       : Proc_Display_Get_Height,
    set_refresh_rate : Proc_Display_Set_Refresh_Rate,
    set_inverted     : Proc_Display_Set_Inverted,
    set_scale        : Proc_Display_Set_Scale,
    set_mosaic       : Proc_Display_Set_Mosaic,
    set_flipped      : Proc_Display_Set_Flipped,
    set_offset       : Proc_Display_Set_Offset,
}
