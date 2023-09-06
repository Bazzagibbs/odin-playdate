package playdate_system

import "core:c"
import gfx "../graphics"

Proc_Realloc                        :: #type proc "c" (ptr: rawptr, size: u32) -> [^]byte
Proc_Format_String                  :: #type proc "c" (ret: ^cstring, fmt: cstring, args: ..any) -> i32
Proc_Log_To_Console                 :: #type proc "c" (fmt: cstring, args: ..any)
Proc_Error                          :: #type proc "c" (fmt: cstring, args: ..any)
Proc_Get_Language                   :: #type proc "c" () -> Language
Proc_Get_Current_Time_Milliseconds  :: #type proc "c" () -> u32
Proc_Get_Seconds_Since_Epoch        :: #type proc "c" (milliseconds: ^u32) -> u32
Proc_Draw_FPS                       :: #type proc "c" (x, y: i32)

Proc_Set_Update_Callback        :: #type proc "c" (update: Proc_Callback_Internal, userdata: rawptr)
Proc_Get_Button_State           :: #type proc "c" (current, pushed, released: ^Buttons)
Proc_Set_Peripherals_Enabled    :: #type proc "c" (mask: Peripherals)
Proc_Get_Accelerometer          :: #type proc "c" (out_x, out_y, out_z: ^f32)

Proc_Get_Crank_Change           :: #type proc "c" () -> f32
Proc_Get_Crank_Angle            :: #type proc "c" () -> f32
Proc_Is_Crank_Docked            :: #type proc "c" () -> i32
Proc_Set_Crank_Sounds_Disabled  :: #type proc "c" (flag: i32) -> i32

Proc_Get_Flipped            :: #type proc "c" () -> i32
Proc_Set_Auto_Lock_Disabled :: #type proc "c" (disable: i32)

Proc_Set_Menu_Image             :: #type proc "c" (bitmap: gfx.Bitmap, x_offset: i32)
Proc_Add_Menu_Item              :: #type proc "c" (title: cstring, callback: Proc_Menu_Item_Callback_Internal, userdata: rawptr) -> Menu_Item
Proc_Add_Checkmark_Menu_Item    :: #type proc "c" (title: cstring, value: i32, callback: Proc_Menu_Item_Callback_Internal, userdata: rawptr) -> Menu_Item
Proc_Add_Options_Menu_Item      :: #type proc "c" (title: cstring, option_titles: [^]cstring, options_count: i32, callback: Proc_Menu_Item_Callback_Internal, userdata: rawptr) -> Menu_Item
Proc_Remove_All_Menu_Items      :: #type proc "c" ()
Proc_Remove_Menu_Item           :: #type proc "c" (menu_item: Menu_Item)
Proc_Get_Menu_Item_Value        :: #type proc "c" (menu_item: Menu_Item) -> i32
Proc_Set_Menu_Item_Value        :: #type proc "c" (menu_item: Menu_Item, value: i32)
Proc_Get_Menu_Item_Title        :: #type proc "c" (menu_item: Menu_Item) -> cstring
Proc_Set_Menu_Item_Title        :: #type proc "c" (menu_item: Menu_Item, title: cstring)
Proc_Get_Menu_Item_Userdata     :: #type proc "c" (menu_item: Menu_Item) -> rawptr
Proc_Set_Menu_Item_Userdata     :: #type proc "c" (menu_item: Menu_Item, userdata: rawptr)

Proc_Get_Reduce_Flashing :: #type proc "c" () -> i32

// 1.1
Proc_Get_Elapsed_Time   :: #type proc "c" () -> f32
Proc_Reset_Elapsed_Time :: #type proc "c" ()

// 1.4
Proc_Get_Battery_Percentage :: #type proc "c" () -> f32
Proc_Get_Battery_Voltage    :: #type proc "c" () -> f32

