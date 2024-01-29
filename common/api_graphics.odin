package playdate_common

import "core:c"

//   ///////////
//  // TYPES //
// ///////////

Gfx_Bitmap_Table    :: distinct Handle
Gfx_Font            :: distinct Handle
Gfx_Font_Data       :: distinct Handle
Gfx_Font_Page       :: distinct Handle
Gfx_Font_Glyph      :: distinct Handle

Gfx_Bitmap_Data :: struct {
    width: i32,
    height: i32,
    row_bytes: i32,
    mask: []u8,
    data: []u8, 
}

Gfx_Solid_Color :: enum {
    black,
    white,
    clear,
    xor,
}

Gfx_Line_Cap_Style :: enum {
    butt,
    square,
    round,
}

Gfx_Font_Language :: enum {
    english,
    japanese,
    unknown,
}

Gfx_String_Encoding :: enum {
    ascii,
    utf8,
    _16_bit_le,
}

Gfx_Pattern :: distinct [16]byte

Gfx_Color :: struct #raw_union {
    Gfx_Solid_Color,
    ^Gfx_Pattern,
}

Gfx_Polygon_Fill_Rule :: enum {
    non_zero,
    even_odd,
}

// =================================================================

Video_Player    :: distinct Handle

Video_Player_Info :: struct {
    width           : i32, 
    height          : i32,
    frame_rate      : f32,
    frame_count     : i32, 
    current_frame   : i32,
}

// =================================================================


//   ////////////////
//  // PROC TYPES //
// ////////////////

Proc_Gfx_Clear                      :: #type proc "c" (color: Gfx_Color)
Proc_Gfx_Set_Background_Color       :: #type proc "c" (color: Gfx_Solid_Color) 
Proc_Gfx_Set_Stencil                :: #type proc "c" (stencil: Bitmap)
Proc_Gfx_Set_Draw_Mode              :: #type proc "c" (draw_mode: Bitmap_Draw_Mode)
Proc_Gfx_Set_Draw_Offset            :: #type proc "c" (dx, dy: c.int)
Proc_Gfx_Set_Clip_Rect              :: #type proc "c" (x, y, width, height: c.int)
Proc_Gfx_Clear_Clip_Rect            :: #type proc "c" ()
Proc_Gfx_Set_Line_Cap_Style         :: #type proc "c" (end_cap_style: Gfx_Line_Cap_Style)
Proc_Gfx_Set_Font                   :: #type proc "c" (font: Gfx_Font)
Proc_Gfx_Set_Text_Tracking          :: #type proc "c" (tracking: c.int)
Proc_Gfx_Push_Context               :: #type proc "c" (target: Bitmap)
Proc_Gfx_Pop_Context                :: #type proc "c" ()

