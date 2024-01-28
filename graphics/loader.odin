package playdate_graphics

import "core:c"
import "video"

//   ////////////////
//  // PROC TYPES //
// ////////////////

Proc_Clear                      :: #type proc "c" (color: Color)
Proc_Set_Background_Color       :: #type proc "c" (color: Solid_Color) 
Proc_Set_Stencil                :: #type proc "c" (stencil: Bitmap)
Proc_Set_Draw_Mode              :: #type proc "c" (draw_mode: Bitmap_Draw_Mode)
Proc_Set_Draw_Offset            :: #type proc "c" (dx, dy: c.int)
Proc_Set_Clip_Rect              :: #type proc "c" (x, y, width, height: c.int)
Proc_Clear_Clip_Rect            :: #type proc "c" ()
Proc_Set_Line_Cap_Style         :: #type proc "c" (end_cap_style: Line_Cap_Style)
Proc_Set_Font                   :: #type proc "c" (font: Font)
Proc_Set_Text_Tracking          :: #type proc "c" (tracking: c.int)
Proc_Push_Context               :: #type proc "c" (target: Bitmap)
Proc_Pop_Context                :: #type proc "c" ()

Proc_Draw_Bitmap                :: #type proc "c" (bitmap: Bitmap, x, y: c.int, flip: Bitmap_Flip)
Proc_Tile_Bitmap                :: #type proc "c" (bitmap: Bitmap, x, y, width, height: c.int, flip: Bitmap_Flip)
Proc_Draw_Line                  :: #type proc "c" (x1, y1, x2, y2, width: c.int, color: Color)
Proc_Fill_Triangle              :: #type proc "c" (x1, y1, x2, y2, x3, y3: c.int, color: Color)
Proc_Draw_Rect                  :: #type proc "c" (x, y, width, height: c.int, color: Color)
Proc_Fill_Rect                  :: #type proc "c" (x, y, width, height: c.int, color: Color)
Proc_Draw_Ellipse               :: #type proc "c" (x, y, width, height, line_width: c.int, start_angle, end_angle: f32, color: Color)
Proc_Fill_Ellipse               :: #type proc "c" (x, y, width, height: c.int, start_angle, end_angle: f32, color: Color)
Proc_Draw_Scaled_Bitmap         :: #type proc "c" (bitmap: Bitmap, x, y: c.int, x_scale, y_scale: f32)
Proc_Draw_Text                  :: #type proc "c" (text: cstring, len: u32, encoding: String_Encoding, x, y: c.int) -> i32
Proc_New_Bitmap                 :: #type proc "c" (width, height: c.int, bg_color: Color) -> Bitmap 
Proc_Free_Bitmap                :: #type proc "c" (bitmap: Bitmap) 
Proc_Load_Bitmap                :: #type proc "c" (path: cstring, out_err: ^cstring) -> Bitmap
Proc_Copy_Bitmap                :: #type proc "c" (bitmap: Bitmap) -> Bitmap
Proc_Load_Into_Bitmap           :: #type proc "c" (path: cstring, bitmap: Bitmap, out_err: ^cstring) 
Proc_Get_Bitmap_Data            :: #type proc "c" (bitmap: Bitmap, out_width, out_height, out_row_bytes: ^c.int, out_mask, out_data: ^[^]u8)
Proc_Clear_Bitmap               :: #type proc "c" (bitmap: Bitmap, bg_color: Color)
Proc_Rotated_Bitmap             :: #type proc "c" (bitmap: Bitmap, rotation, x_scale, y_scale: f32, out_alloced_size: ^c.int) -> Bitmap

Proc_New_Bitmap_Table           :: #type proc "c" (count, width, height: c.int) -> Bitmap_Table
Proc_Free_Bitmap_Table          :: #type proc "c" (table: Bitmap_Table) 
Proc_Load_Bitmap_Table          :: #type proc "c" (path: cstring, out_err: ^cstring) -> Bitmap_Table
Proc_Load_Into_Bitmap_Table     :: #type proc "c" (path: cstring, table: Bitmap_Table, out_err: ^cstring)
Proc_Get_Table_Bitmap           :: #type proc "c" (table: Bitmap_Table, idx: c.int) -> Bitmap

Proc_Load_Font                  :: #type proc "c" (path: cstring, out_err: ^cstring) -> Font
Proc_Get_Font_Page              :: #type proc "c" (font: Font, ch: u32) -> Font_Page
Proc_Get_Page_Glyph             :: #type proc "c" (page: Font_Page, ch: u32, bitmap: ^Bitmap, advance: ^(c.int)) -> Font_Glyph
Proc_Get_Glyph_Kerning          :: #type proc "c" (glyph: Font_Glyph, glyph_code, next_code: u32) -> c.int 
Proc_Get_Text_Width             :: #type proc "c" (font: Font, text: cstring, len: u32, encoding: String_Encoding, tracking: c.int) -> i32

