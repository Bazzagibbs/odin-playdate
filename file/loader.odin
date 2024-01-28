package playdate_file

import "core:c"

//   ////////////////
//  // PROC TYPES //
// ////////////////

Proc_Get_Error  :: #type proc "c" () -> [^]u8 
Proc_List_Files :: #type proc "c" (path: cstring, callback: List_Files_Callback, userdata: rawptr, show_hidden: b32) -> (res: Result) 
Proc_Stat       :: #type proc "c" (path: cstring, file_stat: ^Stat) -> (res: Result)
Proc_Mkdir      :: #type proc "c" (path: cstring) -> (res: Result) 
Proc_Unlink     :: #type proc "c" (name: cstring, recursive: b32) -> (res: Result)
Proc_Rename     :: #type proc "c" (from, to: cstring) -> (res: Result) 
Proc_Open       :: #type proc "c" (name: cstring, mode: Open_Modes) -> (file: ^File) 
Proc_Close      :: #type proc "c" (file: ^File) -> (res: Result)
Proc_Read       :: #type proc "c" (file: ^File, buffer: []byte) -> (bytes_read: c.int) 

Proc_Write      :: #type proc "c" (file: ^File, buffer: []byte) -> (bytes_written: c.int) 
Proc_Flush      :: #type proc "c" (file: ^File) -> (bytes_written: c.int)
Proc_Tell       :: #type proc "c" (file: ^File) -> (current_offset: c.int)
Proc_Seek       :: #type proc "c" (file: ^File, position: c.int, whence: Seek_Mode) -> (res: Result)

// =================================================================


//   ////////////////
//  // API STRUCT //
// ////////////////

Api_Procs :: struct {

}

// =================================================================


//   /////////////////
//  // LOADER PROC //
// /////////////////

_load_procs :: proc(api_procs: ^Api_Procs) {

}
