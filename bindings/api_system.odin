package playdate_bindings

//   ///////////
//  // TYPES //
// ///////////

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

Sys_Callback_Proc :: #type proc "c" (userdata: rawptr) -> Sys_Result

Sys_Menu_Item_Callback_Proc :: #type proc "c" (userdata: rawptr)

// =================================================================


//   ////////////////
//  // PROC TYPES //
// ////////////////

Proc_Sys_Realloc                        :: #type proc "c" (ptr: rawptr, size: u32) -> [^]byte
Proc_Sys_Format_String                  :: #type proc "c" (ret: ^cstring, fmt: cstring, args: ..any) -> i32
Proc_Sys_Log_To_Console                 :: #type proc "c" (fmt: cstring, args: ..any)
Proc_Sys_Error                          :: #type proc "c" (fmt: cstring, args: ..any)
Proc_Sys_Get_Language                   :: #type proc "c" () -> Sys_Language
Proc_Sys_Get_Current_Time_Milliseconds  :: #type proc "c" () -> u32
Proc_Sys_Get_Seconds_Since_Epoch        :: #type proc "c" (milliseconds: ^u32) -> u32
Proc_Sys_Draw_FPS                       :: #type proc "c" (x, y: i32)

Proc_Sys_Set_Update_Callback            :: #type proc "c" (update: Proc_Sys_Callback_Internal, userdata: rawptr)
Proc_Sys_Get_Button_State               :: #type proc "c" (current, pushed, released: ^Sys_Buttons)
Proc_Sys_Set_Peripherals_Enabled        :: #type proc "c" (mask: Sys_Peripherals)
Proc_Sys_Get_Accelerometer              :: #type proc "c" (out_x, out_y, out_z: ^f32)

Proc_Sys_Get_Crank_Change               :: #type proc "c" () -> f32
Proc_Sys_Get_Crank_Angle                :: #type proc "c" () -> f32
Proc_Sys_Is_Crank_Docked                :: #type proc "c" () -> i32
Proc_Sys_Set_Crank_Sounds_Disabled      :: #type proc "c" (flag: i32) -> i32

Proc_Sys_Get_Flipped                    :: #type proc "c" () -> i32
Proc_Sys_Set_Auto_Lock_Disabled         :: #type proc "c" (disable: i32)

Proc_Sys_Set_Menu_Image                 :: #type proc "c" (bitmap: Bitmap, x_offset: i32)
Proc_Sys_Add_Menu_Item                  :: #type proc "c" (title: cstring, callback: Proc_Sys_Menu_Item_Callback_Internal, userdata: rawptr) -> Sys_Menu_Item
Proc_Sys_Add_Checkmark_Menu_Item        :: #type proc "c" (title: cstring, value: i32, callback: Proc_Sys_Menu_Item_Callback_Internal, userdata: rawptr) -> Sys_Menu_Item
Proc_Sys_Add_Options_Menu_Item          :: #type proc "c" (title: cstring, option_titles: [^]cstring, options_count: i32, callback: Proc_Sys_Menu_Item_Callback_Internal, userdata: rawptr) -> Sys_Menu_Item
Proc_Sys_Remove_All_Menu_Items          :: #type proc "c" ()
Proc_Sys_Remove_Menu_Item               :: #type proc "c" (menu_item: Sys_Menu_Item)
Proc_Sys_Get_Menu_Item_Value            :: #type proc "c" (menu_item: Sys_Menu_Item) -> i32
Proc_Sys_Set_Menu_Item_Value            :: #type proc "c" (menu_item: Sys_Menu_Item, value: i32)
Proc_Sys_Get_Menu_Item_Title            :: #type proc "c" (menu_item: Sys_Menu_Item) -> cstring
Proc_Sys_Set_Menu_Item_Title            :: #type proc "c" (menu_item: Sys_Menu_Item, title: cstring)
Proc_Sys_Get_Menu_Item_Userdata         :: #type proc "c" (menu_item: Sys_Menu_Item) -> rawptr
Proc_Sys_Set_Menu_Item_Userdata         :: #type proc "c" (menu_item: Sys_Menu_Item, userdata: rawptr)

Proc_Sys_Get_Reduce_Flashing            :: #type proc "c" () -> i32

// 1.1
Proc_Sys_Get_Elapsed_Time               :: #type proc "c" () -> f32
Proc_Sys_Reset_Elapsed_Time             :: #type proc "c" ()

