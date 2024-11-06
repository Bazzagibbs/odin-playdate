package playdate

import "base:runtime"
import "core:strings"
import "core:fmt"
import "core:log"
import "core:mem"

NO_DEFAULT_TEMP_ALLOCATOR :: runtime.NO_DEFAULT_TEMP_ALLOCATOR

@(private)
_Level_Headers := [?]string{
    0 = "[DEBUG] ",
    1 = "[INFO ] ",
    2 = "[WARN ] ",
    3 = "[ERROR] ",
    4 = "[FATAL] ",
}

// Get a context configured for Playdate applications.
playdate_context :: proc "contextless" (api: ^Api) -> runtime.Context {
    ctx: runtime.Context

    ctx.allocator      = playdate_allocator(api)
    ctx.temp_allocator = playdate_temp_allocator()

    when !ODIN_DISABLE_ASSERT {
        ctx.assertion_failure_proc = playdate_assertion_failure_proc
    }
   
    ctx.logger = playdate_logger(api) 
    
    return ctx
}


// Allocator that uses the Playdate's system allocation functions
playdate_allocator :: proc "contextless" (api: ^Api) -> runtime.Allocator {
    return runtime.Allocator {
        procedure = playdate_allocator_proc,
        data      = rawptr(api.system.realloc),
    }
}


playdate_temp_allocator :: proc "contextless" () -> runtime.Allocator {
    when !runtime.NO_DEFAULT_TEMP_ALLOCATOR {
        return runtime.Allocator {
            procedure = runtime.default_temp_allocator_proc,
            data      = &runtime.global_default_temp_allocator_data,
        }
    } 
    else {
        return {}
    }

}



// Logger that outputs to the Playdate's console
playdate_logger :: proc "contextless" (api: ^Api) -> runtime.Logger {
    return runtime.Logger {
        procedure    = playdate_logger_proc,
        data         = rawptr(api.system),
        lowest_level = .Debug,
        options      = {.Level, .Time, .Procedure, .Line},
    }
}


playdate_allocator_proc :: proc (allocator_data: rawptr, mode: runtime.Allocator_Mode, 
                        size, alignment: int, 
                        old_memory: rawptr, old_size: int, loc := #caller_location) -> (data: []byte, err: runtime.Allocator_Error) {
    ok: bool = true
    size := u32(size)

    realloc_proc :: #type proc "c" (ptr: rawptr, size: u32) -> [^]byte
    realloc := realloc_proc(allocator_data)

    switch mode {
        case .Alloc, .Alloc_Non_Zeroed:
            ptr := realloc(nil, u32(size))
            if ptr == nil {
                err = .Out_Of_Memory
                data = nil
            } else {
                err = .None
                data = ptr[:size]
            }
        
        case .Free:
            _ = realloc(old_memory, 0)

        case .Free_All:
            return nil, .Mode_Not_Implemented

        case .Resize_Non_Zeroed:
            fallthrough
        case .Resize:
            ptr := realloc(old_memory, u32(size))
            if ptr == nil {
                err = .Out_Of_Memory
                data = nil
            } else {
                err = .None
                data = ptr[:size]
            }

        case .Query_Features: 
            set := (^runtime.Allocator_Mode_Set)(old_memory)
            if set != nil {
                set^ = {.Alloc, .Alloc_Non_Zeroed, .Free, .Resize, .Query_Features}
            }

        case .Query_Info: 
            return nil, .Mode_Not_Implemented
    }

    return
}


playdate_logger_proc :: proc(logger_data: rawptr, level: runtime.Logger_Level, text: string, options: runtime.Logger_Options, location := #caller_location) {
    system := (^Api_System_Procs)(logger_data)
    
    sb_backing: [1024]byte
    buf := strings.builder_from_bytes(sb_backing[:len(sb_backing) - 1]) // backing is safe for string -> cstring alias

    if .Level in options {
        // [DEBUG] 
        fmt.sbprint(&buf, _Level_Headers[uint(level) / 10])
    }

    if log.Full_Timestamp_Opts & options != nil {
        fmt.sbprint(&buf, "[")
        sec       := system.get_seconds_since_epoch(nil)
        date_time :  Date_Time
        system.convert_epoch_to_date_time(sec, &date_time)
        if .Date in options { fmt.sbprintf(&buf, "%d-%02d-%02d ", date_time.year, date_time.month, date_time.day)}
        if .Time in options { fmt.sbprintf(&buf, "%02d:%02d:%02d", date_time.hour, date_time.minute, date_time.second)}
        fmt.sbprintf(&buf, "] ")
    }

    log.do_location_header(options, &buf, location)

    fmt.sbprintf(&buf, "%v", text)

    output_cstr := strings.unsafe_string_to_cstring(strings.to_string(buf)) // backing has null byte

    switch level {
        case .Debug, .Info, .Warning: 
            system.log_to_console(output_cstr)
        case .Error, .Fatal:
            system.error(output_cstr)
    }
}


playdate_assertion_failure_proc :: proc (prefix, message: string, loc: runtime.Source_Code_Location) -> ! {
    buffer: [1024]byte
    sb := strings.builder_from_bytes(buffer[:])

    fmt.sbprintf(&sb, "%s(%d:%d) %s", loc.file_path, loc.line, loc.column, prefix)
    
    if len(message) > 0 {
        fmt.sbprintf(&sb, ": %s", message)
    }

    log.fatal(strings.to_string(sb))
    runtime.trap()
}