Proc_Get_Frame                  :: #type proc "c" () -> [^]u8
Proc_Get_Display_Frame          :: #type proc "c" () -> [^]u8
Proc_Get_Debug_Bitmap           :: #type proc "c" () -> Bitmap 
Proc_Copy_Frame_Buffer_Bitmap   :: #type proc "c" () -> Bitmap 
Proc_Mark_Updated_Rows          :: #type proc "c" (start, end: c.int) 
Proc_Display                    :: #type proc "c" ()

Proc_Set_Color_To_Pattern       :: #type proc "c" (color: Color, bitmap: Bitmap, x, y: c.int) 
Proc_Check_Mask_Collision       :: #type proc "c" (bitmap_1: Bitmap, x_1, y_1: c.int, flip_1: Bitmap_Flip, bitmap_2: Bitmap, x_2, y_2: i32, flip_2: Bitmap_Flip, rect: Rect) -> i32
Proc_Set_Screen_Clip_Rect       :: #type proc "c" (x, y, width, height: c.int)

Proc_Fill_Polygon               :: #type proc "c" (n_points: c.int, coords: [^]i32, color: Color, fill_rule: Polygon_Fill_Rule) 
Proc_Get_Font_Height            :: #type proc "c" (font: Font) -> u8

Proc_Get_Display_Buffer_Bitmap  :: #type proc "c" () -> Bitmap
Proc_Draw_Rotated_Bitmap        :: #type proc "c" (bitmap: Bitmap, x, y: c.int, rotation, center_x, center_y, x_scale, y_scale: f32)
Proc_Set_Text_Leading           :: #type proc "c" (line_height_adjustment: c.int) 

Proc_Set_Bitmap_Mask            :: #type proc "c" (bitmap, mask: Bitmap) -> c.int

Proc_Get_Bitmap_Mask            :: #type proc "c" (bitmap: Bitmap) -> Bitmap 

Proc_Set_Stencil_Image          :: #type proc "c" (stencil: Bitmap, tile: c.int)

Proc_Make_Font_From_Data        :: #type proc "c" (data: Font_Data, wide: c.int) -> Font

Proc_Get_Text_Tracking          :: #type proc "c" () -> c.int

// ===================================================


//   ////////////////
//  // API STRUCT //
// ////////////////

Api_Procs :: struct {
    video                    : ^video.Api_Procs,

    clear                    : Proc_Clear,
    set_background_color     : Proc_Set_Background_Color,
    set_stencil              : Proc_Set_Stencil,
    set_draw_mode            : Proc_Set_Draw_Mode,
    set_draw_offset          : Proc_Set_Draw_Offset,
    set_clip_rect            : Proc_Set_Clip_Rect,
    clear_clip_rect          : Proc_Clear_Clip_Rect,
    set_line_cap_style       : Proc_Set_Line_Cap_Style,
    set_font                 : Proc_Set_Font,
    set_text_tracking        : Proc_Set_Text_Tracking,
    push_context             : Proc_Push_Context,
    pop_context              : Proc_Pop_Context,

    draw_bitmap              : Proc_Draw_Bitmap,
    tile_bitmap              : Proc_Tile_Bitmap,
    draw_line                : Proc_Draw_Line,
    fill_triangle            : Proc_Fill_Triangle,
    draw_rect                : Proc_Draw_Rect,
    fill_rect                : Proc_Fill_Rect,
    draw_ellipse             : Proc_Draw_Ellipse,
    fill_ellipse             : Proc_Fill_Ellipse,
    draw_scaled_bitmap       : Proc_Draw_Scaled_Bitmap,
    draw_text                : Proc_Draw_Text,
    new_bitmap               : Proc_New_Bitmap,
    free_bitmap              : Proc_Free_Bitmap,
    load_bitmap              : Proc_Load_Bitmap,
    copy_bitmap              : Proc_Copy_Bitmap,
    load_into_bitmap         : Proc_Load_Into_Bitmap,
    get_bitmap_data          : Proc_Get_Bitmap_Data,
    clear_bitmap             : Proc_Clear_Bitmap,
    rotated_bitmap           : Proc_Rotated_Bitmap,

    new_bitmap_table         : Proc_New_Bitmap_Table,
    free_bitmap_table        : Proc_Free_Bitmap_Table,
    load_bitmap_table        : Proc_Load_Bitmap_Table,
    load_into_bitmap_table   : Proc_Load_Into_Bitmap_Table,
    get_table_bitmap         : Proc_Get_Table_Bitmap,

    load_font                : Proc_Load_Font,
    get_font_page            : Proc_Get_Font_Page,
    get_page_glyph           : Proc_Get_Page_Glyph,
    get_glyph_kerning        : Proc_Get_Glyph_Kerning,
    get_text_width           : Proc_Get_Text_Width,

    get_frame                : Proc_Get_Frame,
    get_display_frame        : Proc_Get_Display_Frame,
    get_debug_bitmap         : Proc_Get_Debug_Bitmap,
    copy_frame_buffer_bitmap : Proc_Copy_Frame_Buffer_Bitmap,
    mark_updated_rows        : Proc_Mark_Updated_Rows,
    display                  : Proc_Display,

    set_color_to_pattern     : Proc_Set_Color_To_Pattern,
    check_mask_collision     : Proc_Check_Mask_Collision,
    set_screen_clip_rect     : Proc_Set_Screen_Clip_Rect,

    fill_polygon             : Proc_Fill_Polygon,
    get_font_height          : Proc_Get_Font_Height,

    get_display_buffer_bitmap: Proc_Get_Display_Buffer_Bitmap,
    draw_rotated_bitmap      : Proc_Draw_Rotated_Bitmap,
    set_text_leading         : Proc_Set_Text_Leading,

    set_bitmap_mask          : Proc_Set_Bitmap_Mask,

    get_bitmap_mask          : Proc_Get_Bitmap_Mask,

    set_stencil_image        : Proc_Set_Stencil_Image,

    make_font_from_data      : Proc_Make_Font_From_Data,

    get_text_tracking        : Proc_Get_Text_Tracking,
}

