package playdate_common

import "core:runtime"

Api :: struct { 
    system      : ^Api_System_Procs,
    file        : ^Api_File_Procs,
    graphics    : ^Api_Graphics_Procs,
    sprite      : ^Api_Sprite_Procs,
    display     : ^Api_Display_Procs,
    sound       : ^Api_Sound_Procs,
    lua         : ^Api_Lua_Procs,
    json        : ^Api_Json_Procs,
    scoreboards : ^Api_Scoreboards_Procs,
}


LCD_COLUMNS     :: 400
LCD_ROWS        :: 240
LCD_ROWSIZE     :: 52
LCD_SCREEN_RECT :: Rect{0, 0, LCD_COLUMNS, LCD_ROWS}

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


