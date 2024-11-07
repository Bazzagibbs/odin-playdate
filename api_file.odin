package playdate

import "core:c"

File :: distinct Opaque_Struct

EOF :: 0

File_Result :: enum c.int {
    Ok      = 0,
    Error   = -1,
}

Open_Modes :: bit_set[Open_Mode; u32]

Open_Mode :: enum u32 {
    Read       = 0,
    Read_Data  = 1,
    Write      = 2,
    Append     = 3,
}

Stat :: struct {
    is_directory : b32,
    size         : u32,
    year         : i32, 
    month        : i32, 
    day          : i32, 
    hour         : i32, 
    minute       : i32, 
    second       : i32,
}

// * `set`: Seek from beginning of file
// * `cur`: Seek from current position
// * `end`: Set file pointer to EOF plus "offset"    
Seek_Mode :: enum u32 {
    Set = 0,
    Cur = 1, 
    End = 2,
}

List_Files_Callback :: #type proc "c" (path: cstring, user_data: rawptr) 

// =================================================================

Api_File_Procs :: struct {
    get_error  : proc "c" () -> [^]u8,
    list_files : proc "c" (path: cstring, callback: List_Files_Callback, userdata: rawptr, show_hidden: b32) -> (res: File_Result),
    stat       : proc "c" (path: cstring, file_stat: ^Stat) -> (res: File_Result),
    mkdir      : proc "c" (path: cstring) -> (res: File_Result),
    unlink     : proc "c" (name: cstring, recursive: b32) -> (res: File_Result),
    rename     : proc "c" (from, to: cstring) -> (res: File_Result),

    open       : proc "c" (name: cstring, mode: Open_Modes) -> (file: ^File),
    close      : proc "c" (file: ^File) -> (res: File_Result),
    read       : proc "c" (file: ^File, buffer: [^]byte, length: u32) -> (bytes_read: c.int),
    write      : proc "c" (file: ^File, buffer: [^]byte, length: u32) -> (bytes_written: c.int),
    flush      : proc "c" (file: ^File) -> (bytes_written: c.int),
    tell       : proc "c" (file: ^File) -> (current_offset: c.int),
    seek       : proc "c" (file: ^File, position: c.int, whence: Seek_Mode) -> (res: File_Result),
}

// =================================================================

