package playdate_file

// Returns human-readable text describing the most recent error (usually indicated by a `ok == false` return from a filesystem function).
get_error :: #force_inline proc "c" () -> cstring {
    return vtable.get_error()
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
list_files :: #force_inline proc "c" (path: cstring, callback: List_Files_Callback, userdata: rawptr, show_hidden: bool) -> (ok: bool) {
    return vtable.list_files(path, callback, userdata, i32(show_hidden)) != -1
}

// Populates the struct `file_stat` with information about the file at path.
stat :: #force_inline proc "c" (path: cstring, file_stat: ^Stat) -> (ok: bool) {
    return vtable.stat(path, file_stat) != -1
}

// Creates the given path in the Data/<gameid> folder. It does not create intermediate folders. 
mkdir :: #force_inline proc "c" (path: cstring) -> (ok: bool) {
    return vtable.mkdir(path) != -1
}

// Deletes the file at `path`. 
//
// If `recursive` is true and the target path is a folder, this deletes everything inside the folder 
// (including folders, folders inside those, and so on) as well as the folder itself.
unlink :: #force_inline proc "c" (name: cstring, recursive: bool) -> (ok: bool){
    return vtable.unlink(name, i32(recursive)) != -1
}

// Renames the file at `from` to `to`. It will overwrite the file at to without confirmation. It does not create intermediate folders. 
rename :: #force_inline proc "c" (from, to: cstring) -> (ok: bool) {
    return vtable.rename(from, to) != -1
}

// Opens a handle for the file at path. 
//
// The `.read` mode opens a file in the game pdx, while `.read_data` searches the game’s data folder; 
// to search the data folder first then fall back on the game pdx, use the bit set combination `{.read, .read_data}`. 
//
// `.write` and `.append` always write to the data folder. `ok` will return false if a file at path cannot be opened, and `file.get_err()` will describe the error. 
//
// The filesystem has a limit of 64 simultaneous open files.
open :: #force_inline proc "c" (name: cstring, mode: Open_Modes) -> (file: ^File, ok: bool) {
    file = vtable.open(name, mode)
    return file, file != nil
}

// Closes the given file handle. 
close :: #force_inline proc "c" (file: ^File) -> (ok: bool) {
    return vtable.close(file) != -1
}

// Reads bytes from the file into the specified buffer, up to the length of the buffer. 
//
// If ok, returns the number of bytes read (0 indicating end of file).
read :: #force_inline proc "c" (file: ^File, buffer: []byte) -> (bytes_read: i32, ok: bool) {
    bytes_read = vtable.read(file, raw_data(buffer), u32(len(buffer)))
    return bytes_read, bytes_read != -1
}


// Writes the buffer of bytes buf to the file. 
//
// If ok, returns the number of bytes written
write :: #force_inline proc "c" (file: ^File, buffer: []byte) -> (bytes_written: i32, ok: bool) {
    bytes_written = vtable.write(file, raw_data(buffer), u32(len(buffer)))
    return bytes_written, bytes_written != -1
}

// Flushes the output buffer of file immediately. 
//
// If ok, returns the number of bytes written.
flush :: #force_inline proc "c" (file: ^File) -> (bytes_written: i32, ok: bool) {
    bytes_written = vtable.flush(file)
    return bytes_written, bytes_written != -1
}

// If ok, returns the current read/write offset in the given file handle.
tell :: #force_inline proc "c" (file: ^File) -> (current_offset: i32, ok: bool) {
    current_offset = vtable.tell(file)
    return current_offset, current_offset != -1
}

// Sets the read/write offset in the given file handle to `position`, relative to the `whence` seek mode. 
//
// * `.set` is relative to the beginning of the file.
// * `.cur` is relative to the current position of the file pointer.
// * `.end` is relative to the end of the file.  
seek :: #force_inline proc "c" (file: ^File, position: i32, whence: Seek_Mode) -> (ok: bool){
    return vtable.seek(file, position, i32(whence)) != -1
}