// 1.13
Proc_Get_Timezone_Offset            :: #type proc "c" () -> i32
Proc_Should_Display_24_Hour_Time    :: #type proc "c" () -> i32
Proc_Convert_Epoch_To_Date_Time     :: #type proc "c" (epoch: u32, date_time: ^Date_Time)
Proc_Convert_Date_Time_To_Epoch     :: #type proc "c" (date_time: ^Date_Time) -> u32

// 2.0
Proc_Clear_I_Cache :: #type proc "c" ()


Proc_Callback_Internal              :: #type proc "c" (userdata: rawptr) -> i32
Proc_Menu_Item_Callback_Internal    :: #type proc "c" (userdata: rawptr)

vtable: ^VTable

VTable :: struct {
    realloc                         : Proc_Realloc,
    format_string                   : Proc_Format_String,
    log_to_console                  : Proc_Log_To_Console,
    error                           : Proc_Error,
    get_language                    : Proc_Get_Language,
    get_current_time_milliseconds   : Proc_Get_Current_Time_Milliseconds,
    get_seconds_since_epoch         : Proc_Get_Seconds_Since_Epoch,
    draw_fps                        : Proc_Draw_FPS,

    set_update_callback             : Proc_Set_Update_Callback,
    get_button_state                : Proc_Get_Button_State,
    set_peripherals_enabled         : Proc_Set_Peripherals_Enabled,
    get_accelerometer               : Proc_Get_Accelerometer,

    get_crank_change                : Proc_Get_Crank_Change,
    get_crank_angle                 : Proc_Get_Crank_Angle,
    is_crank_docked                 : Proc_Is_Crank_Docked,
    set_crank_sounds_disabled       : Proc_Set_Crank_Sounds_Disabled,

    get_flipped                     : Proc_Get_Flipped,
    set_auto_lock_disabled          : Proc_Set_Auto_Lock_Disabled,

    set_menu_image                  : Proc_Set_Menu_Image,
    add_menu_item                   : Proc_Add_Menu_Item,
    add_checkmark_menu_item         : Proc_Add_Checkmark_Menu_Item,
    add_options_menu_item           : Proc_Add_Options_Menu_Item,
    remove_all_menu_items           : Proc_Remove_All_Menu_Items,
    remove_menu_item                : Proc_Remove_Menu_Item,
    get_menu_item_value             : Proc_Get_Menu_Item_Value,
    set_menu_item_value             : Proc_Set_Menu_Item_Value,
    get_menu_item_title             : Proc_Get_Menu_Item_Title,
    set_menu_item_title             : Proc_Set_Menu_Item_Title,
    get_menu_item_userdata          : Proc_Get_Menu_Item_Userdata,
    set_menu_item_userdata          : Proc_Set_Menu_Item_Userdata,

    get_reduce_flashing             : Proc_Get_Reduce_Flashing,
    
    // 1.1
    get_elapsed_time                : Proc_Get_Elapsed_Time,
    reset_elapsed_time              : Proc_Reset_Elapsed_Time,
    
    // 1.4
    get_battery_percentage          : Proc_Get_Battery_Percentage,
    get_battery_voltage             : Proc_Get_Battery_Voltage,
   
    // 1.13
    get_timezone_offest             : Proc_Get_Timezone_Offset,
    should_display_24_hour_time     : Proc_Should_Display_24_Hour_Time,
    convert_epoch_to_date_time      : Proc_Convert_Epoch_To_Date_Time,
    convert_date_time_to_epoch      : Proc_Convert_Date_Time_To_Epoch,

    // 2.0
    clear_i_cache                   : Proc_Clear_I_Cache,
}

// @(private)
// _Callback_Wrapper :: struct {
//     user_ptr: rawptr,
//     callback_ptr: Callback_Proc
// }

// @(private)
// Menu_Item_Callback_Wrapper :: struct {
//     user_ptr: rawptr,
//     callback_ptr: Menu_Item_Callback_Proc
// }