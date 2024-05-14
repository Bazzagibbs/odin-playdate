package playdate

import "bindings"

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
