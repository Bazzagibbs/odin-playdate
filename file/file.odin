package playdate_file

// import "core:c"
// import "../common"
// import ".."
//
// File                :: common.File_File
// EOF                 :: common.File_EOF
// Result              :: common.File_Result
// Open_Modes          :: common.File_Open_Modes
// Open_Mode           :: common.File_Open_Mode
// Stat                :: common.File_Stat
//
// // * `set`: Seek from beginning of file
// // * `cur`: Seek from current position
// // * `end`: Set file pointer to EOF plus "offset"    
// Seek_Mode           :: common.File_Seek_Mode
// List_Files_Callback :: common.File_List_Files_Callback
//
// // =================================================================
//
//
// // Returns human-readable text describing the most recent error (usually indicated by a `res == .error` return from a filesystem function).
// get_error  : common.Proc_File_Get_Error
//
// // Calls the given callback function for every file at path. 
// //
// // Subfolders are indicated by a trailing slash '/' in filename. 
// //
// // `list_files()` does not recurse into subfolders. 
// // 
// // If `show_hidden` is true, files beginning with a period will be included; otherwise, they are skipped. 
// // 
// // Returns false if no folder exists at `path` or it can't be opened.
// list_files : common.Proc_File_List_Files
//
// // Populates the struct `file_stat` with information about the file at path.
// stat       : common.Proc_File_Stat
//
// // Creates the given path in the Data/<gameid> folder. It does not create intermediate folders. 
// mkdir      : common.Proc_File_Mkdir
//
// // Deletes the file at `path`. 
// //
// // If `recursive` is true and the target path is a folder, this deletes everything inside the folder 
// // (including folders, folders inside those, and so on) as well as the folder itself.
// unlink     : common.Proc_File_Unlink
//
// // Renames the file at `from` to `to`. It will overwrite the file at to without confirmation. It does not create intermediate folders. 
// rename     : common.Proc_File_Rename
//
// // Opens a handle for the file at path. 
// //
// // The `.read` mode opens a file in the game pdx, while `.read_data` searches the game’s data folder; 
// // to search the data folder first then fall back on the game pdx, use the bit set combination `{.read, .read_data}`. 
// //
// // `.write` and `.append` always write to the data folder. `file` will return nil if a file at path cannot be opened, and `file.get_err()` will describe the error. 
// //
// // The filesystem has a limit of 64 simultaneous open files.
// open       : common.Proc_File_Open
//
// // Closes the given file handle. 
// close      : common.Proc_File_Close
//
// // Reads bytes from the file into the specified buffer, up to the length of the buffer. 
// //
// // Returns the number of bytes read (0 indicating end of file), or -1 in case of error.
// read       : common.Proc_File_Read
//
//
// // Writes the buffer of bytes buf to the file. 
// //
// // Returns the number of bytes written, or -1 in case of error.
// write      : common.Proc_File_Write
//
// // Flushes the output buffer of file immediately. 
// //
// // Returns the number of bytes written, or -1 in case of error.
// flush      : common.Proc_File_Flush
//
// // Returns the current read/write offset in the given file handle, or -1 on error.
// tell       : common.Proc_File_Tell
//
// // Sets the read/write offset in the given file handle to `position`, relative to the `whence` seek mode. 
// //
// // * `.set` is relative to the beginning of the file.
// // * `.cur` is relative to the current position of the file pointer.
// // * `.end` is relative to the end of the file.  
// seek       : common.Proc_File_Seek
//
//
//
// // =================================================================
