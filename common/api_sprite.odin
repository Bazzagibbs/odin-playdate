package playdate_common

import "core:c"

//   ///////////
//  // TYPES //
// ///////////

Sprite_Collision_Point :: [2]f32
Sprite_Collision_Vector :: [2]i32

Sprite_Collision_Response_Type :: enum {
    slide,
    freeze,
    overlap,
    bounce,
}

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
Sprite_Collision_Info :: struct {
    sprite          : Sprite,
    other           : Sprite,
    response_type   : Sprite_Collision_Response_Type,
    overlaps        : b8,
    ti              : f32,
    move            : Sprite_Collision_Point,
    normal          : Sprite_Collision_Vector,
    touch           : Sprite_Collision_Point,
    sprite_rect     : Rect,
    other_rect      : Rect,
}

// - `sprite`: The sprite being intersected by the segment.
// - `ti_1`, `ti_2`: Numbers between 0 and 1 which indicate how far from the starting point of the line segment the collision happened. `ti_1`: entry point, `ti_2`: exit point.
// - `entry_point`: The coordinates of the first intersection between sprite and the line segment.
// - `exit_point`: The coordinates of the second intersection between sprite and the line segment.
Sprite_Query_Info :: struct {
    sprite: Sprite,
    ti_1: f32,
    ti_2: f32,
    entry_point: Sprite_Collision_Point,
    exit_point: Sprite_Collision_Point,
}

Sprite_Update_Proc             :: #type proc "c" (sprite: Sprite)
Sprite_Draw_Proc               :: #type proc "c" (sprite: Sprite, bounds, draw_rect: Rect)
Sprite_Collision_Filter_Proc   :: #type proc "c" (sprite, other: Sprite) -> Sprite_Collision_Response_Type
// =================================================================


//   ////////////////
//  // PROC TYPES //
// ////////////////

Proc_Sprite_Set_Always_Redraw                  :: #type proc "c" (flag: b32)
Proc_Sprite_Add_Dirty_Rect                     :: #type proc "c" (dirty_rect: Rect)
Proc_Sprite_Draw_Sprites                       :: #type proc "c" ()
Proc_Sprite_Update_And_Draw_Sprites            :: #type proc "c" ()

Proc_Sprite_New_Sprite                         :: #type proc "c" () -> Sprite
Proc_Sprite_Free_Sprite                        :: #type proc "c" (sprite: Sprite)
Proc_Sprite_Copy                               :: #type proc "c" (sprite: Sprite) -> Sprite

Proc_Sprite_Add_Sprite                         :: #type proc "c" (sprite: Sprite)
Proc_Sprite_Remove_Sprite                      :: #type proc "c" (sprite: Sprite)
Proc_Sprite_Remove_Sprites                     :: #type proc "c" (sprites: [^]Sprite, count: c.int)
Proc_Sprite_Remove_All_Sprites                 :: #type proc "c" ()
Proc_Sprite_Get_Sprite_Count                   :: #type proc "c" () -> c.int

Proc_Sprite_Set_Bounds                         :: #type proc "c" (sprite: Sprite, bounds: Rect)
Proc_Sprite_Get_Bounds                         :: #type proc "c" (sprite: Sprite) -> Rect
Proc_Sprite_Move_To                            :: #type proc "c" (sprite: Sprite, x, y: f32)
Proc_Sprite_Move_By                            :: #type proc "c" (sprite: Sprite, d_x, d_y: f32)

Proc_Sprite_Set_Image                          :: #type proc "c" (sprite: Sprite, image: Bitmap, flip: Bitmap_Flip)
Proc_Sprite_Get_Image                          :: #type proc "c" (sprite: Sprite) -> Bitmap
Proc_Sprite_Set_Size                           :: #type proc "c" (sprite: Sprite, width, height: f32)
Proc_Sprite_Set_Z_Index                        :: #type proc "c" (sprite: Sprite, z_index: i16)
Proc_Sprite_Get_Z_Index                        :: #type proc "c" (sprite: Sprite) -> i16

Proc_Sprite_Set_Draw_Mode                      :: #type proc "c" (sprite: Sprite, draw_mode: Bitmap_Draw_Mode)
Proc_Sprite_Set_Image_Flip                     :: #type proc "c" (sprite: Sprite, flip: Bitmap_Flip)
Proc_Sprite_Get_Image_Flip                     :: #type proc "c" (sprite: Sprite) -> Bitmap_Flip
Proc_Sprite_Set_Stencil                        :: #type proc "c" (sprite: Sprite, stencil: Bitmap)

