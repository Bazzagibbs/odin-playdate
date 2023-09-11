package playdate_sprite

Proc_Set_Always_Redraw              :: #type proc "c" (flag: i32)
Proc_Add_Dirty_Rect                 :: #type proc "c" (dirty_rect: Rect)
Proc_Draw_Sprites                   :: #type proc "c" ()
Proc_Update_And_Draw_Sprites        :: #type proc "c" ()

Proc_New_Sprite                     :: #type proc "c" () -> Sprite
Proc_Free_Sprite                    :: #type proc "c" (sprite: Sprite)
Proc_Copy                           :: #type proc "c" (sprite: Sprite) -> Sprite

Proc_Add_Sprite                     :: #type proc "c" (sprite: Sprite)
Proc_Remove_Sprite                  :: #type proc "c" (sprite: Sprite)
Proc_Remove_Sprites                 :: #type proc "c" (sprites: [^]Sprite, count: i32)
Proc_Remove_All_Sprites             :: #type proc "c" ()
Proc_Get_Sprite_Count               :: #type proc "c" () -> i32

Proc_Set_Bounds                     :: #type proc "c" (sprite: Sprite, bounds: Rect)
Proc_Get_Bounds                     :: #type proc "c" (sprite: Sprite) -> Rect
Proc_Move_To                        :: #type proc "c" (sprite: Sprite, x, y: f32)
Proc_Move_By                        :: #type proc "c" (sprite: Sprite, d_x, d_y: f32)

Proc_Set_Image                      :: #type proc "c" (sprite: Sprite, image: Bitmap, flip: Bitmap_Flip)
Proc_Get_Image                      :: #type proc "c" (sprite: Sprite) -> Bitmap
Proc_Set_Size                       :: #type proc "c" (sprite: Sprite, width, height: f32)
Proc_Set_Z_Index                    :: #type proc "c" (sprite: Sprite, z_index: i16)
Proc_Get_Z_Index                    :: #type proc "c" (sprite: Sprite) -> i16

Proc_Set_Draw_Mode                  :: #type proc "c" (sprite: Sprite, draw_mode: Bitmap_Draw_Mode)
Proc_Set_Image_Flip                 :: #type proc "c" (sprite: Sprite, flip: Bitmap_Flip)
Proc_Get_Image_Flip                 :: #type proc "c" (sprite: Sprite) -> Bitmap_Flip
Proc_Set_Stencil                    :: #type proc "c" (sprite: Sprite, stencil: Bitmap)

Proc_Set_Clip_Rect                  :: #type proc "c" (sprite: Sprite, clip_rect: Rect)
Proc_Clear_Clip_Rect                :: #type proc "c" (sprite: Sprite)
Proc_Set_Clip_Rects_In_Range        :: #type proc "c" (clip_rect: Rect, start_z, end_z: i32)
Proc_Clear_Clip_Rects_In_Range      :: #type proc "c" (start_z, end_z: i32)

Proc_Set_Updates_Enabled            :: #type proc "c" (sprite: Sprite, flag: i32)
Proc_Updates_Enabled                :: #type proc "c" (sprite: Sprite) -> i32
Proc_Set_Collisions_Enabled         :: #type proc "c" (sprite: Sprite, flag: i32)
Proc_Collisions_Enabled             :: #type proc "c" (sprite: Sprite) -> i32
Proc_Set_Visible                    :: #type proc "c" (sprite: Sprite, flag: i32)
Proc_Is_Visible                     :: #type proc "c" (sprite: Sprite) -> i32
Proc_Set_Opaque                     :: #type proc "c" (sprite: Sprite, flag: i32) 
Proc_Mark_Dirty                     :: #type proc "c" (sprite: Sprite)

Proc_Set_Tag                        :: #type proc "c" (sprite: Sprite, tag: u8)
Proc_Get_Tag                        :: #type proc "c" (sprite: Sprite) -> u8

Proc_Set_Ignores_Draw_Offset        :: #type proc "c" (sprite: Sprite, flag: i32)

Proc_Set_Update_Function            :: #type proc "c" (sprite: Sprite, update: Update_Proc)
Proc_Set_Draw_Function              :: #type proc "c" (sprite: Sprite, draw: Draw_Proc)

Proc_Get_Position                   :: #type proc "c" (sprite: Sprite, out_x, out_y: ^f32) 

// collisions
Proc_Reset_Collision_World          :: #type proc "c" ()

Proc_Set_Collide_Rect               :: #type proc "c" (sprite: Sprite, collide_rect: Rect)
Proc_Get_Collide_Rect               :: #type proc "c" (sprite: Sprite) -> Rect
Proc_Clear_Collide_Rect             :: #type proc "c" (sprite: Sprite)

