package playdate_system

import "core:runtime"
import "core:strings"
import "core:fmt"
import "core:log"

@(private)
_Level_Headers := [?]string{
    0 = "[DEBUG] ",
    1 = "[INFO ] ",
    2 = "[WARN ] ",
    3 = "[ERROR] ",
    4 = "[FATAL] ",
}

_playdate_logger_proc :: proc(logger_data: rawptr, level: runtime.Logger_Level, text: string, options: runtime.Logger_Options, location := #caller_location) {
    text_cstr := strings.clone_to_cstring(text)
    defer delete(text_cstr)

    header_backing: [256]byte
    buf := strings.builder_from_bytes(header_backing[:])

    if .Level in options {
        // [DEBUG] 
        fmt.sbprint(&buf, _Level_Headers[uint(level) / 10])
    }

    if log.Full_Timestamp_Opts & options != nil {
        fmt.sbprint(&buf, "[")
        sec, _ := get_seconds_since_epoch()
        date_time := convert_epoch_to_date_time(sec)
        if .Date in options { fmt.sbprintf(&buf, "%d-%02d-%02d ", date_time.year, date_time.month, date_time.day)}
        if .Time in options { fmt.sbprintf(&buf, "%02d:%02d:%02d", date_time.hour, date_time.minute, date_time.second)}
        fmt.sbprintf(&buf, "] ")
    }

    log.do_location_header(options, &buf, location)

    header_str := strings.to_string(buf) 
    header_cstr := strings.clone_to_cstring(header_str)
    defer delete(header_cstr)

    switch level {
        case .Debug, .Info, .Warning: 
            log_to_console("%v%v", header_cstr, text_cstr)
        case .Error, .Fatal:
            error(text_cstr)
    }
}

