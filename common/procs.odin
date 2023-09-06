package playdate_common

import "core:runtime"
import "../system"

playdate_context :: proc "contextless" () -> runtime.Context {
    c: runtime.Context
    c.allocator = runtime.Allocator {
        procedure = system._allocator_proc,
        data = nil,
    }

    c.logger = runtime.Logger {
        procedure = system._logger_proc,
        data = nil,
    }

    return c
}
