package playdate_graphics_video

import "../../common"

Bitmap          :: common.Bitmap

Video_Player    :: distinct common.Handle

Video_Player_Info :: struct {
    width           : i32, 
    height          : i32,
    frame_rate      : f32,
    frame_count     : i32, 
    current_frame   : i32,
}

