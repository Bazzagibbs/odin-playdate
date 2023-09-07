package playdate_system

Buttons :: bit_set[Button; u32]

Button :: enum {
    left    = 0,
    right   = 1,
    up      = 2,
    down    = 3,
    b       = 4,
    a       = 5,
}

Language :: enum {
    english,
    japanese,
    unknown,
}

Date_Time :: struct {
    year    : u16,
    month   : u8, // [1, 12]
    day     : u8, // [1, 31]
    weekday : u8, // [1 = monday, 7 = sunday]
    hour    : u8,
    minute  : u8,
    second  : u8,
}

Menu_Item :: distinct rawptr

Peripherals :: bit_set[Peripheral; u32]

Peripheral :: enum u16 {
    accelerometer   = 0,
}

Callback_Proc :: #type proc "odin" () -> (should_update_display: bool)

Menu_Item_Callback_Proc :: #type proc "c" (user_ptr: rawptr)
