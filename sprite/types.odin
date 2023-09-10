package playdate_sprite

import "../common"

Rect                :: common.Rect
Sprite              :: common.Sprite
Bitmap              :: common.Bitmap
Bitmap_Flip         :: common.Bitmap_Flip
Bitmap_Draw_Mode    :: common.Bitmap_Draw_Mode


Collision_Point :: [2]f32
Collision_Vector :: [2]i32

Collision_Response_type :: enum {
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
Collision_Info :: struct {
    sprite          : Sprite,
    other           : Sprite,
    response_type   : Collision_Response_type,
    overlaps        : b8,
    ti              : f32,
    move            : Collision_Point,
    normal          : Collision_Vector,
    touch           : Collision_Point,
    sprite_rect     : Rect,
    other_rect      : Rect,
}

// - `sprite`: The sprite being intersected by the segment.
// - `ti_1`, `ti_2`: Numbers between 0 and 1 which indicate how far from the starting point of the line segment the collision happened. `ti_1`: entry point, `ti_2`: exit point.
// - `entry_point`: The coordinates of the first intersection between sprite and the line segment.
// - `exit_point`: The coordinates of the second intersection between sprite and the line segment.
Query_Info :: struct {
    sprite: Sprite,
    ti_1: f32,
    ti_2: f32,
    entry_point: Collision_Point,
    exit_point: Collision_Point,
}

Update_Proc             :: #type proc "c" (sprite: Sprite)
Draw_Proc               :: #type proc "c" (sprite: Sprite, bounds, draw_rect: Rect)
Collision_Filter_Proc   :: #type proc "c" (sprite, other: Sprite) -> Collision_Response_type