// =================================================================


//   /////////////////
//  // LOADER PROC //
// /////////////////

_load_procs :: proc(api_procs: ^Api_Procs) {
    clear                     = api_procs.clear
    set_background_color      = api_procs.set_background_color
    set_stencil               = api_procs.set_stencil
    set_draw_mode             = api_procs.set_draw_mode
    set_draw_offset           = api_procs.set_draw_offset
    set_clip_rect             = api_procs.set_clip_rect
    clear_clip_rect           = api_procs.clear_clip_rect
    set_line_cap_style        = api_procs.set_line_cap_style
    set_font                  = api_procs.set_font
    set_text_tracking         = api_procs.set_text_tracking
    push_context              = api_procs.push_context
    pop_context               = api_procs.pop_context

    draw_bitmap               = api_procs.draw_bitmap
    tile_bitmap               = api_procs.tile_bitmap
    draw_line                 = api_procs.draw_line
    fill_triangle             = api_procs.fill_triangle
    draw_rect                 = api_procs.draw_rect
    fill_rect                 = api_procs.fill_rect
    draw_ellipse              = api_procs.draw_ellipse
    fill_ellipse              = api_procs.fill_ellipse
    draw_scaled_bitmap        = api_procs.draw_scaled_bitmap
    draw_text                 = api_procs.draw_text
    new_bitmap                = api_procs.new_bitmap
    free_bitmap               = api_procs.free_bitmap
    load_bitmap               = api_procs.load_bitmap
    copy_bitmap               = api_procs.copy_bitmap
    load_into_bitmap          = api_procs.load_into_bitmap
    get_bitmap_data           = api_procs.get_bitmap_data
    clear_bitmap              = api_procs.clear_bitmap
    rotated_bitmap            = api_procs.rotated_bitmap

    new_bitmap_table          = api_procs.new_bitmap_table
    free_bitmap_table         = api_procs.free_bitmap_table
    load_bitmap_table         = api_procs.load_bitmap_table
    load_into_bitmap_table    = api_procs.load_into_bitmap_table
    get_table_bitmap          = api_procs.get_table_bitmap

    load_font                 = api_procs.load_font
    get_font_page             = api_procs.get_font_page
    get_page_glyph            = api_procs.get_page_glyph
    get_glyph_kerning         = api_procs.get_glyph_kerning
    get_text_width            = api_procs.get_text_width

    get_frame                 = api_procs.get_frame
    get_display_frame         = api_procs.get_display_frame
    get_debug_bitmap          = api_procs.get_debug_bitmap
    copy_frame_buffer_bitmap  = api_procs.copy_frame_buffer_bitmap
    mark_updated_rows         = api_procs.mark_updated_rows
    display                   = api_procs.display

    set_color_to_pattern      = api_procs.set_color_to_pattern
    check_mask_collision      = api_procs.check_mask_collision
    set_screen_clip_rect      = api_procs.set_screen_clip_rect

    fill_polygon              = api_procs.fill_polygon
    get_font_height           = api_procs.get_font_height

    get_display_buffer_bitmap = api_procs.get_display_buffer_bitmap
    draw_rotated_bitmap       = api_procs.draw_rotated_bitmap
    set_text_leading          = api_procs.set_text_leading

    set_bitmap_mask           = api_procs.set_bitmap_mask

    get_bitmap_mask           = api_procs.get_bitmap_mask

    set_stencil_image         = api_procs.set_stencil_image

    make_font_from_data       = api_procs.make_font_from_data

    get_text_tracking         = api_procs.get_text_tracking
}
