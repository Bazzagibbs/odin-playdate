package playdate_graphics_video

import "core:c"
import "../../bindings"

Bitmap            :: bindings.Bitmap
Player            :: bindings.Video_Player
Player_Info       :: bindings.Video_Player_Info


// Opens the `pdv` file at `path` and returns a new video player object for rendering its frames.
load_video :: proc "contextless" (path: cstring) -> Player {
    return bindings.graphics.video.load_video(path)
}

// Frees the given video player.
free_player :: proc "contextless" (player: Player) {
    bindings.graphics.video.free_player(player)
}

// Sets the rendering destination for the video player to the given bitmap. 
// 
// Returns false on failure, and sets an error message that can be read via `video.get_error()`.
set_context :: proc "contextless" (player: Player, ctx: Bitmap) -> (ok: b32) {
    return bindings.graphics.video.set_context(player, ctx)
}

// Sets the rendering destination for the video player to the screen.
use_screen_context :: proc "contextless" (player: Player) {
    bindings.graphics.video.use_screen_context(player)
}

// Renders frame number n into the current context. 
// 
// In case of error, the function returns false and sets an error message that can be read via getError().
render_frame :: proc "contextless" (player: Player, n: i32) -> (ok: b32) {
    return bindings.graphics.video.render_frame(player, n)
}

// Returns text describing the most recent error.
get_error :: proc "contextless" (player: Player) -> cstring {
    return bindings.graphics.video.get_error(player)
}

// Retrieves information about the video.
get_info :: proc "contextless" (player: Player) -> (width, height: i32, frame_rate: f32, frame_count, current_frame: i32) {
    bindings.graphics.video.get_info(player, &width, &height, &frame_rate, &frame_count, &current_frame)
    return
}

// Gets the rendering destination for the video player. 
//
// If no rendering context has been set, ALLOCATES a context bitmap with the same dimensions as the video.
get_context :: proc "contextless" (player: Player) -> Bitmap {
    return bindings.graphics.video.get_context(player)
}


