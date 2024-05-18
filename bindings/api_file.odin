package playdate_bindings

import "core:c"

File_File :: distinct rawptr

File_EOF :: 0

File_Result :: enum c.int {
    ok      = 0,
    error   = -1,
}

File_Open_Modes :: bit_set[File_Open_Mode; u32]

File_Open_Mode :: enum u32 {
    read       = 0,
    read_data  = 1,
    write      = 2,
    append     = 3,
}

File_Stat :: struct {
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
File_Seek_Mode :: enum u32 {
    set = 0,
    cur = 1, 
    end = 2,
}

File_List_Files_Callback :: #type proc "c" (path: cstring, user_data: rawptr) 

// =================================================================

Api_File_Procs :: struct {
    get_error  : proc "c" () -> [^]u8,
    list_files : proc "c" (path: cstring, callback: File_List_Files_Callback, userdata: rawptr, show_hidden: b32) -> (res: File_Result),
    stat       : proc "c" (path: cstring, file_stat: ^File_Stat) -> (res: File_Result),
    mkdir      : proc "c" (path: cstring) -> (res: File_Result),
    unlink     : proc "c" (name: cstring, recursive: b32) -> (res: File_Result),
    rename     : proc "c" (from, to: cstring) -> (res: File_Result),

    open       : proc "c" (name: cstring, mode: File_Open_Modes) -> (file: ^File_File),
    close      : proc "c" (file: ^File_File) -> (res: File_Result),
    read       : proc "c" (file: ^File_File, buffer: []byte) -> (bytes_read: c.int),
    write      : proc "c" (file: ^File_File, buffer: []byte) -> (bytes_written: c.int),
    flush      : proc "c" (file: ^File_File) -> (bytes_written: c.int),
    tell       : proc "c" (file: ^File_File) -> (current_offset: c.int),
    seek       : proc "c" (file: ^File_File, position: c.int, whence: File_Seek_Mode) -> (res: File_Result),
}

// =================================================================

