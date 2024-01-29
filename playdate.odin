package playdate

import "core:runtime"
import "core:log"

import "common"
import "system"

default_context :: system.playdate_context
default_logger  :: system.playdate_logger

Api :: struct { 
    system      : ^common.Api_System_Procs,
    file        : ^common.Api_File_Procs,
    graphics    : ^common.Api_Graphics_Procs,
    sprite      : ^common.Api_Sprite_Procs,
    display     : ^common.Api_Display_Procs,
    sound       : ^common.Api_Sound_Procs,
    lua         : ^common.Api_Lua_Procs,
    json        : ^common.Api_Json_Procs,
    scoreboards : ^common.Api_Scoreboards_Procs,
}


_loaders    : [9]Proc_Loader
Proc_Loader :: #type proc "contextless" (api: ^Api)

load_procs :: proc "contextless" (api: ^Api) {
    // Procs are only loaded if their package is imported
    for loader_proc in _loaders {
        if loader_proc == nil do continue
        loader_proc(api)
    }
}


@(deferred_out=destroy_global_context)
create_global_context :: proc "contextless" () -> runtime.Context {
    return default_context()
}

destroy_global_context :: proc "contextless" (ctx: runtime.Context) {

}
