package playdate_graphics_video

import "core:c"

// Opens the `pdv` file at `path` and returns a new video player object for rendering its frames.
load_video         : proc "c" (path: cstring) -> Video_Player

// Frees the given video player.
free_player        : proc "c" (player: Video_Player) 

// Sets the rendering destination for the video player to the given bitmap. 
// 
// Returns false on failure, and sets an error message that can be read via `video.get_error()`.
set_context        : proc "c" (player: Video_Player, ctx: Bitmap) -> (ok: b32)

// Sets the rendering destination for the video player to the screen.
use_screen_context : proc "c" (player: Video_Player)

// Renders frame number n into the current context. 
// 
// In case of error, the function returns false and sets an error message that can be read via getError().
render_frame       : proc "c" (player: Video_Player, n: c.int) -> (ok: b32)

// Returns text describing the most recent error.
get_error          : proc "c" (player: Video_Player) -> cstring

// Retrieves information about the video.
get_info           : proc "c" (player: Video_Player, out_width, out_height: ^c.int, out_frame_rate: ^f32, out_frame_count, out_current_frame: ^i32)

// Gets the rendering destination for the video player. 
//
// If no rendering context has been set, ALLOCATES a context bitmap with the same dimensions as the video.
get_context        : proc "c" (player: Video_Player) -> Bitmap
