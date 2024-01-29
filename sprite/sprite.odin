package playdate_sprite

import "core:c"
import "../common"
import ".."


Rect                    :: common.Rect
Sprite                  :: common.Sprite
Bitmap                  :: common.Bitmap
Bitmap_Flip             :: common.Bitmap_Flip
Bitmap_Draw_Mode        :: common.Bitmap_Draw_Mode


Collision_Point         :: common.Sprite_Collision_Point
Collision_Vector        :: common.Sprite_Collision_Vector

Collision_Response_type :: common.Sprite_Collision_Response_Type

// - `sprite`: The sprite being moved.
// - `other`: The sprite colliding with the sprite being moved.
// - `response_type`: The result of collisionResponse.
// - `overlaps`: True if the sprite was overlapping other when the collision started. False if it didn’t overlap but tunneled through other.
// - `ti`: A number between 0 and 1 indicating how far along the movement to the goal the collision occurred.
// - `move`: The difference between the original coordinates and the actual ones when the collision happened.
// - `normal`: The collision normal; usually -1, 0, or 1 in x and y. Use this value to determine things like if your character is touching the ground.
// - `touch`: The coordinates where the sprite started touching other.
// - `sprite_rect`: The rectangle the sprite occupied when the touch happened.
// - `other_rect`: The rectangle the sprite being collided with occupied when the touch happened.
Collision_Info          :: common.Sprite_Collision_Info

// - `sprite`: The sprite being intersected by the segment.
// - `ti_1`, `ti_2`: Numbers between 0 and 1 which indicate how far from the starting point of the line segment the collision happened. `ti_1`: entry point, `ti_2`: exit point.
// - `entry_point`: The coordinates of the first intersection between sprite and the line segment.
// - `exit_point`: The coordinates of the second intersection between sprite and the line segment.
Query_Info              :: common.Sprite_Query_Info

Update_Proc             :: common.Sprite_Update_Proc
Draw_Proc               :: common.Sprite_Draw_Proc
Collision_Filter_Proc   :: common.Sprite_Collision_Filter_Proc

// =================================================================


// When `redraw` is set to true, the given sprite will always redraw.
set_always_redraw               : common.Proc_Sprite_Set_Always_Redraw

// Marks the given dirtyRect (in screen coordinates) as needing a redraw. 
// 
// Graphics drawing functions now call this automatically, adding their drawn areas to the sprite’s dirty list, 
// so there’s usually no need to call this manually.
add_dirty_rect                  : common.Proc_Sprite_Add_Dirty_Rect

// Draws every sprite in the display list.
draw_sprites                    : common.Proc_Sprite_Draw_Sprites

// Updates and draws every sprite in the display list.
update_and_draw_sprites         : common.Proc_Sprite_Update_And_Draw_Sprites

// Allocates and returns a new LCDSprite.
new_sprite                      : common.Proc_Sprite_New_Sprite

// Frees the given `sprite`
free_sprite                     : common.Proc_Sprite_Free_Sprite

// Allocates and returns a copy of the given `sprite`.
copy                            : common.Proc_Sprite_Copy

// Adds the given `sprite` to the display list, so that it is drawn in the current scene.
add_sprite                      : common.Proc_Sprite_Add_Sprite

// Removes the given `sprite` from the display list.
remove_sprite                   : common.Proc_Sprite_Remove_Sprite

// Removes the given slice of sprites from the display list.
remove_sprites                  : common.Proc_Sprite_Remove_Sprites

// Removes all sprites from the display list.
remove_all_sprites              : common.Proc_Sprite_Remove_All_Sprites

// Returns the total number of sprites in the display list.
get_sprite_count                : common.Proc_Sprite_Get_Sprite_Count

// Sets the bounds of the given `sprite` with `bounds`.
set_bounds                      : common.Proc_Sprite_Set_Bounds

// Returns the bounds of the given `sprite` as a Rect
get_bounds                      : common.Proc_Sprite_Get_Bounds

// Moves the given `sprite` to x, y and resets its bounds based on the bitmap dimensions and center.
move_to                         : common.Proc_Sprite_Move_To

