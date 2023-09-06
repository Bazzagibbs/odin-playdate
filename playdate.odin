package playdate

import "core:runtime"
import "core:log"

import "display"
import "file"
import "graphics"
import "json"
// import "lua"
import "scoreboards"
// import "sound"
// import "sprite"
import "system"

odin_context := playdate_context()

playdate_context :: system.playdate_context

Api :: struct { 
    system_vtable      : ^system.VTable,
    file_vtable        : ^file.VTable,
    // graphics_vtable    : ^graphics.VTable,
    // sprite_vtable      : ^sprite.VTable,
    display_vtable     : ^display.VTable,
    // sound_vtable       : ^sound.VTable,
    // lua_vtable         : ^lua.VTable,
    // json_vtable        : ^json.VTable,
    // scoreboards_vtable : ^scoreboards.VTable,
}

init :: proc "c" (api: ^Api) {
    system.vtable       = api.system_vtable
    file.vtable         = api.file_vtable
    // graphics.vtable     = api.graphics_vtable
    // sprite.vtable       = api.sprite_vtable
    display.vtable      = api.display_vtable
    // sound.vtable        = api.sound_vtable
    // lua.vtable          = api.lua_vtable 
    // json_vtable         = api.json_vtable
    // scoreboards_vtable  = api.scoreboards_vtable
}
