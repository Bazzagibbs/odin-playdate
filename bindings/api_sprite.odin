package playdate_bindings

import "core:c"

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

Api_Sprite_Procs :: struct {
    set_always_redraw                  : proc "c" (flag: b32),
    add_dirty_rect                     : proc "c" (dirty_rect: Rect),
    draw_sprites                       : proc "c" (),
    update_and_draw_sprites            : proc "c" (),

    new_sprite                         : proc "c" () -> Sprite,
    free_sprite                        : proc "c" (sprite: Sprite),
    copy                               : proc "c" (sprite: Sprite) -> Sprite,

    add_sprite                         : proc "c" (sprite: Sprite),
    remove_sprite                      : proc "c" (sprite: Sprite),
    remove_sprites                     : proc "c" (sprites: [^]Sprite, count: c.int),
    remove_all_sprites                 : proc "c" (),
    get_sprite_count                   : proc "c" () -> c.int,

    set_bounds                         : proc "c" (sprite: Sprite, bounds: Rect),
    get_bounds                         : proc "c" (sprite: Sprite) -> Rect,
    move_to                            : proc "c" (sprite: Sprite, x, y: f32),
    move_by                            : proc "c" (sprite: Sprite, d_x, d_y: f32),

    set_image                          : proc "c" (sprite: Sprite, image: Bitmap, flip: Bitmap_Flip),
    get_image                          : proc "c" (sprite: Sprite) -> Bitmap,
    set_size                           : proc "c" (sprite: Sprite, width, height: f32),
    set_z_index                        : proc "c" (sprite: Sprite, z_index: i16),
    get_z_index                        : proc "c" (sprite: Sprite) -> i16,

    set_draw_mode                      : proc "c" (sprite: Sprite, draw_mode: Bitmap_Draw_Mode),
    set_image_flip                     : proc "c" (sprite: Sprite, flip: Bitmap_Flip),
    get_image_flip                     : proc "c" (sprite: Sprite) -> Bitmap_Flip,
    set_stencil                        : proc "c" (sprite: Sprite, stencil: Bitmap),

    set_clip_rect                      : proc "c" (sprite: Sprite, clip_rect: Rect),
    clear_clip_rect                    : proc "c" (sprite: Sprite),
    set_clip_rects_in_range            : proc "c" (clip_rect: Rect, start_z, end_z: c.int),
    clear_clip_rects_in_range          : proc "c" (start_z, end_z: c.int),

    set_updates_enabled                : proc "c" (sprite: Sprite, flag: c.int),
    updates_enabled                    : proc "c" (sprite: Sprite) -> c.int,
    set_collisions_enabled             : proc "c" (sprite: Sprite, flag: c.int),
    collisions_enabled                 : proc "c" (sprite: Sprite) -> c.int,
    set_visible                        : proc "c" (sprite: Sprite, flag: c.int),
    is_visible                         : proc "c" (sprite: Sprite) -> c.int,
    set_opaque                         : proc "c" (sprite: Sprite, flag: c.int),
    mark_dirty                         : proc "c" (sprite: Sprite),

    set_tag                            : proc "c" (sprite: Sprite, tag: u8),
    get_tag                            : proc "c" (sprite: Sprite) -> u8,

    set_ignores_draw_offset            : proc "c" (sprite: Sprite, flag: c.int),

    set_update_function                : proc "c" (sprite: Sprite, update: Sprite_Update_Proc),
    set_draw_function                  : proc "c" (sprite: Sprite, draw: Sprite_Draw_Proc),

    get_position                       : proc "c" (sprite: Sprite, out_x, out_y: ^f32),

    // collisions
    reset_collision_world              : proc "c" (),

    set_collide_rect                   : proc "c" (sprite: Sprite, collide_rect: Rect),
    get_collide_rect                   : proc "c" (sprite: Sprite) -> Rect,
    clear_collide_rect                 : proc "c" (sprite: Sprite),

    // caller is responsible for freeing the returned array for all collision methods
    set_collision_response_function    : proc "c" (sprite: Sprite, filter: Sprite_Collision_Filter_Proc),
    check_collisions                   : proc "c" (sprite: Sprite, goal_x, goal_y: f32, acutal_x, actual_y: ^f32, length: ^c.int) -> [^]Sprite_Collision_Info,
    move_with_collisions               : proc "c" (sprite: Sprite, goal_x, goal_y: f32, acutal_x, actual_y: ^f32, length: ^c.int) -> [^]Sprite_Collision_Info,
    query_sprites_at_point             : proc "c" (x, y: f32, length: ^c.int) -> [^]Sprite,
    query_sprites_in_rect              : proc "c" (x, y, width, height: f32, length: ^c.int) -> [^]Sprite,
    query_sprites_along_line           : proc "c" (x_1, y_1, x_2, y_2: f32, length: ^c.int) -> [^]Sprite,
    query_sprite_info_along_line       : proc "c" (x_1, y_1, x_2, y_2: f32, length: ^c.int) -> [^]Sprite_Query_Info,
    overlapping_sprites                : proc "c" (sprite: Sprite, length: ^c.int) -> [^]Sprite,
    all_overlapping_sprites            : proc "c" (length: ^c.int) -> [^]Sprite,

    // added in 1.7
    set_stencil_pattern                : proc "c" (sprite: Sprite, pattern: [8]u8),
    clear_stencil                      : proc "c" (sprite: Sprite),

    set_user_data                      : proc "c" (sprite: Sprite, userdata: rawptr),
    get_user_data                      : proc "c" (sprite: Sprite) -> rawptr,

    // added in 1.10
    set_stencil_image                  : proc "c" (sprite: Sprite, stencil: Bitmap, tile: c.int),

    // 2.1
    set_center                         : proc "c" (sprite: Sprite, x, y: f32),
    get_center                         : proc "c" (sprite: Sprite, x, y: ^f32),
}
// =================================================================