// Moves the given `sprite` to by offsetting its current position by `d_x, d_y`.
move_by                         : common.Proc_Sprite_Move_By

// Sets the given `sprite`'s image to the given `bitmap`.
set_image                       : common.Proc_Sprite_Set_Image

// Returns the Bitmap currently assigned to the given `sprite`.
get_image                       : common.Proc_Sprite_Get_Image

// Sets the size. The size is used to set the `sprite`’s bounds when calling `moveTo()`.
set_size                        : common.Proc_Sprite_Set_Size

// Sets the Z order of the given `sprite`. Higher Z sprites are drawn on top of those with lower Z order.
set_z_index                     : common.Proc_Sprite_Set_Z_Index

// Returns the Z index of the given `sprite`.
get_z_index                     : common.Proc_Sprite_Get_Z_Index

// Sets the mode for drawing the `sprite`’s bitmap.
set_draw_mode                   : common.Proc_Sprite_Set_Draw_Mode

// Flips the bitmap.
set_image_flip                  : common.Proc_Sprite_Set_Image_Flip

// Returns the flip setting of the `sprite`'s bitmap
get_image_flip                  : common.Proc_Sprite_Get_Image_Flip

// Specifies a stencil image to be set on the frame buffer before the `sprite` is drawn.
set_stencil                     : common.Proc_Sprite_Set_Stencil

// Sets the clipping rectangle for sprite drawing.
set_clip_rect                   : common.Proc_Sprite_Set_Clip_Rect

// Clears the sprite's clipping rectangle.
clear_clip_rect                 : common.Proc_Sprite_Clear_Clip_Rect

// Sets the clipping rectangle for all sprites with a Z index within `start_z` and `end_z` inclusive.
set_clip_rects_in_range         : common.Proc_Sprite_Set_Clip_Rects_In_Range

// Clears the clipping rectangle for all sprites with a Z index within `start_z` and `end_z` inclusive.
clear_clip_rects_in_range       : common.Proc_Sprite_Clear_Clip_Rects_In_Range

// Set the updates_enabled flag of the given `sprite` (determines whether the sprite has its update function called).
set_updates_enabled             : common.Proc_Sprite_Set_Updates_Enabled

// Get the updates_enabled flag of the given `sprite`.
updates_enabled                 : common.Proc_Sprite_Updates_Enabled

// Set the collisions_enabled flag of the given `sprite` (along with the collide_rect, this determines whether the sprite participates in collisions). 
//
// Enabled by default.
set_collisions_enabled          : common.Proc_Sprite_Set_Collisions_Enabled

// Get the collisions_enabled flag of the given `sprite`.
collisions_enabled              : common.Proc_Sprite_Collisions_Enabled

// Set the visible flag of the given `sprite` (determines whether the sprite has its draw function called).
set_visible                     : common.Proc_Sprite_Set_Visible

// Get the visible flag of the given `sprite`.
is_visible                      : common.Proc_Sprite_Is_Visible

// Marking a sprite opaque tells the sprite system that it doesn’t need to draw anything underneath the sprite, since it will be overdrawn anyway. 
// If you set an image without a mask/alpha channel on the sprite, it automatically sets the opaque flag.
set_opaque                      : common.Proc_Sprite_Set_Opaque

// Forces the given `sprite` to redraw.
mark_dirty                      : common.Proc_Sprite_Mark_Dirty

// Sets the tag of the given `sprite`. This can be useful for identifying sprites or types of sprites when using the collision API.
set_tag                         : common.Proc_Sprite_Set_Tag

// Returns the tag of the given `sprite`.
get_tag                         : common.Proc_Sprite_Get_Tag

// When flag is true, the `sprite` will draw in screen coordinates, ignoring the currently-set draw_offset.
// 
// This only affects drawing, and should not be used on sprites being used for collisions, which will still happen in world-space.
set_ignores_draw_offset         : common.Proc_Sprite_Set_Ignores_Draw_Offset

// Sets the update procedure for the given `sprite`.
set_update_function             : common.Proc_Sprite_Set_Update_Function

// Sets the draw procedure for the given `sprite`.
set_draw_function               : common.Proc_Sprite_Set_Draw_Function

// Gets the current position of `sprite`.
get_position                    : common.Proc_Sprite_Get_Position


