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
import "core:net"

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
    Unflipped,
    Flipped_X,
    Flipped_Y,
    Flipped_XY,
}

Bitmap_Draw_Mode :: enum {
    Copy,
    White_Transparent,
    Black_Transparent,
    Fill_White,
    Fill_Black,
    XOR,
    NXOR,
    Inverted,
}

System_Event :: enum {
    Init,
    Init_Lua,
    Lock,
    Unlock,
    Pause,
    Resume,
    Terminate,
    Key_Pressed,
    Key_Peleased,
    Low_Power,
}

Opaque_Struct :: distinct struct{}

Bitmap :: distinct Opaque_Struct
Sprite :: distinct Opaque_Struct

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


// Excluded for bindings-only releases
// ===================================

// // When a subpackage is imported, it registers a proc to cache its procedure pointers.
// _Loader_Proc :: #type proc "contextless" (api: ^Api)
// _loaders : [Package_ID]_Loader_Proc
//
// load_api :: proc "contextless" (api: ^Api) {
//     for loader in _loaders {
//         if loader != nil do loader(api)
//     }
// }
