package playdate

import "core:runtime"
import "core:log"

import "common"

import pd_display "display"
import pd_file "file"
import pd_graphics "graphics"
import pd_video "graphics/video"
import pd_json "json"
import pd_lua "lua"
import pd_scoreboards "scoreboards"
// import pd_sound "sound"
import pd_sprite "sprite"
import pd_system "system"


default_context :: pd_system.playdate_context
default_logger  :: pd_system.playdate_logger

Api :: struct { 
    // system      : ^pd_system.Api_Procs,
    system      : ^pd_system.VTable,
    file        : ^pd_file.Api_Procs,
    graphics    : ^pd_graphics.Api_Procs,
    // sprite      : ^pd_sprite.Api_Procs,
    sprite      : ^pd_sprite.VTable,
    display     : ^pd_display.Api_Procs,
    // sound       : ^pd_sound.Api_Procs,
    sound       : rawptr,
    // lua         : ^lua.Api_Procs,
    lua         : ^pd_lua.VTable,
    // json        : ^pd_json.Api_Procs,
    json        : ^pd_json.VTable,
    // scoreboards : ^pd_scoreboards.Api_Procs,
    scoreboards : ^pd_scoreboards.VTable,
}

// Load procedures from the Playdate API, and set up a context to be used by callbacks.
load_procs :: proc(api: ^Api, ctx := context) {
    common.global_context = ctx

    pd_system.vtable            = api.system
    pd_file._load_procs(api.file)
    pd_graphics._load_procs(api.graphics)
    pd_video._load_procs(api.graphics.video)
    pd_sprite.vtable            = api.sprite
    pd_display._load_procs(api.display)
    // pd_sound.vtable             = api.sound
    pd_lua.vtable               = api.lua 
    pd_json.vtable              = api.json
    pd_scoreboards.vtable       = api.scoreboards
}

