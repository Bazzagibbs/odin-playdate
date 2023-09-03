package playdate_file

// Returns human-readable text describing the most recent error (usually indicated by a `ok == false` return from a filesystem function).
get_error :: proc() -> cstring {
    panic("Not implemented")
}

// Calls the given callback function for every file at path. 
//
// Subfolders are indicated by a trailing slash '/' in filename. 
//
// `list_files()` does not recurse into subfolders. 
// 
// If `show_hidden` is true, files beginning with a period will be included; otherwise, they are skipped. 
// 
// Returns false if no folder exists at `path` or it can't be opened.
list_files :: proc(path: cstring, callback: List_Files_Callback, user_data: rawptr, show_hidden: bool) -> (ok: bool) {
    panic("Not implemented")
}

// Populates the struct `file_stat` with information about the file at path.
stat :: proc(path: cstring, file_stat: ^Stat) -> (ok: bool) {
    panic("Not implemented")
}

// Creates the given path in the Data/<gameid> folder. It does not create intermediate folders. 
mkdir :: proc(path: cstring) -> (ok: bool) {
    panic("Not implemented")
}

// Deletes the file at `path`. 
//
// If `recursive` is true and the target path is a folder, this deletes everything inside the folder 
// (including folders, folders inside those, and so on) as well as the folder itself.
unlink :: proc(name: cstring, recursive: bool) -> (ok: bool){
    panic("Not implemented")
}

// Renames the file at `from` to `to`. It will overwrite the file at to without confirmation. It does not create intermediate folders. 
rename :: proc(from, to: cstring) -> (ok: bool) {
    panic("Not implemented")
}

// Opens a handle for the file at path. 
//
// The `.read` mode opens a file in the game pdx, while `.read_data` searches the game’s data folder; 
// to search the data folder first then fall back on the game pdx, use the bit set combination `{.read, .read_data}`. 
//
// `.write` and `.append` always write to the data folder. `ok` will return false if a file at path cannot be opened, and `file.get_err()` will describe the error. 
//
// The filesystem has a limit of 64 simultaneous open files.
open :: proc(name: cstring, mode: Open_Modes) -> (file: ^File, ok: bool) {
    panic("Not implemented")
}

// Closes the given file handle. 
close :: proc(file: ^File) -> (ok: bool) {
    panic("Not implemented")
}

// Reads bytes from the file into the specified buffer, up to the length of the buffer. 
//
// If ok, returns the number of bytes read (0 indicating end of file).
read :: proc(file: ^File, buffer: []byte) -> (bytes_read: i32, ok: bool) {
    panic("Not implemented")
}


// Writes the buffer of bytes buf to the file. 
//
// If ok, returns the number of bytes written
write :: proc(file: ^File, buffer: []byte) -> i32 {
    panic("Not implemented")
}

// Flushes the output buffer of file immediately. 
//
// If ok, returns the number of bytes written.
flush :: proc(file: ^File) -> (bytes_written: i32, ok: bool) {
    panic("Not implemented")
}

// If ok, returns the current read/write offset in the given file handle.
tell :: proc(file: ^File) -> (current_offset: i32, ok: bool) {
    panic("Not implemented")
}

// Sets the read/write offset in the given file handle to `position`, relative to the `whence` seek mode. 
//
// * `.set` is relative to the beginning of the file.
// * `.cur` is relative to the current position of the file pointer.
// * `.end` is relative to the end of the file.  
seek :: proc(file: ^File, position: i32, whence: Seek_Mode) -> (ok: bool){
    panic("Not implemented")
}
