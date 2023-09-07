package playdate

import "core:runtime"
import "core:log"

import "common"

import "display"
import "file"
import "graphics"
import "json"
// import "lua"
import "scoreboards"
// import "sound"
// import "sprite"
import "system"


default_context :: system.playdate_context
default_logger :: system.playdate_logger

Api :: struct { 
    system_vtable      : ^system.VTable,
    file_vtable        : ^file.VTable,
    graphics_vtable    : rawptr,
    // graphics_vtable    : ^graphics.VTable,
    sprite_vtable      : rawptr,
    // sprite_vtable      : ^sprite.VTable,
    display_vtable     : ^display.VTable,
    sound_vtable       : rawptr,
    // sound_vtable       : ^sound.VTable,
    lua_vtable         : rawptr,
    // lua_vtable         : ^lua.VTable,
    json_vtable        : rawptr,
    // json_vtable        : ^json.VTable,
    scoreboards_vtable : rawptr,
    // scoreboards_vtable : ^scoreboards.VTable,
}

// Load procedures from the Playdate API, and set up a context to be used by callbacks.
init :: proc(api: ^Api, ctx := context) {
    common.global_context = ctx

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

