package playdate_graphics_video

import gfx ".."
import "../../common"

Player :: distinct common.Handle

load_video :: proc(path: cstring) -> Player

free_player :: proc(video_player: Player)

set_context :: proc(video_player: Player, ctx: gfx.Bitmap) -> i32

use_screen_context :: proc(video_player: Player)

get_error :: proc(video_player: Player) -> cstring

get_info :: proc(video_player: Player) -> (width, height: i32, frame_rate: f32, frame_count, current_frame: i32) {
    panic("Not implemented")
}


get_context :: proc(video_player: Player) -> gfx.Bitmap