// 1.4
Proc_Sys_Get_Battery_Percentage         :: #type proc "c" () -> f32
Proc_Sys_Get_Battery_Voltage            :: #type proc "c" () -> f32

// 1.13
Proc_Sys_Get_Timezone_Offset            :: #type proc "c" () -> i32
Proc_Sys_Should_Display_24_Hour_Time    :: #type proc "c" () -> i32
Proc_Sys_Convert_Epoch_To_Date_Time     :: #type proc "c" (epoch: u32, date_time: ^Sys_Date_Time)
Proc_Sys_Convert_Date_Time_To_Epoch     :: #type proc "c" (date_time: ^Sys_Date_Time) -> u32

// 2.0
Proc_Sys_Clear_I_Cache                  :: #type proc "c" ()


Proc_Sys_Callback_Internal              :: #type proc "c" (userdata: rawptr) -> i32
Proc_Sys_Menu_Item_Callback_Internal    :: #type proc "c" (userdata: rawptr)

// =================================================================


//   ////////////////
//  // API STRUCT //
// ////////////////

Api_System_Procs :: struct {
    realloc                        : Proc_Sys_Realloc,
    format_string                  : Proc_Sys_Format_String,
    log_to_console                 : Proc_Sys_Log_To_Console,
    error                          : Proc_Sys_Error,
    get_language                   : Proc_Sys_Get_Language,
    get_current_time_milliseconds  : Proc_Sys_Get_Current_Time_Milliseconds,
    get_seconds_since_epoch        : Proc_Sys_Get_Seconds_Since_Epoch,
    draw_fps                       : Proc_Sys_Draw_FPS,

    set_update_callback            : Proc_Sys_Set_Update_Callback,
    get_button_state               : Proc_Sys_Get_Button_State,
    set_peripherals_enabled        : Proc_Sys_Set_Peripherals_Enabled,
    get_accelerometer              : Proc_Sys_Get_Accelerometer,

    get_crank_change               : Proc_Sys_Get_Crank_Change,
    get_crank_angle                : Proc_Sys_Get_Crank_Angle,
    is_crank_docked                : Proc_Sys_Is_Crank_Docked,
    set_crank_sounds_disabled      : Proc_Sys_Set_Crank_Sounds_Disabled,

    get_flipped                    : Proc_Sys_Get_Flipped,
    set_auto_lock_disabled         : Proc_Sys_Set_Auto_Lock_Disabled,

    set_menu_image                 : Proc_Sys_Set_Menu_Image,
    add_menu_item                  : Proc_Sys_Add_Menu_Item,
    add_checkmark_menu_item        : Proc_Sys_Add_Checkmark_Menu_Item,
    add_options_menu_item          : Proc_Sys_Add_Options_Menu_Item,
    remove_all_menu_items          : Proc_Sys_Remove_All_Menu_Items,
    remove_menu_item               : Proc_Sys_Remove_Menu_Item,
    get_menu_item_value            : Proc_Sys_Get_Menu_Item_Value,
    set_menu_item_value            : Proc_Sys_Set_Menu_Item_Value,
    get_menu_item_title            : Proc_Sys_Get_Menu_Item_Title,
    set_menu_item_title            : Proc_Sys_Set_Menu_Item_Title,
    get_menu_item_userdata         : Proc_Sys_Get_Menu_Item_Userdata,
    set_menu_item_userdata         : Proc_Sys_Set_Menu_Item_Userdata,

    get_reduce_flashing            : Proc_Sys_Get_Reduce_Flashing,

    // 1.1
    get_elapsed_time               : Proc_Sys_Get_Elapsed_Time,
    reset_elapsed_time             : Proc_Sys_Reset_Elapsed_Time,

    // 1.4
    get_battery_percentage         : Proc_Sys_Get_Battery_Percentage,
    get_battery_voltage            : Proc_Sys_Get_Battery_Voltage,

    // 1.13
    get_timezone_offset            : Proc_Sys_Get_Timezone_Offset,
    should_display_24_hour_time    : Proc_Sys_Should_Display_24_Hour_Time,
    convert_epoch_to_date_time     : Proc_Sys_Convert_Epoch_To_Date_Time,
    convert_date_time_to_epoch     : Proc_Sys_Convert_Date_Time_To_Epoch,

    // 2.0
    clear_i_cache                  : Proc_Sys_Clear_I_Cache,
}

