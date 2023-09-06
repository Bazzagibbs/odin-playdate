package playdate_file

Proc_Get_Error  :: proc "c" () -> cstring

Proc_List_Files :: proc "c" (path: cstring,	callback: List_Files_Callback, userdata: rawptr, show_hidden: i32) -> i32
Proc_Stat       :: proc "c" (path: cstring, file_stat: ^Stat) -> i32
Proc_Mkdir      :: proc "c" (path: cstring) -> i32
Proc_Unlink     :: proc "c" (name: cstring, recursive: i32) -> i32
Proc_Rename     :: proc "c" (from, to: cstring) -> i32

Proc_Open       :: proc "c" (name: cstring, open_mode: Open_Modes) -> ^File
Proc_Close      :: proc "c" (file: ^File) -> i32
Proc_Read       :: proc "c" (file: ^File, buf: rawptr, len: u32) -> i32
Proc_Write      :: proc "c" (file: ^File, buf: rawptr, len: u32) -> i32
Proc_Flush      :: proc "c" (file: ^File) -> i32
Proc_Tell       :: proc "c" (file: ^File) -> i32
Proc_Seek       :: proc "c" (file: ^File, pos, whence: i32) -> i32

vtable: ^VTable

VTable :: struct {
    get_error  : Proc_Get_Error,

	list_files : Proc_List_Files,
	stat       : Proc_Stat,
	mkdir      : Proc_Mkdir,
	unlink     : Proc_Unlink,
	rename     : Proc_Rename,
	
    open       : Proc_Open,
	close      : Proc_Close,
	read       : Proc_Read,
	write      : Proc_Write,
	flush      : Proc_Flush,
	tell       : Proc_Tell,
	seek       : Proc_Seek,
}
