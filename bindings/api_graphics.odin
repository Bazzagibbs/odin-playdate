package playdate_bindings

import "core:c"

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

Api_Video_Procs :: struct {
    load_video         : proc "c" (path: cstring) -> Video_Player,
    free_player        : proc "c" (player: Video_Player) ,
    set_context        : proc "c" (player: Video_Player, ctx: Bitmap) -> (ok: b32),
    use_screen_context : proc "c" (player: Video_Player),
    render_frame       : proc "c" (player: Video_Player, n: c.int) -> (ok: b32),
    get_error          : proc "c" (player: Video_Player) -> cstring,
    get_info           : proc "c" (player: Video_Player, out_width, out_height: ^c.int, out_frame_rate: ^f32, out_frame_count, out_current_frame: ^i32),
    get_context        : proc "c" (player: Video_Player) -> Bitmap,
}

// =================================================================

Api_Graphics_Procs :: struct {
    video                      : ^Api_Video_Procs,

    // Drawing Functions
    clear                      : proc "c" (color: Gfx_Color),
    set_background_color       : proc "c" (color: Gfx_Solid_Color) ,
    set_stencil                : proc "c" (stencil: Bitmap),
    set_draw_mode              : proc "c" (draw_mode: Bitmap_Draw_Mode) -> Bitmap_Draw_Mode,
    set_draw_offset            : proc "c" (dx, dy: c.int),
    set_clip_rect              : proc "c" (x, y, width, height: c.int),
    clear_clip_rect            : proc "c" (),
    set_line_cap_style         : proc "c" (end_cap_style: Gfx_Line_Cap_Style),
    set_font                   : proc "c" (font: Gfx_Font),
    set_text_tracking          : proc "c" (tracking: c.int),
    push_context               : proc "c" (target: Bitmap),
    pop_context                : proc "c" (),

    draw_bitmap                : proc "c" (bitmap: Bitmap, x, y: c.int, flip: Bitmap_Flip),
    tile_bitmap                : proc "c" (bitmap: Bitmap, x, y, width, height: c.int, flip: Bitmap_Flip),
    draw_line                  : proc "c" (x1, y1, x2, y2, width: c.int, color: Gfx_Color),
    fill_triangle              : proc "c" (x1, y1, x2, y2, x3, y3: c.int, color: Gfx_Color),
    draw_rect                  : proc "c" (x, y, width, height: c.int, color: Gfx_Color),
    fill_rect                  : proc "c" (x, y, width, height: c.int, color: Gfx_Color),
    draw_ellipse               : proc "c" (x, y, width, height, line_width: c.int, start_angle, end_angle: f32, color: Gfx_Color),
    fill_ellipse               : proc "c" (x, y, width, height: c.int, start_angle, end_angle: f32, color: Gfx_Color),
    draw_scaled_bitmap         : proc "c" (bitmap: Bitmap, x, y: c.int, x_scale, y_scale: f32),
    draw_text                  : proc "c" (text: cstring, len: c.size_t, encoding: Gfx_String_Encoding, x, y: c.int) -> i32,
    
    // LCDBitmap
    new_bitmap                 : proc "c" (width, height: c.int, bg_color: Gfx_Color) -> Bitmap ,
    free_bitmap                : proc "c" (bitmap: Bitmap) ,
    load_bitmap                : proc "c" (path: cstring, out_err: ^cstring) -> Bitmap,
    copy_bitmap                : proc "c" (bitmap: Bitmap) -> Bitmap,
    load_into_bitmap           : proc "c" (path: cstring, bitmap: Bitmap, out_err: ^cstring) ,
    get_bitmap_data            : proc "c" (bitmap: Bitmap, out_width, out_height, out_row_bytes: ^c.int, out_mask, out_data: ^[^]u8),
    clear_bitmap               : proc "c" (bitmap: Bitmap, bg_color: Gfx_Color),
    rotated_bitmap             : proc "c" (bitmap: Bitmap, rotation, x_scale, y_scale: f32, out_alloced_size: ^c.int) -> Bitmap,

    // LCDBitmapTable
    new_bitmap_table           : proc "c" (count, width, height: c.int) -> Gfx_Bitmap_Table,
    free_bitmap_table          : proc "c" (table: Gfx_Bitmap_Table) ,
    load_bitmap_table          : proc "c" (path: cstring, out_err: ^cstring) -> Gfx_Bitmap_Table,
    load_into_bitmap_table     : proc "c" (path: cstring, table: Gfx_Bitmap_Table, out_err: ^cstring),
    get_table_bitmap           : proc "c" (table: Gfx_Bitmap_Table, idx: c.int) -> Bitmap,

    // LCDFont
    load_font                  : proc "c" (path: cstring, out_err: ^cstring) -> Gfx_Font,
    get_font_page              : proc "c" (font: Gfx_Font, ch: u32) -> Gfx_Font_Page,
    get_page_glyph             : proc "c" (page: Gfx_Font_Page, ch: u32, bitmap: ^Bitmap, advance: ^(c.int)) -> Gfx_Font_Glyph,
    get_glyph_kerning          : proc "c" (glyph: Gfx_Font_Glyph, glyph_code, next_code: u32) -> c.int ,
    get_text_width             : proc "c" (font: Gfx_Font, text: cstring, len: c.size_t, encoding: Gfx_String_Encoding, tracking: c.int) -> i32,

    // raw framebuffer access
    get_frame                  : proc "c" () -> [^]u8,
    get_display_frame          : proc "c" () -> [^]u8,
    get_debug_bitmap           : proc "c" () -> Bitmap ,
    copy_frame_buffer_bitmap   : proc "c" () -> Bitmap ,
    mark_updated_rows          : proc "c" (start, end: c.int) ,
    display                    : proc "c" (),

    // misc util.
    set_color_to_pattern       : proc "c" (color: Gfx_Color, bitmap: Bitmap, x, y: c.int) ,
    check_mask_collision       : proc "c" (bitmap_1: Bitmap, x_1, y_1: c.int, flip_1: Bitmap_Flip, bitmap_2: Bitmap, x_2, y_2: i32, flip_2: Bitmap_Flip, rect: Rect) -> b32,

    // 1.1
    set_screen_clip_rect       : proc "c" (x, y, width, height: c.int),

    // 1.1.1
    fill_polygon               : proc "c" (n_points: c.int, coords: [^]i32, color: Gfx_Color, fill_rule: Gfx_Polygon_Fill_Rule) ,
    get_font_height            : proc "c" (font: Gfx_Font) -> u8,

    // 1.7
    get_display_buffer_bitmap  : proc "c" () -> Bitmap,
    draw_rotated_bitmap        : proc "c" (bitmap: Bitmap, x, y: c.int, rotation, center_x, center_y, x_scale, y_scale: f32),
    set_text_leading           : proc "c" (line_height_adjustment: c.int) ,

    // 1.8
    set_bitmap_mask            : proc "c" (bitmap, mask: Bitmap) -> c.int, // Return value undocumented

    get_bitmap_mask            : proc "c" (bitmap: Bitmap) -> Bitmap ,

    // 1.10
    set_stencil_image          : proc "c" (stencil: Bitmap, tile: c.int),

    // 1.12
    make_font_from_data        : proc "c" (data: Gfx_Font_Data, wide: b32) -> Gfx_Font,

    // 2.1
    get_text_tracking          : proc "c" () -> c.int,

    // 2.5
    set_pixel                  : proc "c" (x, y: c.int, color: Gfx_Color),
    get_bitmap_pixel           : proc "c" (bitmap: Bitmap, x, y: c.int) -> Gfx_Solid_Color,
    get_bitmap_table_info      : proc "c" (table: Gfx_Bitmap_Table, count, width: ^c.int),
}

// =================================================================

