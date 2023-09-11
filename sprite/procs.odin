package playdate_sprite


// When `redraw` is set to true, the given sprite will always redraw.
set_always_redraw :: #force_inline proc "contextless" (redraw: bool) {
    vtable.set_always_redraw(i32(redraw))
}

// Marks the given dirtyRect (in screen coordinates) as needing a redraw. 
// 
// Graphics drawing functions now call this automatically, adding their drawn areas to the sprite’s dirty list, 
// so there’s usually no need to call this manually.
add_dirty_rect :: #force_inline proc "contextless" (dirty_rect: Rect) {
    vtable.add_dirty_rect(dirty_rect)
}

// Draws every sprite in the display list.
draw_sprites :: #force_inline proc "contextless" () {
    vtable.draw_sprites()
}

// Updates and draws every sprite in the display list.
update_and_draw_sprites :: #force_inline proc "contextless" () {
    vtable.update_and_draw_sprites()
}

// Allocates and returns a new LCDSprite.
new_sprite :: #force_inline proc "contextless" () -> Sprite {
    return vtable.new_sprite()
}

// Frees the given `sprite`
free_sprite :: #force_inline proc "contextless" (sprite: Sprite) {
    vtable.free_sprite(sprite)
}

// Allocates and returns a copy of the given `sprite`.
copy :: #force_inline proc "contextless" (sprite: Sprite) -> Sprite {
    return vtable.copy(sprite)
}

// Adds the given `sprite` to the display list, so that it is drawn in the current scene.
add_sprite :: #force_inline proc "contextless" (sprite: Sprite) {
    vtable.add_sprite(sprite)
}

// Removes the given `sprite` from the display list.
remove_sprite :: #force_inline proc "contextless" (sprite: Sprite) {
    vtable.remove_sprite(sprite)
}

// Removes the given slice of sprites from the display list.
remove_sprites :: #force_inline proc "contextless" (sprites: []Sprite) {
    vtable.remove_sprites(raw_data(sprites), i32(len(sprites)))
}

// Removes all sprites from the display list.
remove_all_sprites :: #force_inline proc "contextless" () {
    vtable.remove_all_sprites()
}

// Returns the total number of sprites in the display list.
get_sprite_count :: #force_inline proc "contextless" () -> i32 {
    return vtable.get_sprite_count()
}

// Sets the bounds of the given `sprite` with `bounds`.
set_bounds :: #force_inline proc "contextless" (sprite: Sprite, bounds: Rect) {
    vtable.set_bounds(sprite, bounds)
}

// Returns the bounds of the given `sprite` as a Rect
get_bounds :: #force_inline proc "contextless" (sprite: Sprite) -> Rect {
    return vtable.get_bounds(sprite)
}

// Moves the given `sprite` to x, y and resets its bounds based on the bitmap dimensions and center.
move_to :: #force_inline proc "contextless" (sprite: Sprite, x, y: f32) {
    vtable.move_to(sprite, x, y)
}

// Moves the given `sprite` to by offsetting its current position by `d_x, d_y`.
move_by :: #force_inline proc "contextless" (sprite: Sprite, d_x, d_y: f32) {
    vtable.move_by(sprite, d_x, d_y)
}

// Sets the given `sprite`'s image to the given `bitmap`.
set_image :: #force_inline proc "contextless" (sprite: Sprite, bitmap: Bitmap, flip: Bitmap_Flip = .unflipped) {
    vtable.set_image(sprite, bitmap, flip)
}

// Returns the Bitmap currently assigned to the given `sprite`.
get_image :: #force_inline proc "contextless" (sprite: Sprite) -> Bitmap {
    return vtable.get_image(sprite)
}

// Sets the size. The size is used to set the `sprite`’s bounds when calling `moveTo()`.
set_size :: #force_inline proc "contextless" (sprite: Sprite, width, height: f32) {
    vtable.set_size(sprite, width, height)
}

