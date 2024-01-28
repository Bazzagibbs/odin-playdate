package playdate_display

//   ////////////////
//  // PROC TYPES //
// ////////////////

Proc_Get_Width        :: #type proc "c" () -> i32 
Proc_Get_Height       :: #type proc "c" () -> i32
Proc_Set_Refresh_Rate :: #type proc "c" (rate: f32) 
Proc_Set_Inverted     :: #type proc "c" (inverted: b32)
Proc_Set_Scale        :: #type proc "c" (scale: Scale_Flag) 
Proc_Set_Mosaic       :: #type proc "c" (x, y: Mosaic_Flag)
Proc_Set_Flipped      :: #type proc "c" (x_flipped, y_flipped: bool) 
Proc_Set_Offset       :: #type proc "c" (x, y: i32)


// =================================================================


//   ////////////////
//  // API STRUCT //
// ////////////////

Api_Procs :: struct {
    get_width        : Proc_Get_Width,
    get_height       : Proc_Get_Height,
    set_refresh_rate : Proc_Set_Refresh_Rate,
    set_inverted     : Proc_Set_Inverted,
    set_scale        : Proc_Set_Scale,
    set_mosaic       : Proc_Set_Mosaic,
    set_flipped      : Proc_Set_Flipped,
    set_offset       : Proc_Set_Offset,
}

// =================================================================


//   /////////////////
//  // LOADER PROC //
// /////////////////

_load_procs :: proc(api_procs: ^Api_Procs) {
    get_width        = api_procs.get_width
    get_height       = api_procs.get_height
    set_refresh_rate = api_procs.set_refresh_rate
    set_inverted     = api_procs.set_inverted
    set_scale        = api_procs.set_scale
    set_mosaic       = api_procs.set_mosaic
    set_flipped      = api_procs.set_flipped
    set_offset       = api_procs.set_offset
}
