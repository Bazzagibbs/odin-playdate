// Odin bindings for the Playdate C API
// For full documentation, see https://sdk.play.date/#developing-in-c
//
// ## Prerequisites 
// - Download and install the SDK from https://play.date/dev/
// - Set the environment variable `PLAYDATE_SDK_PATH` to the installed directory.
// 
// ## Building for Playdate simulator
// WIP
//
// ## Building for Playdate hardware
// WIP
package playdate

import "base:runtime"

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

System_Event :: enum {
    init,
    init_lua,
    lock,
    unlock,
    pause,
    resume,
    terminate,
    key_pressed,
    key_released,
    low_power,
}

Handle :: distinct rawptr

Bitmap :: distinct Handle
Sprite :: distinct Handle

Package_ID :: enum {
    system,
    file,
    graphics,
    sprite,
    display,
    sound,
    lua,
    json,
    scoreboards,
}


// When a subpackage is imported, it registers a proc to cache its procedure pointers.
_Loader_Proc :: #type proc "contextless" (api: ^Api)
_loaders : [Package_ID]_Loader_Proc

load_api :: proc "contextless" (api: ^Api) {
    for loader in _loaders {
        if loader != nil do loader(api)
    }
}

