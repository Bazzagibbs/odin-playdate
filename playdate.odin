package playdate

import "core:runtime"
import "core:log"

import "common"
import "system"

Api :: bindings.Api

_loaders    : [9]Proc_Loader
Proc_Loader :: #type proc "contextless" (api: ^Api)

load_procs :: proc "contextless" (api: ^Api) {
    _loaders[0] = system._load_procs

    // Procs are only loaded if their package is imported
    for loader_proc in _loaders {
        if loader_proc == nil do continue
        loader_proc(api)
    }
}


default_context :: system.playdate_context