// Sets the Z order of the given `sprite`. Higher Z sprites are drawn on top of those with lower Z order.
set_z_index :: #force_inline proc "contextless" (sprite: Sprite, z_index: i16) {
    vtable.set_z_index(sprite, z_index)
}

// Returns the Z index of the given `sprite`.
get_z_index :: #force_inline proc "contextless" (sprite: Sprite) -> i16{
    return vtable.get_z_index(sprite)
}

// Sets the mode for drawing the `sprite`’s bitmap.
set_draw_mode :: #force_inline proc "contextless" (sprite: Sprite, draw_mode: Bitmap_Draw_Mode) {
    vtable.set_draw_mode(sprite, draw_mode)
}

// Flips the bitmap.
set_image_flip :: #force_inline proc "contextless" (sprite: Sprite, flip: Bitmap_Flip) {
    vtable.set_image_flip(sprite, flip)
}

// Returns the flip setting of the `sprite`'s bitmap
get_image_flip :: #force_inline proc "contextless" (sprite: Sprite) -> Bitmap_Flip {
    return vtable.get_image_flip(sprite)
}

// Specifies a stencil image to be set on the frame buffer before the `sprite` is drawn.
set_stencil :: #force_inline proc "contextless" (sprite: Sprite, stencil: Bitmap) {
    vtable.set_stencil(sprite, stencil)
}

// Sets the clipping rectangle for sprite drawing.
set_clip_rect :: #force_inline proc "contextless" (sprite: Sprite, rect: Rect) {
    vtable.set_clip_rect(sprite, rect)
}

// Clears the sprite's clipping rectangle.
clear_clip_rect :: #force_inline proc "contextless" (sprite: Sprite) {
    vtable.clear_clip_rect(sprite)
}

// Sets the clipping rectangle for all sprites with a Z index within `start_z` and `end_z` inclusive.
set_clip_rects_in_range :: #force_inline proc "contextless" (rect: Rect, start_z, end_z: i32) {
    vtable.set_clip_rects_in_range(rect, start_z, end_z)
}

// Clears the clipping rectangle for all sprites with a Z index within `start_z` and `end_z` inclusive.
clear_clip_rects_in_range :: #force_inline proc "contextless" (start_z, end_z: i32) {
    vtable.clear_clip_rects_in_range(start_z, end_z)
}

// Set the updates_enabled flag of the given `sprite` (determines whether the sprite has its update function called).
set_updates_enabled :: #force_inline proc "contextless" (sprite: Sprite, enabled: bool) {
    vtable.set_updates_enabled(sprite, i32(enabled))
}

// Get the updates_enabled flag of the given `sprite`.
updates_enabled :: #force_inline proc "contextless" (sprite: Sprite) -> bool {
    return bool(vtable.updates_enabled(sprite))
}

// Set the collisions_enabled flag of the given `sprite` (along with the collide_rect, this determines whether the sprite participates in collisions). 
//
// Enabled by default.
set_collisions_enabled :: #force_inline proc "contextless" (sprite: Sprite, enabled: bool) {
    vtable.set_collisions_enabled(sprite, i32(enabled))
}

// Get the collisions_enabled flag of the given `sprite`.
collisions_enabled :: #force_inline proc "contextless" (sprite: Sprite) -> bool {
    return bool(vtable.collisions_enabled(sprite))
}

// Set the visible flag of the given `sprite` (determines whether the sprite has its draw function called).
set_visible :: #force_inline proc "contextless" (sprite: Sprite, visible: bool) {
    vtable.set_visible(sprite, i32(visible))
}

// Get the visible flag of the given `sprite`.
is_visible :: #force_inline proc "contextless" (sprite: Sprite) -> bool {
    return bool(vtable.is_visible(sprite))
}

// Marking a sprite opaque tells the sprite system that it doesn’t need to draw anything underneath the sprite, since it will be overdrawn anyway. 
// If you set an image without a mask/alpha channel on the sprite, it automatically sets the opaque flag.
set_opaque :: #force_inline proc "contextless" (sprite: Sprite, opaque: bool) {
    vtable.set_opaque(sprite, i32(opaque))
}

