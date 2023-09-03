package playdate_display

Proc_Get_Width          :: #type proc "c" () -> i32
Proc_Get_Height         :: #type proc "c" () -> i32
Proc_Set_Refresh_Rate   :: #type proc "c" (rate: f32)
Proc_Set_Inverted       :: #type proc "c" (flag: i32)
Proc_Set_Scale          :: #type proc "c" (scale: u32)
Proc_Set_Mosaic         :: #type proc "c" (x, y: u32)
Proc_Set_Flipped        :: #type proc "c" (x, y: i32)
Proc_Set_Offset         :: #type proc "c" (x, y: i32)

vtable: ^VTable

VTable :: struct {
    get_width          : Proc_Get_Width,
    get_height         : Proc_Get_Height,
    set_refresh_rate   : Proc_Set_Refresh_Rate,
    set_inverted       : Proc_Set_Inverted,
    set_scale          : Proc_Set_Scale,
    set_mosaic         : Proc_Set_Mosaic,
    set_flipped        : Proc_Set_Flipped,
    set_offset         : Proc_Set_Offset,
}

