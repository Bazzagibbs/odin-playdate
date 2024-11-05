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
import "core:log"

import "bindings"
import "system"

Api :: bindings.Api

default_context :: system.playdate_context

load_procs :: bindings.load_procs

Handle :: bindings.Handle

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
