package playdate_file

import "../bindings"

File                :: bindings.File_File
EOF                 :: bindings.File_EOF
Result              :: bindings.File_Result
Open_Modes          :: bindings.File_Open_Modes
Open_Mode           :: bindings.File_Open_Mode
Stat                :: bindings.File_Stat

// * `set`: Seek from beginning of file
// * `cur`: Seek from current position
// * `end`: Set file pointer to EOF plus "offset"    
Seek_Mode           :: bindings.File_Seek_Mode
List_Files_Callback :: bindings.File_List_Files_Callback

// =================================================================

// :: proc "contextless" () {
// }

// Returns human-readable text describing the most recent error (usually indicated by a `res == .error` return from a filesystem function).
get_error  :: proc "contextless" () -> cstring {
    return cstring(bindings.file.get_error())
}
  
// Calls the given callback function for every file at path. 
//
// Subfolders are indicated by a trailing slash '/' in filename. 
//
// `list_files()` does not recurse into subfolders. 
// 
// If `show_hidden` is true, files beginning with a period will be included; otherwise, they are skipped. 
// 
// Returns .error if no folder exists at `path` or it can't be opened.
list_files :: proc "contextless" (path: cstring, callback: List_Files_Callback, user_data: rawptr, show_hidden: b32) -> Result {
    return bindings.file.list_files(path, callback, user_data, show_hidden)
}

// Returns a struct `Stat` with information about the file at path.
stat :: proc "contextless" (path: cstring) -> (file_stat: Stat, res: Result) { 
    res = bindings.file.stat(path, &file_stat)
    return
}

// Creates the given path in the Data/<gameid> folder. It does not create intermediate folders. 
mkdir :: proc "contextless" (path: cstring) -> Result {
    return bindings.file.mkdir(path)
}

// Deletes the file at `path`. 
//
// If `recursive` is true and the target path is a folder, this deletes everything inside the folder 
// (including folders, folders inside those, and so on) as well as the folder itself.
unlink :: proc "contextless" (path: cstring, recursive: b32) -> Result {
    return bindings.file.unlink(path, recursive)
}

// Renames the file at `from` to `to`. It will overwrite the file at to without confirmation. It does not create intermediate folders. 
rename :: proc "contextless" (from, to: cstring) -> Result {
    return bindings.file.rename(from, to)
}

// Opens a handle for the file at path. 
//
// The `.read` mode opens a file in the game pdx, while `.read_data` searches the game’s data folder; 
// to search the data folder first then fall back on the game pdx, use the bit set combination `{.read, .read_data}`. 
//
// `.write` and `.append` always write to the data folder. `file` will return nil if a file at path cannot be opened, and `file.get_err()` will describe the error. 
//
// The filesystem has a limit of 64 simultaneous open files.
open :: proc "contextless" (name: cstring, mode: Open_Modes) -> (file: File) {
    return bindings.file.open(name, mode)
}

// Closes the given file handle. 
close :: proc "contextless" (file: File) -> Result {
    return bindings.file.close(file)
}

// Reads bytes from the file into the specified buffer, up to the length of the buffer. 
//
// Returns the number of bytes read (0 indicating end of file), or -1 in case of error.
read :: proc "contextless" (file: File, buffer: []byte) -> (bytes_read: i32) {
    return bindings.file.read(file, raw_data(buffer), u32(len(buffer)))
}


// Writes a buffer of bytes to the file. 
//
// Returns the number of bytes written, or -1 in case of error.
write :: proc "contextless" (file: File, buffer: []byte) -> (bytes_written: i32) {
    return bindings.file.write(file, raw_data(buffer), u32(len(buffer)))
}

// Flushes the output buffer of file immediately. 
//
// Returns the number of bytes written, or -1 in case of error.
flush :: proc "contextless" (file: File) -> (bytes_written: i32) {
    return bindings.file.flush(file)
}

// Returns the current read/write offset in the given file handle, or -1 on error.
tell :: proc "contextless" (file: File) -> (current_offset: i32) {
    return bindings.file.tell(file)
}

// Sets the read/write offset in the given file handle to `position`, relative to the `whence` seek mode. 
//
// * `.set` is relative to the beginning of the file.
// * `.cur` is relative to the current position of the file pointer.
// * `.end` is relative to the end of the file.  
seek :: proc "contextless" (file: File, position: i32, whence: Seek_Mode) -> Result {
    return bindings.file.seek(file, position, whence)
}


// =================================================================
