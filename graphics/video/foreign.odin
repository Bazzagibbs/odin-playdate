package playdate_graphics_video

import "../../common"

Proc_Load_Video         :: #type proc "c" (path: cstring) -> Player
Proc_Free_Player        :: #type proc "c" (player: Player) 
Proc_Set_Context        :: #type proc "c" (player: Player, ctx: common.Bitmap) -> i32
Proc_Use_Screen_Context :: #type proc "c" (player: Player)
Proc_Render_Frame       :: #type proc "c" (player: Player, n: i32) -> i32
Proc_Get_Error          :: #type proc "c" (player: Player) -> cstring
Proc_Get_Info           :: #type proc "c" (player: Player, out_width, out_height: ^i32, out_frame_rate: ^f32, out_frame_count, out_current_frame: ^i32)
Proc_Get_Context        :: #type proc "c" (player: Player) -> common.Bitmap

vtable: ^VTable

VTable :: struct {
    load_video          : Proc_Load_Video,
    free_player         : Proc_Free_Player,
    set_context         : Proc_Set_Context,
    use_screen_context  : Proc_Use_Screen_Context,
    render_frame        : Proc_Render_Frame,
    get_error           : Proc_Get_Error,
    get_info            : Proc_Get_Info,
    get_context         : Proc_Get_Context,
}