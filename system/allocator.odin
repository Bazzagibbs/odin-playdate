package playdate_system

import "core:runtime"

_playdate_allocator_proc :: proc(allocator_data: rawptr, mode: runtime.Allocator_Mode, 
                        size, alignment: int, 
                        old_memory: rawptr, old_size: int, loc := #caller_location) -> (data: []byte, err: runtime.Allocator_Error) {
    ok: bool = true
    size := u32(size)
    switch mode {
        case .Alloc, .Alloc_Non_Zeroed:
            data, ok = alloc(u32(size))
            err = .None if ok else .Out_Of_Memory
        
        case .Free:
            free(old_memory)

        case .Free_All:
            return nil, .Mode_Not_Implemented

        case .Resize:
            data, ok = realloc(old_memory, size)
            err = .None if ok else .Out_Of_Memory

        case .Query_Features: 
            set := (^runtime.Allocator_Mode_Set)(old_memory)
            if set != nil {
                set^ = {.Alloc, .Alloc_Non_Zeroed, .Free, .Resize, .Query_Features}
            }

        case .Query_Info: 
            return nil, .Mode_Not_Implemented
    }

    return
}


