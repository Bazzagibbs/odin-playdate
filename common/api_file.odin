package playdate_common

import "core:c"

//   ///////////
//  // TYPES //
// ///////////

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
    is_directory                            : b32,
    size                                    : u32,
    year, month, day, hour, minute, second  : i32,
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


//   ////////////////
//  // PROC TYPES //
// ////////////////

Proc_File_Get_Error  :: #type proc "c" () -> [^]u8 
Proc_File_List_Files :: #type proc "c" (path: cstring, callback: File_List_Files_Callback, userdata: rawptr, show_hidden: b32) -> (res: File_Result) 
Proc_File_Stat       :: #type proc "c" (path: cstring, file_stat: ^File_Stat) -> (res: File_Result)
Proc_File_Mkdir      :: #type proc "c" (path: cstring) -> (res: File_Result) 
Proc_File_Unlink     :: #type proc "c" (name: cstring, recursive: b32) -> (res: File_Result)
Proc_File_Rename     :: #type proc "c" (from, to: cstring) -> (res: File_Result) 
Proc_File_Open       :: #type proc "c" (name: cstring, mode: File_Open_Modes) -> (file: ^File_File) 
Proc_File_Close      :: #type proc "c" (file: ^File_File) -> (res: File_Result)
Proc_File_Read       :: #type proc "c" (file: ^File_File, buffer: []byte) -> (bytes_read: c.int) 

Proc_File_Write      :: #type proc "c" (file: ^File_File, buffer: []byte) -> (bytes_written: c.int) 
Proc_File_Flush      :: #type proc "c" (file: ^File_File) -> (bytes_written: c.int)
Proc_File_Tell       :: #type proc "c" (file: ^File_File) -> (current_offset: c.int)
Proc_File_Seek       :: #type proc "c" (file: ^File_File, position: c.int, whence: File_Seek_Mode) -> (res: File_Result)

// =================================================================


//   ////////////////
//  // API STRUCT //
// ////////////////
Api_File_Procs :: struct {
    get_error  : Proc_File_Get_Error,
    list_files : Proc_File_List_Files,
    stat       : Proc_File_Stat,
    mkdir      : Proc_File_Mkdir,
    unlink     : Proc_File_Unlink,
    rename     : Proc_File_Rename,
    open       : Proc_File_Open,
    close      : Proc_File_Close,
    read       : Proc_File_Read,

    write      : Proc_File_Write,
    flush      : Proc_File_Flush,
    tell       : Proc_File_Tell,
    seek       : Proc_File_Seek,
}
