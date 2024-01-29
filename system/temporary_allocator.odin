package playdate_system
import "core:runtime"

TEMP_ALLOCATOR_BACKING_SIZE: uint : #config(PLAYDATE_TEMP_ALLOCATOR_BACKING_SIZE, 1 * runtime.Megabyte)

global_playdate_temp_allocator_data: Playdate_Temp_Allocator


Playdate_Temp_Allocator :: struct {
    arena: runtime.Arena,
}


//   ///////////////////////////
//  // GLOBAL TEMP ALLOCATOR //
// ///////////////////////////

global_playdate_temp_allocator_data_init :: proc (data: ^Playdate_Temp_Allocator, size: uint, backing_allocator := context.allocator) {
    _ = runtime.arena_init(&data.arena, size, backing_allocator)
}

global_playdate_temp_allocator_data_destroy :: proc(data: ^Playdate_Temp_Allocator) {
    runtime.arena_destroy(&data.arena)
}

//   ///////////////////////////
//  // CUSTOM TEMP ALLOCATOR //
// ///////////////////////////

playdate_temp_allocator :: proc "contextless" () -> runtime.Allocator {
    return runtime.Allocator {
        procedure = playdate_temp_allocator_proc,
        data = &global_playdate_temp_allocator,
    }
}

playdate_temp_allocator_proc :: proc(allocator_data: rawptr, mode: runtime.Allocator_Mode, 
                                     size, alignment: int,
                                     old_memory: rawptr, old_size: int, loc := #caller_location) -> (data: []byte, err: runtime.Allocator_Error) {
    s := (^Playdate_Temp_Allocator)(allocator_data)
        return runtime.arena_allocator_proc(&s.arena, mode, size, alignment, old_memory, old_size, loc)
}

