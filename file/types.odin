package playdate_file

File :: distinct rawptr

EOF :: 0

Open_Modes :: bit_set[Open_Mode; u32]

Open_Mode :: enum {
    read       = 0,
    read_data  = 1,
    write      = 2,
    append     = 3,
}

Stat :: struct {
    is_directory                            : b32,
    size                                    : u32,
    year, month, day, hour, minute, second  : i32,
}

// * `set`: Seek from beginning of file
// * `cur`: Seek from current position
// * `end`: Set file pointer to EOF plus "offset"    
Seek_Mode :: enum {
    set = 0,
    cur = 1, 
    end = 2,
}

List_Files_Callback :: proc(path: cstring, user_data: rawptr) 
