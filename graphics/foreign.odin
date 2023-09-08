package playdate_graphics

import "video"

@(private)
_Color_Internal :: struct #raw_union {
    solid_color : Solid_Color,
    pattern     : ^Pattern
}

Proc_Clear                  :: #type proc "c" (color: _Color_Internal)
Proc_Set_Background_Color   :: #type proc "c" (color: Solid_Color) 
Proc_Set_Stencil            :: #type proc "c" (stencil: Bitmap)
Proc_Set_Draw_Mode          :: #type proc "c" (draw_mode: Bitmap_Draw_Mode)
Proc_Set_Draw_Offset        :: #type proc "c" (d_x, d_y: i32)
Proc_Set_Clip_Rect          :: #type proc "c" (x, y, width, height: i32)
Proc_Clear_Clip_Rect        :: #type proc "c" ()
Proc_Set_Line_Cap_Style     :: #type proc "c" (end_cap_style: Line_Cap_Style)
Proc_Set_Font               :: #type proc "c" (font: Font)
Proc_Set_Text_Tracking      :: #type proc "c" (tracking: i32)
Proc_Push_Context           :: #type proc "c" (target: Bitmap)
Proc_Pop_Context            :: #type proc "c" ()

Proc_Draw_Bitmap        :: #type proc "c" (bitmap: Bitmap, x, y: i32, flip: Bitmap_Flip)
Proc_Tile_Bitmap        :: #type proc "c" (bitmap: Bitmap, x, y, width, height: i32, flip: Bitmap_Flip)
Proc_Draw_Line          :: #type proc "c" (x1, y1, x2, y2, width: i32, color: _Color_Internal)
Proc_Fill_Triangle      :: #type proc "c" (x1, y1, x2, y2, x3, y3: i32, color: _Color_Internal)
Proc_Draw_Rect          :: #type proc "c" (x, y, width, height: i32, color: _Color_Internal)
Proc_Fill_Rect          :: #type proc "c" (x, y, width, height: i32, color: _Color_Internal)
Proc_Draw_Ellipse       :: #type proc "c" (x, y, width, height, line_width: i32, start_angle, end_angle: f32, color: _Color_Internal)
Proc_Fill_Ellipse       :: #type proc "c" (x, y, width, height: i32, start_angle, end_angle: f32, color: _Color_Internal)
Proc_Draw_Scaled_Bitmap :: #type proc "c" (bitmap: Bitmap, x, y: i32, x_scale, y_scale: f32)
Proc_Draw_Text          :: #type proc "c" (text: cstring, len: u32, encoding: String_Encoding, x, y: i32) -> i32
Proc_New_Bitmap         :: #type proc "c" (width, height: i32, bg_color: _Color_Internal) -> Bitmap 
Proc_Free_Bitmap        :: #type proc "c" (bitmap: Bitmap) 
Proc_Load_Bitmap        :: #type proc "c" (path: cstring, out_err: ^cstring) -> Bitmap
Proc_Copy_Bitmap        :: #type proc "c" (bitmap: Bitmap) -> Bitmap
Proc_Load_Into_Bitmap   :: #type proc "c" (path: cstring, bitmap: Bitmap, out_err: ^cstring) 
Proc_Get_Bitmap_Data    :: #type proc "c" (bitmap: Bitmap, width, height, row_bytes: ^i32, mask, data: [^]u8)
Proc_Clear_Bitmap       :: #type proc "c" (bitmap: Bitmap, bg_color: _Color_Internal)
Proc_Rotated_Bitmap     :: #type proc "c" (bitmap: Bitmap, rotation, x_scale, y_scale: f32, alloced_size: ^i32) -> Bitmap

Proc_New_Bitmap_Table       :: #type proc "c" (count, width, height: i32) -> Bitmap_Table
Proc_Free_Bitmap_Table      :: #type proc "c" (table: Bitmap_Table) 
Proc_Load_Bitmap_Table      :: #type proc "c" (path: cstring, out_err: ^cstring) -> Bitmap_Table
Proc_Load_Into_Bitmap_Table :: #type proc "c" (path: cstring, table: Bitmap_Table, out_err: ^cstring)
Proc_Get_Table_Bitmap       :: #type proc "c" (table: Bitmap_Table, idx: i32) -> Bitmap

Proc_Load_Font          :: #type proc "c" (path: cstring, out_err: ^cstring) -> Font
Proc_Get_Font_Page      :: #type proc "c" (font: Font, c: u32) -> Font_Page
Proc_Get_Page_Glyph     :: #type proc "c" (page: Font_Page, c: u32, bitmap: ^Bitmap, advance: ^i32) -> Font_Glyph
Proc_Get_Glyph_Kerning  :: #type proc "c" (glyph: Font_Glyph, glyph_code, next_code: u32) -> i32 
Proc_Get_Text_Width     :: #type proc "c" (font: Font, text: cstring, len: u32, encoding: String_Encoding, tracking: i32) -> i32

Proc_Get_Frame                  :: #type proc "c" () -> [^]u8
Proc_Get_Display_Frame          :: #type proc "c" () -> [^]u8
Proc_Get_Debug_Bitmap           :: #type proc "c" () -> Bitmap 
Proc_Copy_Frame_Buffer_Bitmap   :: #type proc "c" () -> Bitmap 
Proc_Mark_Updated_Rows          :: #type proc "c" (start, end: i32) 
Proc_Display                    :: #type proc "c" ()