Proc_Sprite_Set_Clip_Rect                      :: #type proc "c" (sprite: Sprite, clip_rect: Rect)
Proc_Sprite_Clear_Clip_Rect                    :: #type proc "c" (sprite: Sprite)
Proc_Sprite_Set_Clip_Rects_In_Range            :: #type proc "c" (clip_rect: Rect, start_z, end_z: c.int)
Proc_Sprite_Clear_Clip_Rects_In_Range          :: #type proc "c" (start_z, end_z: c.int)

Proc_Sprite_Set_Updates_Enabled                :: #type proc "c" (sprite: Sprite, flag: c.int)
Proc_Sprite_Updates_Enabled                    :: #type proc "c" (sprite: Sprite) -> c.int
Proc_Sprite_Set_Collisions_Enabled             :: #type proc "c" (sprite: Sprite, flag: c.int)
Proc_Sprite_Collisions_Enabled                 :: #type proc "c" (sprite: Sprite) -> c.int
Proc_Sprite_Set_Visible                        :: #type proc "c" (sprite: Sprite, flag: c.int)
Proc_Sprite_Is_Visible                         :: #type proc "c" (sprite: Sprite) -> c.int
Proc_Sprite_Set_Opaque                         :: #type proc "c" (sprite: Sprite, flag: c.int) 
Proc_Sprite_Mark_Dirty                         :: #type proc "c" (sprite: Sprite)

Proc_Sprite_Set_Tag                            :: #type proc "c" (sprite: Sprite, tag: u8)
Proc_Sprite_Get_Tag                            :: #type proc "c" (sprite: Sprite) -> u8

Proc_Sprite_Set_Ignores_Draw_Offset            :: #type proc "c" (sprite: Sprite, flag: c.int)

Proc_Sprite_Set_Update_Function                :: #type proc "c" (sprite: Sprite, update: Sprite_Update_Proc)
Proc_Sprite_Set_Draw_Function                  :: #type proc "c" (sprite: Sprite, draw: Sprite_Draw_Proc)

Proc_Sprite_Get_Position                       :: #type proc "c" (sprite: Sprite, out_x, out_y: ^f32) 

// collisions
Proc_Sprite_Reset_Collision_World              :: #type proc "c" ()

Proc_Sprite_Set_Collide_Rect                   :: #type proc "c" (sprite: Sprite, collide_rect: Rect)
Proc_Sprite_Get_Collide_Rect                   :: #type proc "c" (sprite: Sprite) -> Rect
Proc_Sprite_Clear_Collide_Rect                 :: #type proc "c" (sprite: Sprite)

// caller is responsible for freeing the returned array for all collision methods
Proc_Sprite_Set_Collision_Response_Function    :: #type proc "c" (sprite: Sprite, filter: Sprite_Collision_Filter_Proc)
Proc_Sprite_Check_Collisions                   :: #type proc "c" (sprite: Sprite, goal_x, goal_y: f32, acutal_x, actual_y: ^f32, length: ^c.int) -> [^]Sprite_Collision_Info
Proc_Sprite_Move_With_Collisions               :: #type proc "c" (sprite: Sprite, goal_x, goal_y: f32, acutal_x, actual_y: ^f32, length: ^c.int) -> [^]Sprite_Collision_Info
Proc_Sprite_Query_Sprites_At_Point             :: #type proc "c" (x, y: f32, length: ^c.int) -> [^]Sprite
Proc_Sprite_Query_Sprites_In_Rect              :: #type proc "c" (x, y, width, height: f32, length: ^c.int) -> [^]Sprite
Proc_Sprite_Query_Sprites_Along_Line           :: #type proc "c" (x_1, y_1, x_2, y_2: f32, length: ^c.int) -> [^]Sprite
Proc_Sprite_Query_Sprite_Info_Along_Line       :: #type proc "c" (x_1, y_1, x_2, y_2: f32, length: ^c.int) -> [^]Sprite_Query_Info
Proc_Sprite_Overlapping_Sprites                :: #type proc "c" (sprite: Sprite, length: ^c.int) -> [^]Sprite
Proc_Sprite_All_Overlapping_Sprites            :: #type proc "c" (length: ^c.int) -> [^]Sprite

// added in 1.7
Proc_Sprite_Set_Stencil_Pattern                :: #type proc "c" (sprite: Sprite, pattern: [8]u8)
Proc_Sprite_Clear_Stencil                      :: #type proc "c" (sprite: Sprite)

Proc_Sprite_Set_User_Data                      :: #type proc "c" (sprite: Sprite, userdata: rawptr)
Proc_Sprite_Get_User_Data                      :: #type proc "c" (sprite: Sprite) -> rawptr

// added in 1.10
Proc_Sprite_Set_Stencil_Image                  :: #type proc "c" (sprite: Sprite, stencil: Bitmap, tile: c.int)

// =================================================================


//   ////////////////
//  // API STRUCT //
// ////////////////

