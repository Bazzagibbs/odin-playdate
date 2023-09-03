package playdate_graphics

COLUMNS     :: 400
ROWS        :: 240
ROWSIZE     :: 52
SCREEN_RECT :: Rect{0, 0, COLUMNS, ROWS}

Handle          :: distinct rawptr

Bitmap          :: distinct Handle
Bitmap_Table    :: distinct Handle
Font            :: distinct Handle
Font_Data       :: distinct Handle
Font_Page       :: distinct Handle
Font_Glyph      :: distinct Handle

Rect :: struct {
    left    : i32, 
    right   : i32, // not inclusive
    top     : i32, 
    bottom  : i32, // not inclusive
}

Bitmap_Draw_Mode :: enum {
    copy,
    white_transparent,
    black_transparent,
    fill_white,
    fill_black,
    xor,
    nxor,
    inverted,
}

Bitmap_Flip :: enum {
    unflipped,
    flipped_x,
    flipped_y,
    flipped_xy,
}

Solid_Color :: enum {
    black,
    white,
    clear,
    xor,
}

Line_Cap_Style :: enum {
    butt,
    square,
    round,
}

Font_Language :: enum {
    english,
    japanese,
    unknown,
}

String_Encoding :: enum {
    ascii,
    utf8,
    _16_bit_le,
}

Pattern :: distinct [16]u8

Color :: union {
    Solid_Color,
    ^Pattern,
}

Polygon_Fill_Rule :: enum {
    non_zero,
    even_odd,
}