// Forces the given `sprite` to redraw.
mark_dirty :: #force_inline proc "contextless" (sprite: Sprite) {
    vtable.mark_dirty(sprite)
}

// Sets the tag of the given `sprite`. This can be useful for identifying sprites or types of sprites when using the collision API.
set_tag :: #force_inline proc "contextless" (sprite: Sprite, tag: u8) {
    vtable.set_tag(sprite, tag)
}

// Returns the tag of the given `sprite`.
get_tag :: #force_inline proc "contextless" (sprite: Sprite) -> u8 {
    return vtable.get_tag(sprite)
}

// When flag is true, the `sprite` will draw in screen coordinates, ignoring the currently-set draw_offset.
// 
// This only affects drawing, and should not be used on sprites being used for collisions, which will still happen in world-space.
set_ignores_draw_offset :: #force_inline proc "contextless" (sprite: Sprite, ignores_offset: bool) {
    vtable.set_ignores_draw_offset(sprite, i32(ignores_offset))
}

// Sets the update procedure for the given `sprite`.
set_update_function :: #force_inline proc "contextless" (sprite: Sprite, update: Update_Proc) {
    vtable.set_update_function(sprite, update)
}

// Sets the draw procedure for the given `sprite`.
set_draw_function :: #force_inline proc "contextless" (sprite: Sprite, draw: Draw_Proc) {
    vtable.set_draw_function(sprite, draw)
}

// Gets the current position of `sprite`.
get_position :: #force_inline proc "contextless" (sprite: Sprite) -> (x, y: f32) {
    vtable.get_position(sprite, &x, &y)
    return
}


// collisions



// Frees and reallocates internal collision data, resetting everything to its default state.
reset_collision_world :: #force_inline proc "contextless" () {
    vtable.reset_collision_world()
}

// Marks the area of the given `sprite`, relative to its bounds, to be checked for collisions with other sprites' collide rects.
set_collide_rect :: #force_inline proc "contextless" (sprite: Sprite, collide_rect: Rect) {
    vtable.set_collide_rect(sprite, collide_rect)
}

// Returns the given `sprite`'s collide rect.
get_collide_rect :: #force_inline proc "contextless" (sprite: Sprite) -> Rect {
    return vtable.get_collide_rect(sprite)
}

// Clears the given `sprite`'s collide rect.
clear_collide_rect :: #force_inline proc "contextless" (sprite: Sprite)  {
    vtable.clear_collide_rect(sprite)
}


// Set a callback that returns a Collision_Response_Type for a collision between `sprite` and `other`.
set_collision_response_function :: #force_inline proc "contextless" (sprite: Sprite, filter_proc: Collision_Filter_Proc) {

}

// Returns the same values as `move_with_collisions()` but does not actually move the sprite.
// 
// Allocates: caller is responsible for freeing the returned `collisions` slice.
check_collisions :: #force_inline proc "contextless" (sprite: Sprite, goal_x, goal_y: f32) -> (actual_x, actual_y: f32, collisions: []Collision_Info) {
    length: i32
    data := vtable.check_collisions(sprite, goal_x, goal_y, &actual_x, &actual_y, &length)
    collisions = data[:length]
    return
}

// Moves the given `sprite` towards `goal_x, goal_y` taking collisions into account. 
// 
// Returns 
// 
// - `actual_x, actual_y`: the sprite's position after collisions. If no collisions occurred, this wil be the same as `goal_x, goal_y`.
// - `collisions`: a slice of Collision_Info.
// 
// Allocates: caller is responsible for freeing the returned `collisions` slice.
move_with_collisions :: #force_inline proc "contextless" (sprite: Sprite, goal_x, goal_y: f32) -> (actual_x, actual_y: f32, collisions: []Collision_Info) {
    length: i32
    data := vtable.move_with_collisions(sprite, goal_x, goal_y, &actual_x, &actual_y, &length)
    collisions = data[:length]
    return
}

