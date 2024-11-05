package playdate_bindings

Sys_Buttons :: bit_set[Sys_Button; u32]

Sys_Button :: enum {
    left    = 0,
    right   = 1,
    up      = 2,
    down    = 3,
    b       = 4,
    a       = 5,
}

Sys_Language :: enum {
    english,
    japanese,
    unknown,
}

Sys_Date_Time :: struct {
    year    : u16,
    month   : u8, // [1, 12]
    day     : u8, // [1, 31]
    weekday : u8, // [1 = monday, 7 = sunday]
    hour    : u8,
    minute  : u8,
    second  : u8,
}

Sys_Menu_Item :: distinct rawptr

Sys_Peripherals :: bit_set[Sys_Peripheral; u32]

Sys_Peripheral :: enum u16 {
    accelerometer   = 0,
}

Sys_Result :: enum i32 {
    ok    = 0,
    error = 1,
}

Sys_Callback_Proc                :: #type proc "c" (userdata: rawptr) -> Sys_Result
Sys_Menu_Item_Callback_Proc      :: #type proc "c" (userdata: rawptr)
Sys_Button_Callback_Proc         :: #type proc "c" (button: Sys_Buttons, down: b32, _when: u32, user_data: rawptr) -> i32
Sys_Serial_Message_Callback_Proc :: #type proc "c" (userdata: rawptr)

VA_List                          :: distinct cstring // not sure if this is correct

// =================================================================


//   ////////////////
//  // PROC TYPES //
// ////////////////
Api_System_Procs :: struct {
    realloc                        : proc "c" (ptr: rawptr, size: u32) -> [^]byte,
    format_string                  : proc "c" (ret: ^cstring, fmt: cstring, args: ..any) -> i32,
    log_to_console                 : proc "c" (fmt: cstring, args: ..any),
    error                          : proc "c" (fmt: cstring, args: ..any),
    get_language                   : proc "c" () -> Sys_Language,
    get_current_time_milliseconds  : proc "c" () -> u32,
    get_seconds_since_epoch        : proc "c" (milliseconds: ^u32) -> u32,
    draw_fps                       : proc "c" (x, y: i32),

    set_update_callback            : proc "c" (update: Sys_Callback_Proc, userdata: rawptr),
    get_button_state               : proc "c" (current, pushed, released: ^Sys_Buttons),
    set_peripherals_enabled        : proc "c" (mask: Sys_Peripherals),
    get_accelerometer              : proc "c" (out_x, out_y, out_z: ^f32),

    get_crank_change               : proc "c" () -> f32,
    get_crank_angle                : proc "c" () -> f32,
    is_crank_docked                : proc "c" () -> i32,
    set_crank_sounds_disabled      : proc "c" (flag: i32) -> i32,

    get_flipped                    : proc "c" () -> i32,
    set_auto_lock_disabled         : proc "c" (disable: i32),

    set_menu_image                 : proc "c" (bitmap: Bitmap, x_offset: i32),
    add_menu_item                  : proc "c" (title: cstring, callback: Sys_Menu_Item_Callback_Proc, userdata: rawptr) -> Sys_Menu_Item,
    add_checkmark_menu_item        : proc "c" (title: cstring, value: i32, callback: Sys_Menu_Item_Callback_Proc, userdata: rawptr) -> Sys_Menu_Item,
    add_options_menu_item          : proc "c" (title: cstring, option_titles: [^]cstring, options_count: i32, callback: Sys_Menu_Item_Callback_Proc, userdata: rawptr) -> Sys_Menu_Item,
    remove_all_menu_items          : proc "c" (),
    remove_menu_item               : proc "c" (menu_item: Sys_Menu_Item),
    get_menu_item_value            : proc "c" (menu_item: Sys_Menu_Item) -> i32,
    set_menu_item_value            : proc "c" (menu_item: Sys_Menu_Item, value: i32),
    get_menu_item_title            : proc "c" (menu_item: Sys_Menu_Item) -> cstring,
    set_menu_item_title            : proc "c" (menu_item: Sys_Menu_Item, title: cstring),
    get_menu_item_userdata         : proc "c" (menu_item: Sys_Menu_Item) -> rawptr,
    set_menu_item_userdata         : proc "c" (menu_item: Sys_Menu_Item, userdata: rawptr),

    get_reduce_flashing            : proc "c" () -> i32,

    // 1.1,
    get_elapsed_time               : proc "c" () -> f32,
    reset_elapsed_time             : proc "c" (),

    // 1.4,
    get_battery_percentage         : proc "c" () -> f32,
    get_battery_voltage            : proc "c" () -> f32,

    // 1.13,
    get_timezone_offset            : proc "c" () -> i32,
    should_display_24_hour_time    : proc "c" () -> i32,
    convert_epoch_to_date_time     : proc "c" (epoch: u32, date_time: ^Sys_Date_Time),
    convert_date_time_to_epoch     : proc "c" (date_time: ^Sys_Date_Time) -> u32,

    // 2.0,
    clear_i_cache                  : proc "c" (),

    // 2.4
    set_button_callback            : proc "c" (callback: Sys_Button_Callback_Proc, user_data: rawptr, queue_size: i32),
    set_serial_message_callback    : proc "c" (callback: Sys_Serial_Message_Callback_Proc),
    va_format_string               : proc "c" (out_string: ^cstring, format: cstring, va_list: VA_List) -> i32,
}

// =================================================================
