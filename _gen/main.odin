package playdate_bindings_generator

import "core:fmt"
import "core:strings"
import "core:slice"
import "core:os"
import "core:c"

headers_to_read :: []string {
    "pd_api_display.h",
    // "pd_api_file.h",
    // "pd_api_gfx.h",
    // "pd_api_json.h",
    // "pd_api_lua.h",
    // "pd_api_scoreboards.h",
    // "pd_api_sound.h",
    // "pd_api_sprite.h",
    // "pd_api_sys.h",
}

// ==================================================

convert_type :: proc(c_type: string) -> (odin_type: string) {
    table := map[string]string {
        "int"           = "c.int",
        "unsigned int"  = "c.uint",
    
        "int8_t"        = "i8",
        "int16_t"       = "i16",
        "int32_t"       = "i32",
        "int64_t"       = "i64",

        "uint8_t"       = "u8",
        "uint16_t"      = "u16",
        "uint32_t"      = "u32",
        "uint64_t"      = "u64",

        "const char*"   = "[^]u8",
    }

    if c_type in table {
        return table[c_type]
    }

    if c_type == "" {
        return c_type
    }

// TODO: finish this

    return c_type
}

parse_typedefs :: proc(src: string) -> (odin_types: string) {
    
}

parse_api_struct :: proc(src: string) -> (odin_proc_pointers: string) {
    struct_begin := strings.index(src, "struct playdate_")

    // ret (* name ) ( arg_type arg_name , );
    // return value
    // proc name
    // args
}

// ==================================================

main :: proc() {
    fmt.println("Playdate bindings generator");

    ok: bool

    for filename in headers_to_read {
        src, ok := os.read_entire_file_from_filename(filename);
        if !ok { 
            fmt.eprintln("Error reading file:", filename)
            return
        }

        
    }
}
