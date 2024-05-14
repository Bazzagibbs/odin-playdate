package playdate_bindings

import "core:c"

Display_Scale_Flag :: enum u32 {
    _1 = 1,
    _2 = 2,
    _4 = 4,
    _8 = 8,
}

Display_Mosaic_Flag :: enum u32 {
    _0 = 0,
    _1 = 1,
    _2 = 2,
    _3 = 3,
}

// =================================================================

Api_Display_Procs :: struct {
    get_width        : proc "c" () -> c.int, 
    get_height       : proc "c" () -> c.int,
    set_refresh_rate : proc "c" (rate: f32),
    set_inverted     : proc "c" (inverted: b32),
    set_scale        : proc "c" (scale: Display_Scale_Flag),
    set_mosaic       : proc "c" (x, y: Display_Mosaic_Flag),
    set_flipped      : proc "c" (x_flipped, y_flipped: b32),
    set_offset       : proc "c" (x, y: c.int),
}

// =================================================================