Proc_Gfx_Draw_Bitmap                :: #type proc "c" (bitmap: Bitmap, x, y: c.int, flip: Bitmap_Flip)
Proc_Gfx_Tile_Bitmap                :: #type proc "c" (bitmap: Bitmap, x, y, width, height: c.int, flip: Bitmap_Flip)
Proc_Gfx_Draw_Line                  :: #type proc "c" (x1, y1, x2, y2, width: c.int, color: Gfx_Color)
Proc_Gfx_Fill_Triangle              :: #type proc "c" (x1, y1, x2, y2, x3, y3: c.int, color: Gfx_Color)
Proc_Gfx_Draw_Rect                  :: #type proc "c" (x, y, width, height: c.int, color: Gfx_Color)
Proc_Gfx_Fill_Rect                  :: #type proc "c" (x, y, width, height: c.int, color: Gfx_Color)
Proc_Gfx_Draw_Ellipse               :: #type proc "c" (x, y, width, height, line_width: c.int, start_angle, end_angle: f32, color: Gfx_Color)
Proc_Gfx_Fill_Ellipse               :: #type proc "c" (x, y, width, height: c.int, start_angle, end_angle: f32, color: Gfx_Color)
Proc_Gfx_Draw_Scaled_Bitmap         :: #type proc "c" (bitmap: Bitmap, x, y: c.int, x_scale, y_scale: f32)
Proc_Gfx_Draw_Text                  :: #type proc "c" (text: cstring, len: u32, encoding: Gfx_String_Encoding, x, y: c.int) -> i32
Proc_Gfx_New_Bitmap                 :: #type proc "c" (width, height: c.int, bg_color: Gfx_Color) -> Bitmap 
Proc_Gfx_Free_Bitmap                :: #type proc "c" (bitmap: Bitmap) 
Proc_Gfx_Load_Bitmap                :: #type proc "c" (path: cstring, out_err: ^cstring) -> Bitmap
Proc_Gfx_Copy_Bitmap                :: #type proc "c" (bitmap: Bitmap) -> Bitmap
Proc_Gfx_Load_Into_Bitmap           :: #type proc "c" (path: cstring, bitmap: Bitmap, out_err: ^cstring) 
Proc_Gfx_Get_Bitmap_Data            :: #type proc "c" (bitmap: Bitmap, out_width, out_height, out_row_bytes: ^c.int, out_mask, out_data: ^[^]u8)
Proc_Gfx_Clear_Bitmap               :: #type proc "c" (bitmap: Bitmap, bg_color: Gfx_Color)
Proc_Gfx_Rotated_Bitmap             :: #type proc "c" (bitmap: Bitmap, rotation, x_scale, y_scale: f32, out_alloced_size: ^c.int) -> Bitmap

Proc_Gfx_New_Bitmap_Table           :: #type proc "c" (count, width, height: c.int) -> Gfx_Bitmap_Table
Proc_Gfx_Free_Bitmap_Table          :: #type proc "c" (table: Gfx_Bitmap_Table) 
Proc_Gfx_Load_Bitmap_Table          :: #type proc "c" (path: cstring, out_err: ^cstring) -> Gfx_Bitmap_Table
Proc_Gfx_Load_Into_Bitmap_Table     :: #type proc "c" (path: cstring, table: Gfx_Bitmap_Table, out_err: ^cstring)
Proc_Gfx_Get_Table_Bitmap           :: #type proc "c" (table: Gfx_Bitmap_Table, idx: c.int) -> Bitmap

Proc_Gfx_Load_Font                  :: #type proc "c" (path: cstring, out_err: ^cstring) -> Gfx_Font
Proc_Gfx_Get_Font_Page              :: #type proc "c" (font: Gfx_Font, ch: u32) -> Gfx_Font_Page
Proc_Gfx_Get_Page_Glyph             :: #type proc "c" (page: Gfx_Font_Page, ch: u32, bitmap: ^Bitmap, advance: ^(c.int)) -> Gfx_Font_Glyph
Proc_Gfx_Get_Glyph_Kerning          :: #type proc "c" (glyph: Gfx_Font_Glyph, glyph_code, next_code: u32) -> c.int 
Proc_Gfx_Get_Text_Width             :: #type proc "c" (font: Gfx_Font, text: cstring, len: u32, encoding: Gfx_String_Encoding, tracking: c.int) -> i32

Proc_Gfx_Get_Frame                  :: #type proc "c" () -> [^]u8
Proc_Gfx_Get_Display_Frame          :: #type proc "c" () -> [^]u8
Proc_Gfx_Get_Debug_Bitmap           :: #type proc "c" () -> Bitmap 
Proc_Gfx_Copy_Frame_Buffer_Bitmap   :: #type proc "c" () -> Bitmap 
Proc_Gfx_Mark_Updated_Rows          :: #type proc "c" (start, end: c.int) 
Proc_Gfx_Display                    :: #type proc "c" ()