// Frees and reallocates internal collision data, resetting everything to its default state.
reset_collision_world           : common.Proc_Sprite_Reset_Collision_World

// Marks the area of the given `sprite`, relative to its bounds, to be checked for collisions with other sprites' collide rects.
set_collide_rect                : common.Proc_Sprite_Set_Collide_Rect

// Returns the given `sprite`'s collide rect.
get_collide_rect                : common.Proc_Sprite_Get_Collide_Rect

// Clears the given `sprite`'s collide rect.
clear_collide_rect              : common.Proc_Sprite_Clear_Collide_Rect


// Set a callback that returns a Collision_Response_Type for a collision between `sprite` and `other`.
set_collision_response_function : common.Proc_Sprite_Set_Collision_Response_Function

// Returns the same values as `move_with_collisions()` but does not actually move the sprite.
// 
// Allocates                    : caller is responsible for freeing the returned `collisions` slice.
check_collisions                : common.Proc_Sprite_Check_Collisions

// Moves the given `sprite` towards `goal_x, goal_y` taking collisions into account. 
// 
// Returns 
// 
// - `actual_x, actual_y`       : the sprite's position after collisions. If no collisions occurred, this wil be the same as `goal_x, goal_y`.
// - `collisions`               : a slice of Collision_Info.
// 
// Allocates                    : caller is responsible for freeing the returned `collisions` slice.
move_with_collisions            : common.Proc_Sprite_Move_With_Collisions

// Returns a slice of all sprites with collision rects containing the point at `x, y`. 
// 
// Allocates                    : caller is responsible for freeing the returned slice.
query_sprites_at_point          : common.Proc_Sprite_Query_Sprites_At_Point

// Returns a slice of all sprites with collision rects that intersect the `width` by `height` rect at `x, y`.
//
// Allocates                    : caller is responsible for freeing the returned slice.
query_sprites_in_rect           : common.Proc_Sprite_Query_Sprites_In_Rect


// Returns a slice of all sprites with collision rects that intersect the line connecting `x_1, y_1` and `x_2, y_2`.
//
// Allocates                    : caller is responsible for freeing the returned slice.
query_sprites_along_line        : common.Proc_Sprite_Query_Sprites_Along_Line

// Returns a slice of Query_Info for all sprites with collision rects that intersect the line connecting `x_1, y_1` and `x_2, y_2`.
// If you don't need this information, use `query_sprites_along_line()` as it will be faster.
//
// Allocates                    : caller is responsible for freeing the returned slice.
query_sprite_info_along_line    : common.Proc_Sprite_Query_Sprite_Info_Along_Line

// Returns a slice of sprites that have collide rects that are currently overlapping the given `sprite`’s collide rect. 
//
// Allocates                    : caller is responsible for freeing the returned slice.
overlapping_sprites             : common.Proc_Sprite_Overlapping_Sprites

// Returns a slice of all sprites that have collide rects that are currently overlapping. 
// Each consecutive pair of sprites is overlapping (eg. 0 & 1 overlap, 2 & 3 overlap, etc).
//
// Allocates                    : caller is responsible for freeing the returned slice.
all_overlapping_sprites         : common.Proc_Sprite_All_Overlapping_Sprites

// Set the `sprite`'s stencil to the given `pattern`.
// 
// Since 1.7
set_stencil_pattern             : common.Proc_Sprite_Set_Stencil_Pattern

// Clears the `sprite`'s stencil.
// 
// Since 1.7
clear_stencil                   : common.Proc_Sprite_Clear_Stencil

// Sets the `sprite`'s `user_data`, an arbitrary pointer used for associating the sprite with other data.
//
// Since 1.7
set_user_data                   : common.Proc_Sprite_Set_User_Data

// Gets the `sprite`'s `user_data`, an arbitrary pointer used for associating the sprite with other data.
// 
// Since 1.7
get_user_data                   : common.Proc_Sprite_Get_User_Data

// Specifies a `stencil` image to be set on the frame buffer before the `sprite` is drawn. If `tile` is true, the stencil will be tiled. 
// 
// Tiled stencils must have width evenly divisible by 32.
//
// Since 1.10
set_stencil_image               : common.Proc_Sprite_Set_Stencil_Image

