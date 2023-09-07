package playdate_graphics_video

import "../../common"

Player :: distinct common.Handle

Player_Info :: struct {
    width           : i32, 
    height          : i32,
    frame_rate      : f32,
    frame_count     : i32, 
    current_frame   : i32,
}


// Opens the `pdv` file at `path` and returns a new video player object for rendering its frames.
load_video :: #force_inline proc "contextless" (path: cstring) -> Player {
    return vtable.load_video(path)
}

// Frees the given video player.
free_player :: #force_inline proc "contextless" (video_player: Player) {
    vtable.free_player(video_player)
}

// Sets the rendering destination for the video player to the given bitmap. 
// 
// Returns false on failure, and sets an error message that can be read via `video.get_error()`.
set_context :: #force_inline proc "contextless" (video_player: Player, ctx: common.Bitmap) -> bool {
    return vtable.set_context(video_player, ctx) != 0
}

// Sets the rendering destination for the video player to the screen.
use_screen_context :: #force_inline proc "contextless" (video_player: Player) {
    vtable.use_screen_context(video_player)
}

// Returns text describing the most recent error.
get_error :: #force_inline proc "contextless" (video_player: Player) -> cstring {
    return vtable.get_error(video_player)
}

// Retrieves information about the video.
get_info :: #force_inline proc "contextless" (video_player: Player) -> Player_Info {
    pi: Player_Info
    vtable.get_info(video_player, &pi.width, &pi.height, &pi.frame_rate, &pi.frame_count, &pi.current_frame)
    return pi
}

// Gets the rendering destination for the video player. 
//
// If no rendering context has been set, ALLOCATES a context bitmap with the same dimensions as the video.
get_context :: #force_inline proc "contextless" (video_player: Player) -> common.Bitmap {
    return vtable.get_context(video_player)
}