// caller is responsible for freeing the returned array for all collision methods
Proc_Set_Collision_Response_Function    :: #type proc "c" (sprite: Sprite, filter: Collision_Filter_Proc)
Proc_Check_Collisions                   :: #type proc "c" (sprite: Sprite, goal_x, goal_y: f32, acutal_x, actual_y: ^f32, length: ^i32) -> [^]Collision_Info
Proc_Move_With_Collisions               :: #type proc "c" (sprite: Sprite, goal_x, goal_y: f32, acutal_x, actual_y: ^f32, length: ^i32) -> [^]Collision_Info
Proc_Query_Sprites_At_Point             :: #type proc "c" (x, y: f32, length: ^i32) -> [^]Sprite
Proc_Query_Sprites_In_Rect              :: #type proc "c" (x, y, width, height: f32, length: ^i32) -> [^]Sprite
Proc_Query_Sprites_Along_Line           :: #type proc "c" (x_1, y_1, x_2, y_2: f32, length: ^i32) -> [^]Sprite
Proc_Query_Sprite_Info_Along_Line       :: #type proc "c" (x_1, y_1, x_2, y_2: f32, length: ^i32) -> [^]Query_Info
Proc_Overlapping_Sprites                :: #type proc "c" (sprite: Sprite, length: ^i32) -> [^]Sprite
Proc_All_Overlapping_Sprites            :: #type proc "c" (length: ^i32) -> [^]Sprite

// added in 1.7
Proc_Set_Stencil_Pattern            :: #type proc "c" (sprite: Sprite, pattern: [8]u8)
Proc_Clear_Stencil                  :: #type proc "c" (sprite: Sprite)

Proc_Set_User_Data                  :: #type proc "c" (sprite: Sprite, userdata: rawptr)
Proc_Get_User_Data                  :: #type proc "c" (sprite: Sprite) -> rawptr

// added in 1.10
Proc_Set_Stencil_Image              :: #type proc "c" (sprite: Sprite, stencil: Bitmap, tile: i32)


vtable: ^VTable


VTable :: struct {
    set_always_redraw           : Proc_Set_Always_Redraw, 
    add_dirty_rect              : Proc_Add_Dirty_Rect,
    draw_sprites                : Proc_Draw_Sprites,
    update_and_draw_sprites     : Proc_Update_And_Draw_Sprites,

    new_sprite                  : Proc_New_Sprite,
    free_sprite                 : Proc_Free_Sprite,
    copy                        : Proc_Copy,

    add_sprite                  : Proc_Add_Sprite,
    remove_sprite               : Proc_Remove_Sprite,
    remove_sprites              : Proc_Remove_Sprites,
    remove_all_sprites          : Proc_Remove_All_Sprites,
    get_sprite_count            : Proc_Get_Sprite_Count,

    set_bounds                  : Proc_Set_Bounds,
    get_bounds                  : Proc_Get_Bounds,
    move_to                     : Proc_Move_To,
    move_by                     : Proc_Move_By,

    set_image                   : Proc_Set_Image,
    get_image                   : Proc_Get_Image,
    set_size                    : Proc_Set_Size,
    set_z_index                 : Proc_Set_Z_Index,
    get_z_index                 : Proc_Get_Z_Index,

    set_draw_mode               : Proc_Set_Draw_Mode,
    set_image_flip              : Proc_Set_Image_Flip,
    get_image_flip              : Proc_Get_Image_Flip,
    set_stencil                 : Proc_Set_Stencil,

    set_clip_rect               : Proc_Set_Clip_Rect,
    clear_clip_rect             : Proc_Clear_Clip_Rect,
    set_clip_rects_in_range     : Proc_Set_Clip_Rects_In_Range,
    clear_clip_rects_in_range   : Proc_Clear_Clip_Rects_In_Range,

    set_updates_enabled         : Proc_Set_Updates_Enabled,
    updates_enabled             : Proc_Updates_Enabled,
    set_collisions_enabled      : Proc_Set_Collisions_Enabled,
    collisions_enabled          : Proc_Collisions_Enabled,
    set_visible                 : Proc_Set_Visible,
    is_visible                  : Proc_Is_Visible,
    set_opaque                  : Proc_Set_Opaque,
    mark_dirty                  : Proc_Mark_Dirty,

    set_tag                     : Proc_Set_Tag,
    get_tag                     : Proc_Get_Tag,

    set_ignores_draw_offset     : Proc_Set_Ignores_Draw_Offset,

    set_update_function         : Proc_Set_Update_Function,
    set_draw_function           : Proc_Set_Draw_Function,

    get_position                : Proc_Get_Position,

    // collisions
    reset_collision_world       : Proc_Reset_Collision_World,

    set_collide_rect            : Proc_Set_Collide_Rect,
    get_collide_rect            : Proc_Get_Collide_Rect,
    clear_collide_rect          : Proc_Clear_Collide_Rect,

    // caller is responsible for freeing the returned array for all collision methods
    set_collision_response_function : Proc_Set_Collision_Response_Function,
    check_collisions                : Proc_Check_Collisions,
    move_with_collisions            : Proc_Move_With_Collisions,
    query_sprites_at_point          : Proc_Query_Sprites_At_Point,
    query_sprites_in_rect           : Proc_Query_Sprites_In_Rect,
    query_sprites_along_line        : Proc_Query_Sprites_Along_Line,
    query_sprite_info_along_line    : Proc_Query_Sprite_Info_Along_Line,
    overlapping_sprites             : Proc_Overlapping_Sprites,
    all_overlapping_sprites         : Proc_All_Overlapping_Sprites,

    // // added in 1.7
    set_stencil_pattern         : Proc_Set_Stencil_Pattern,
    clear_stencil               : Proc_Clear_Stencil,

    set_user_data               : Proc_Set_User_Data,
    get_user_data               : Proc_Get_User_Data,

    // // added in 1.10
    set_stencil_image           : Proc_Set_Stencil_Image,
}