Proc_Set_Color_To_Pattern :: #type proc "c" (color: _Color_Internal, bitmap: Bitmap, x, y: i32) 
Proc_Check_Mask_Collision :: #type proc "c" (bitmap_1: Bitmap, x_1, y_1: i32, flip_1: Bitmap_Flip, bitmap_2: Bitmap, x_2, y_2: i32, flip_2: Bitmap_Flip, rect: Rect) -> i32

// 1.1
Proc_Set_Screen_Clip_Rect :: #type proc "c" (x, y, width, height: i32)

// 1.1.1
Proc_Fill_Polygon       :: #type proc "c" (n_points: i32, coords: [^]i32, color: _Color_Internal, fill_rule: Polygon_Fill_Rule) 
Proc_Get_Font_Height    :: #type proc "c" (font: Font) -> u8

// 1.7
Proc_Get_Display_Buffer_Bitmap  :: #type proc "c" () -> Bitmap
Proc_Draw_Rotated_Bitmap        :: #type proc "c" (bitmap: Bitmap, x, y: i32, rotation, center_x, center_y, x_scale, y_scale: f32)
Proc_Set_Text_Leading           :: #type proc "c" (line_height_adjustment: i32) 

// 1.8
Proc_Set_Bitmap_Mask :: #type proc "c" (bitmap, mask: Bitmap) -> i32
Proc_Get_Bitmap_Mask :: #type proc "c" (bitmap: Bitmap) -> Bitmap 

// 1.10
Proc_Set_Stencil_Image :: #type proc "c" (stencil: Bitmap, tile: i32)

// 1.12
Proc_Make_Font_From_Data :: #type proc "c" (data: Font_Data, wide: i32) -> Font


vtable: ^VTable

VTable :: struct {
    video                   : ^video.VTable,

    clear                   : Proc_Clear,
    set_background_color    : Proc_Set_Background_Color,
    set_stencil             : Proc_Set_Stencil,             // DEPRECATED
    set_draw_mode           : Proc_Set_Draw_Mode,
    set_draw_offset         : Proc_Set_Draw_Offset,
    set_clip_rect           : Proc_Set_Clip_Rect,
    clear_clip_rect         : Proc_Clear_Clip_Rect,
    set_line_cap_style      : Proc_Set_Line_Cap_Style,
    set_font                : Proc_Set_Font,
    set_text_tracking       : Proc_Set_Text_Tracking,
    push_context            : Proc_Push_Context,
    pop_context             : Proc_Pop_Context,    
                             
    draw_bitmap             : Proc_Draw_Bitmap,
    tile_bitmap             : Proc_Tile_Bitmap,
    draw_line               : Proc_Draw_Line,
    fill_triangle           : Proc_Fill_Triangle,
    draw_rect               : Proc_Draw_Rect,
    fill_rect               : Proc_Fill_Rect,
    draw_ellipse            : Proc_Draw_Ellipse,
    fill_ellipse            : Proc_Fill_Ellipse,
    draw_scaled_bitmap      : Proc_Draw_Scaled_Bitmap,
    draw_text               : Proc_Draw_Text,

    new_bitmap              : Proc_New_Bitmap,
    free_bitmap             : Proc_Free_Bitmap,
    load_bitmap             : Proc_Load_Bitmap,
    copy_bitmap             : Proc_Copy_Bitmap,
    load_into_bitmap        : Proc_Load_Into_Bitmap,
    get_bitmap_data         : Proc_Get_Bitmap_Data,
    clear_bitmap            : Proc_Clear_Bitmap,
    rotated_bitmap          : Proc_Rotated_Bitmap,
                             
    new_bitmap_table        : Proc_New_Bitmap_Table,
    free_bitmap_table       : Proc_Free_Bitmap_Table,
    load_bitmap_table       : Proc_Load_Bitmap_Table,
    load_into_bitmap_table  : Proc_Load_Into_Bitmap_Table,
    get_table_bitmap        : Proc_Get_Table_Bitmap,

    load_font                   : Proc_Load_Font,
    get_font_page               : Proc_Get_Font_Page,
    get_page_glyph              : Proc_Get_Page_Glyph,
    get_glyph_kerning           : Proc_Get_Glyph_Kerning,
    get_text_width              : Proc_Get_Text_Width,

    get_frame                   : Proc_Get_Frame,
    get_display_frame           : Proc_Get_Display_Frame,
    get_debug_bitmap            : Proc_Get_Debug_Bitmap,
    copy_frame_buffer_bitmap    : Proc_Copy_Frame_Buffer_Bitmap,
    mark_updated_rows           : Proc_Mark_Updated_Rows,
    display                     : Proc_Display,

    set_color_to_pattern        : Proc_Set_Color_To_Pattern,
    check_mask_collision        : Proc_Check_Mask_Collision,
                                  
    // 1.1
    set_screen_clip_rect        : Proc_Set_Screen_Clip_Rect,

    // 1.1.1
    fill_polygon                : Proc_Fill_Polygon,
    get_font_height             : Proc_Get_Font_Height,

    // 1.7
    get_display_buffer_bitmap   : Proc_Get_Display_Buffer_Bitmap,
    draw_rotated_bitmap         : Proc_Draw_Rotated_Bitmap,
    set_text_leading            : Proc_Set_Text_Leading,

    // 1.8
    set_bitmap_mask             : Proc_Set_Bitmap_Mask,
    get_bitmap_mask             : Proc_Get_Bitmap_Mask,

    // 1.10 
    set_stencil_image           : Proc_Set_Stencil_Image,

    // 1.12
    make_font_from_data         : Proc_Make_Font_From_Data,
}