// =================================================================


//   /////////////////
//  // LOADER PROC //
// /////////////////

// Position in PlaydateAPI struct (see pd_api.h)
API_INDEX :: 3

@(init)
_register :: proc() {
    playdate._loaders[API_INDEX] = _load_procs
}

_load_procs :: proc "contextless" (api: ^playdate.Api) {
    set_always_redraw               = api.sprite.set_always_redraw
    add_dirty_rect                  = api.sprite.add_dirty_rect
    draw_sprites                    = api.sprite.draw_sprites
    update_and_draw_sprites         = api.sprite.update_and_draw_sprites

    new_sprite                      = api.sprite.new_sprite
    free_sprite                     = api.sprite.free_sprite
    copy                            = api.sprite.copy

    add_sprite                      = api.sprite.add_sprite
    remove_sprite                   = api.sprite.remove_sprite
    remove_sprites                  = api.sprite.remove_sprites
    remove_all_sprites              = api.sprite.remove_all_sprites
    get_sprite_count                = api.sprite.get_sprite_count

    set_bounds                      = api.sprite.set_bounds
    get_bounds                      = api.sprite.get_bounds
    move_to                         = api.sprite.move_to
    move_by                         = api.sprite.move_by

    set_image                       = api.sprite.set_image
    get_image                       = api.sprite.get_image
    set_size                        = api.sprite.set_size
    set_z_index                     = api.sprite.set_z_index
    get_z_index                     = api.sprite.get_z_index

    set_draw_mode                   = api.sprite.set_draw_mode
    set_image_flip                  = api.sprite.set_image_flip
    get_image_flip                  = api.sprite.get_image_flip
    set_stencil                     = api.sprite.set_stencil

    set_clip_rect                   = api.sprite.set_clip_rect
    clear_clip_rect                 = api.sprite.clear_clip_rect
    set_clip_rects_in_range         = api.sprite.set_clip_rects_in_range
    clear_clip_rects_in_range       = api.sprite.clear_clip_rects_in_range

    set_updates_enabled             = api.sprite.set_updates_enabled
    updates_enabled                 = api.sprite.updates_enabled
    set_collisions_enabled          = api.sprite.set_collisions_enabled
    collisions_enabled              = api.sprite.collisions_enabled
    set_visible                     = api.sprite.set_visible
    is_visible                      = api.sprite.is_visible
    set_opaque                      = api.sprite.set_opaque
    mark_dirty                      = api.sprite.mark_dirty

    set_tag                         = api.sprite.set_tag
    get_tag                         = api.sprite.get_tag

    set_ignores_draw_offset         = api.sprite.set_ignores_draw_offset

    set_update_function             = api.sprite.set_update_function
    set_draw_function               = api.sprite.set_draw_function

    get_position                    = api.sprite.get_position

    // collisions
    reset_collision_world           = api.sprite.reset_collision_world

    set_collide_rect                = api.sprite.set_collide_rect
    get_collide_rect                = api.sprite.get_collide_rect
    clear_collide_rect              = api.sprite.clear_collide_rect

    // caller is responsible for freeing the returned array for all collision methods
    set_collision_response_function = api.sprite.set_collision_response_function
    check_collisions                = api.sprite.check_collisions
    move_with_collisions            = api.sprite.move_with_collisions
    query_sprites_at_point          = api.sprite.query_sprites_at_point
    query_sprites_in_rect           = api.sprite.query_sprites_in_rect
    query_sprites_along_line        = api.sprite.query_sprites_along_line
    query_sprite_info_along_line    = api.sprite.query_sprite_info_along_line
    overlapping_sprites             = api.sprite.overlapping_sprites
    all_overlapping_sprites         = api.sprite.all_overlapping_sprites

    // // added in 1.7
    set_stencil_pattern             = api.sprite.set_stencil_pattern
    clear_stencil                   = api.sprite.clear_stencil

    set_user_data                   = api.sprite.set_user_data
    get_user_data                   = api.sprite.get_user_data

    // // added in 1.10
    set_stencil_image               = api.sprite.set_stencil_image

}


