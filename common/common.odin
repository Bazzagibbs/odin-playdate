package playdate_common

import "core:runtime"


LCD_COLUMNS     :: 400
LCD_ROWS        :: 240
LCD_ROWSIZE     :: 52
LCD_RECT        :: Rect{0, 0, LCD_COLUMNS, LCD_ROWS}

// .right and .bottom are not inclusive
Rect :: struct {
    left    : i32, 
    right   : i32, // not inclusive
    top     : i32, 
    bottom  : i32, // not inclusive
}

Bitmap_Flip :: enum {
    unflipped,
    flipped_x,
    flipped_y,
    flipped_xy,
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

Handle :: distinct rawptr

Bitmap :: distinct Handle
Sprite :: distinct Handle

global_context: runtime.Context