Proc_Gfx_Set_Color_To_Pattern       :: #type proc "c" (color: Gfx_Color, bitmap: Bitmap, x, y: c.int) 
Proc_Gfx_Check_Mask_Collision       :: #type proc "c" (bitmap_1: Bitmap, x_1, y_1: c.int, flip_1: Bitmap_Flip, bitmap_2: Bitmap, x_2, y_2: i32, flip_2: Bitmap_Flip, rect: Rect) -> i32
Proc_Gfx_Set_Screen_Clip_Rect       :: #type proc "c" (x, y, width, height: c.int)

Proc_Gfx_Fill_Polygon               :: #type proc "c" (n_points: c.int, coords: [^]i32, color: Gfx_Color, fill_rule: Gfx_Polygon_Fill_Rule) 
Proc_Gfx_Get_Font_Height            :: #type proc "c" (font: Gfx_Font) -> u8

Proc_Gfx_Get_Display_Buffer_Bitmap  :: #type proc "c" () -> Bitmap
Proc_Gfx_Draw_Rotated_Bitmap        :: #type proc "c" (bitmap: Bitmap, x, y: c.int, rotation, center_x, center_y, x_scale, y_scale: f32)
Proc_Gfx_Set_Text_Leading           :: #type proc "c" (line_height_adjustment: c.int) 

Proc_Gfx_Set_Bitmap_Mask            :: #type proc "c" (bitmap, mask: Bitmap) -> c.int

Proc_Gfx_Get_Bitmap_Mask            :: #type proc "c" (bitmap: Bitmap) -> Bitmap 

Proc_Gfx_Set_Stencil_Image          :: #type proc "c" (stencil: Bitmap, tile: c.int)

Proc_Gfx_Make_Font_From_Data        :: #type proc "c" (data: Gfx_Font_Data, wide: c.int) -> Gfx_Font

Proc_Gfx_Get_Text_Tracking          :: #type proc "c" () -> c.int

// =================================================================

Proc_Vid_Load_Video         :: #type proc "c" (path: cstring) -> Video_Player
Proc_Vid_Free_Player        :: #type proc "c" (player: Video_Player) 
Proc_Vid_Set_Context        :: #type proc "c" (player: Video_Player, ctx: Bitmap) -> (ok: b32)
Proc_Vid_Use_Screen_Context :: #type proc "c" (player: Video_Player)
Proc_Vid_Render_Frame       :: #type proc "c" (player: Video_Player, n: c.int) -> (ok: b32)
Proc_Vid_Get_Error          :: #type proc "c" (player: Video_Player) -> cstring
Proc_Vid_Get_Info           :: #type proc "c" (player: Video_Player, out_width, out_height: ^c.int, out_frame_rate: ^f32, out_frame_count, out_current_frame: ^i32)
Proc_Vid_Get_Context        :: #type proc "c" (player: Video_Player) -> Bitmap


// =================================================================


//   ////////////////
//  // API STRUCT //
// ////////////////

Api_Video_Procs :: struct {
    load_video         : Proc_Vid_Load_Video,        
    free_player        : Proc_Vid_Free_Player,       
    set_context        : Proc_Vid_Set_Context,       
    use_screen_context : Proc_Vid_Use_Screen_Context,
    render_frame       : Proc_Vid_Render_Frame,      
    get_error          : Proc_Vid_Get_Error,         
    get_info           : Proc_Vid_Get_Info,          
    get_context        : Proc_Vid_Get_Context,       
}

