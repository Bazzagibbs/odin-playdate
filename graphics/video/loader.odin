package playdate_graphics_video

import "core:c"

//   ////////////////
//  // PROC TYPES //
// ////////////////

Proc_Load_Video         :: #type proc "c" (path: cstring) -> Video_Player
Proc_Free_Player        :: #type proc "c" (player: Video_Player) 
Proc_Set_Context        :: #type proc "c" (player: Video_Player, ctx: Bitmap) -> (ok: b32)
Proc_Use_Screen_Context :: #type proc "c" (player: Video_Player)
Proc_Render_Frame       :: #type proc "c" (player: Video_Player, n: c.int) -> (ok: b32)
Proc_Get_Error          :: #type proc "c" (player: Video_Player) -> cstring
Proc_Get_Info           :: #type proc "c" (player: Video_Player, out_width, out_height: ^c.int, out_frame_rate: ^f32, out_frame_count, out_current_frame: ^i32)
Proc_Get_Context        :: #type proc "c" (player: Video_Player) -> Bitmap

// =================================================================


//   ////////////////
//  // API STRUCT //
// ////////////////

Api_Procs :: struct {
    load_video         : Proc_Load_Video,        
    free_player        : Proc_Free_Player,       
    set_context        : Proc_Set_Context,       
    use_screen_context : Proc_Use_Screen_Context,
    render_frame       : Proc_Render_Frame,      
    get_error          : Proc_Get_Error,         
    get_info           : Proc_Get_Info,          
    get_context        : Proc_Get_Context,       
}

// =================================================================


//   /////////////////
//  // LOADER PROC //
// /////////////////

_load_procs :: proc(api_procs: ^Api_Procs) {
    load_video         = api_procs.load_video        
    free_player        = api_procs.free_player       
    set_context        = api_procs.set_context       
    use_screen_context = api_procs.use_screen_context
    render_frame       = api_procs.render_frame      
    get_error          = api_procs.get_error         
    get_info           = api_procs.get_info          
    get_context        = api_procs.get_context       
}
