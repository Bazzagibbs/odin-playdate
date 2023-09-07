package playdate_graphics

import "../common"

Rect            :: common.Rect

LCD_COLUMNS     :: common.LCD_COLUMNS
LCD_ROWS        :: common.LCD_ROWS
LCD_ROWSIZE     :: common.LCD_ROWSIZE
LCD_SCREEN_RECT :: common.LCD_RECT 

Bitmap          :: distinct common.Handle // Used by System
Bitmap_Table    :: distinct common.Handle
Font            :: distinct common.Handle
Font_Data       :: distinct common.Handle
Font_Page       :: distinct common.Handle
Font_Glyph      :: distinct common.Handle

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