Api_Graphics_Procs :: struct {
    video                     : ^Api_Video_Procs,

    clear                     : Proc_Gfx_Clear,
    set_background_color      : Proc_Gfx_Set_Background_Color,
    set_stencil               : Proc_Gfx_Set_Stencil,
    set_draw_mode             : Proc_Gfx_Set_Draw_Mode,
    set_draw_offset           : Proc_Gfx_Set_Draw_Offset,
    set_clip_rect             : Proc_Gfx_Set_Clip_Rect,
    clear_clip_rect           : Proc_Gfx_Clear_Clip_Rect,
    set_line_cap_style        : Proc_Gfx_Set_Line_Cap_Style,
    set_font                  : Proc_Gfx_Set_Font,
    set_text_tracking         : Proc_Gfx_Set_Text_Tracking,
    push_context              : Proc_Gfx_Push_Context,
    pop_context               : Proc_Gfx_Pop_Context,

    draw_bitmap               : Proc_Gfx_Draw_Bitmap,
    tile_bitmap               : Proc_Gfx_Tile_Bitmap,
    draw_line                 : Proc_Gfx_Draw_Line,
    fill_triangle             : Proc_Gfx_Fill_Triangle,
    draw_rect                 : Proc_Gfx_Draw_Rect,
    fill_rect                 : Proc_Gfx_Fill_Rect,
    draw_ellipse              : Proc_Gfx_Draw_Ellipse,
    fill_ellipse              : Proc_Gfx_Fill_Ellipse,
    draw_scaled_bitmap        : Proc_Gfx_Draw_Scaled_Bitmap,
    draw_text                 : Proc_Gfx_Draw_Text,
    new_bitmap                : Proc_Gfx_New_Bitmap,
    free_bitmap               : Proc_Gfx_Free_Bitmap,
    load_bitmap               : Proc_Gfx_Load_Bitmap,
    copy_bitmap               : Proc_Gfx_Copy_Bitmap,
    load_into_bitmap          : Proc_Gfx_Load_Into_Bitmap,
    get_bitmap_data           : Proc_Gfx_Get_Bitmap_Data,
    clear_bitmap              : Proc_Gfx_Clear_Bitmap,
    rotated_bitmap            : Proc_Gfx_Rotated_Bitmap,

    new_bitmap_table          : Proc_Gfx_New_Bitmap_Table,
    free_bitmap_table         : Proc_Gfx_Free_Bitmap_Table,
    load_bitmap_table         : Proc_Gfx_Load_Bitmap_Table,
    load_into_bitmap_table    : Proc_Gfx_Load_Into_Bitmap_Table,
    get_table_bitmap          : Proc_Gfx_Get_Table_Bitmap,

    load_font                 : Proc_Gfx_Load_Font,
    get_font_page             : Proc_Gfx_Get_Font_Page,
    get_page_glyph            : Proc_Gfx_Get_Page_Glyph,
    get_glyph_kerning         : Proc_Gfx_Get_Glyph_Kerning,
    get_text_width            : Proc_Gfx_Get_Text_Width,

    get_frame                 : Proc_Gfx_Get_Frame,
    get_display_frame         : Proc_Gfx_Get_Display_Frame,
    get_debug_bitmap          : Proc_Gfx_Get_Debug_Bitmap,
    copy_frame_buffer_bitmap  : Proc_Gfx_Copy_Frame_Buffer_Bitmap,
    mark_updated_rows         : Proc_Gfx_Mark_Updated_Rows,
    display                   : Proc_Gfx_Display,

    set_color_to_pattern      : Proc_Gfx_Set_Color_To_Pattern,
    check_mask_collision      : Proc_Gfx_Check_Mask_Collision,
    set_screen_clip_rect      : Proc_Gfx_Set_Screen_Clip_Rect,

    fill_polygon              : Proc_Gfx_Fill_Polygon,
    get_font_height           : Proc_Gfx_Get_Font_Height,

    get_display_buffer_bitmap : Proc_Gfx_Get_Display_Buffer_Bitmap,
    draw_rotated_bitmap       : Proc_Gfx_Draw_Rotated_Bitmap,
    set_text_leading          : Proc_Gfx_Set_Text_Leading,

    set_bitmap_mask           : Proc_Gfx_Set_Bitmap_Mask,

    get_bitmap_mask           : Proc_Gfx_Get_Bitmap_Mask,

    set_stencil_image         : Proc_Gfx_Set_Stencil_Image,

    make_font_from_data       : Proc_Gfx_Make_Font_From_Data,

    get_text_tracking         : Proc_Gfx_Get_Text_Tracking,
}