Api_Sprite_Procs :: struct {
    set_always_redraw               : Proc_Sprite_Set_Always_Redraw, 
    add_dirty_rect                  : Proc_Sprite_Add_Dirty_Rect,
    draw_sprites                    : Proc_Sprite_Draw_Sprites,
    update_and_draw_sprites         : Proc_Sprite_Update_And_Draw_Sprites,

    new_sprite                      : Proc_Sprite_New_Sprite,
    free_sprite                     : Proc_Sprite_Free_Sprite,
    copy                            : Proc_Sprite_Copy,

    add_sprite                      : Proc_Sprite_Add_Sprite,
    remove_sprite                   : Proc_Sprite_Remove_Sprite,
    remove_sprites                  : Proc_Sprite_Remove_Sprites,
    remove_all_sprites              : Proc_Sprite_Remove_All_Sprites,
    get_sprite_count                : Proc_Sprite_Get_Sprite_Count,

    set_bounds                      : Proc_Sprite_Set_Bounds,
    get_bounds                      : Proc_Sprite_Get_Bounds,
    move_to                         : Proc_Sprite_Move_To,
    move_by                         : Proc_Sprite_Move_By,

    set_image                       : Proc_Sprite_Set_Image,
    get_image                       : Proc_Sprite_Get_Image,
    set_size                        : Proc_Sprite_Set_Size,
    set_z_index                     : Proc_Sprite_Set_Z_Index,
    get_z_index                     : Proc_Sprite_Get_Z_Index,

    set_draw_mode                   : Proc_Sprite_Set_Draw_Mode,
    set_image_flip                  : Proc_Sprite_Set_Image_Flip,
    get_image_flip                  : Proc_Sprite_Get_Image_Flip,
    set_stencil                     : Proc_Sprite_Set_Stencil,

    set_clip_rect                   : Proc_Sprite_Set_Clip_Rect,
    clear_clip_rect                 : Proc_Sprite_Clear_Clip_Rect,
    set_clip_rects_in_range         : Proc_Sprite_Set_Clip_Rects_In_Range,
    clear_clip_rects_in_range       : Proc_Sprite_Clear_Clip_Rects_In_Range,

    set_updates_enabled             : Proc_Sprite_Set_Updates_Enabled,
    updates_enabled                 : Proc_Sprite_Updates_Enabled,
    set_collisions_enabled          : Proc_Sprite_Set_Collisions_Enabled,
    collisions_enabled              : Proc_Sprite_Collisions_Enabled,
    set_visible                     : Proc_Sprite_Set_Visible,
    is_visible                      : Proc_Sprite_Is_Visible,
    set_opaque                      : Proc_Sprite_Set_Opaque,
    mark_dirty                      : Proc_Sprite_Mark_Dirty,

    set_tag                         : Proc_Sprite_Set_Tag,
    get_tag                         : Proc_Sprite_Get_Tag,

    set_ignores_draw_offset         : Proc_Sprite_Set_Ignores_Draw_Offset,

    set_update_function             : Proc_Sprite_Set_Update_Function,
    set_draw_function               : Proc_Sprite_Set_Draw_Function,

    get_position                    : Proc_Sprite_Get_Position,

    // collisions
    reset_collision_world           : Proc_Sprite_Reset_Collision_World,

    set_collide_rect                : Proc_Sprite_Set_Collide_Rect,
    get_collide_rect                : Proc_Sprite_Get_Collide_Rect,
    clear_collide_rect              : Proc_Sprite_Clear_Collide_Rect,

    // caller is responsible for freeing the returned array for all collision methods
    set_collision_response_function : Proc_Sprite_Set_Collision_Response_Function,
    check_collisions                : Proc_Sprite_Check_Collisions,
    move_with_collisions            : Proc_Sprite_Move_With_Collisions,
    query_sprites_at_point          : Proc_Sprite_Query_Sprites_At_Point,
    query_sprites_in_rect           : Proc_Sprite_Query_Sprites_In_Rect,
    query_sprites_along_line        : Proc_Sprite_Query_Sprites_Along_Line,
    query_sprite_info_along_line    : Proc_Sprite_Query_Sprite_Info_Along_Line,
    overlapping_sprites             : Proc_Sprite_Overlapping_Sprites,
    all_overlapping_sprites         : Proc_Sprite_All_Overlapping_Sprites,

    // // added in 1.7
    set_stencil_pattern             : Proc_Sprite_Set_Stencil_Pattern,
    clear_stencil                   : Proc_Sprite_Clear_Stencil,

    set_user_data                   : Proc_Sprite_Set_User_Data,
    get_user_data                   : Proc_Sprite_Get_User_Data,

    // // added in 1.10
    set_stencil_image               : Proc_Sprite_Set_Stencil_Image,
}