// Returns a slice of all sprites with collision rects containing the point at `x, y`. 
// 
// Allocates: caller is responsible for freeing the returned slice.
query_sprites_at_point :: #force_inline proc "contextless" (x, y: f32) -> []Sprite {
    length: i32
    data := vtable.query_sprites_at_point(x, y, &length)
    return data[:length]
}

// Returns a slice of all sprites with collision rects that intersect the `width` by `height` rect at `x, y`.
//
// Allocates: caller is responsible for freeing the returned slice.
query_sprites_in_rect :: #force_inline proc "contextless" (x, y, width, height: f32) -> []Sprite {
    length: i32
    data := vtable.query_sprites_in_rect(x, y, width, height, &length)
    return data[:length]
}


// Returns a slice of all sprites with collision rects that intersect the line connecting `x_1, y_1` and `x_2, y_2`.
//
// Allocates: caller is responsible for freeing the returned slice.
query_sprites_along_line :: #force_inline proc "contextless" (x_1, y_1, x_2, y_2: f32) -> []Sprite {
    length: i32
    data := vtable.query_sprites_along_line(x_1, y_1, x_2, y_2, &length)
    return data[:length]
}

// Returns a slice of Query_Info for all sprites with collision rects that intersect the line connecting `x_1, y_1` and `x_2, y_2`.
// If you don't need this information, use `query_sprites_along_line()` as it will be faster.
//
// Allocates: caller is responsible for freeing the returned slice.
query_sprite_info_along_line :: #force_inline proc "contextless" (x_1, y_1, x_2, y_2: f32) -> []Query_Info {
    length: i32
    data := vtable.query_sprite_info_along_line(x_1, y_1, x_2, y_2, &length)
    return data[:length]
}

// Returns a slice of sprites that have collide rects that are currently overlapping the given `sprite`’s collide rect. 
//
// Allocates: caller is responsible for freeing the returned slice.
overlapping_sprites :: #force_inline proc "contextless" (sprite: Sprite) -> []Sprite {
    length: i32
    data := vtable.overlapping_sprites(sprite, &length)
    return data[:length]
}

// Returns a slice of all sprites that have collide rects that are currently overlapping. 
// Each consecutive pair of sprites is overlapping (eg. 0 & 1 overlap, 2 & 3 overlap, etc).
//
// Allocates: caller is responsible for freeing the returned slice.
all_overlapping_sprites :: #force_inline proc "contextless" () -> []Sprite {
    length: i32
    data := vtable.all_overlapping_sprites(&length)
    return data[:length]
}



// Set the `sprite`'s stencil to the given `pattern`.
// 
// Since 1.7
set_stencil_pattern :: #force_inline proc "contextless" (sprite: Sprite, pattern: [8]u8) {
    vtable.set_stencil_pattern(sprite, pattern)
}

// Clears the `sprite`'s stencil.
// 
// Since 1.7
clear_stencil :: #force_inline proc "contextless" (sprite: Sprite) {
    vtable.clear_stencil(sprite)
}

// Sets the `sprite`'s `user_data`, an arbitrary pointer used for associating the sprite with other data.
//
// Since 1.7
set_user_data :: #force_inline proc "contextless" (sprite: Sprite, user_data: rawptr) {
    vtable.set_user_data(sprite, user_data)
}

// Gets the `sprite`'s `user_data`, an arbitrary pointer used for associating the sprite with other data.
// 
// Since 1.7
get_user_data :: #force_inline proc "contextless" (sprite: Sprite) -> rawptr {
    return vtable.get_user_data(sprite)
}

// Specifies a `stencil` image to be set on the frame buffer before the `sprite` is drawn. If `tile` is true, the stencil will be tiled. 
// 
// Tiled stencils must have width evenly divisible by 32.
//
// Since 1.10
set_stencil_image :: #force_inline proc "contextless" (sprite: Sprite, stencil: Bitmap, tile: bool) {
    vtable.set_stencil_image(sprite, stencil, i32(tile))
}