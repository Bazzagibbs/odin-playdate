package playdate_graphics_video

import gfx ".."

Player :: distinct rawptr

load_video :: proc(path: cstring) -> ^Player

free_player :: proc(video_player: ^Player)

set_context :: proc(video_player: ^Player, ctx: ^gfx.Bitmap) -> i32

use_screen_context :: proc(video_player: ^Player)

get_error :: proc(video_player: ^Player) -> cstring


get_info :: proc {
    get_info_returned,
    get_info_pointers,
}

get_info_returned :: proc(video_player: ^Player) -> (width, height: i32, frame_rate: f32, frame_count, current_frame: i32) {
    get_info_pointers(video_player, &width, &height, &frame_rate, &frame_count, &current_frame)
    return
}
get_info_pointers :: proc (video_player: ^Player, out_width, out_height: ^i32, out_frame_rate: ^f32, out_frame_count, out_current_frame: ^i32) {
    panic("Not implemented")
}

get_context :: proc(video_player: ^Player) -> gfx.Bitmap
