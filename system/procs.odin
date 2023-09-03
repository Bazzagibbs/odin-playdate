package playdate_system

import gfx "../graphics"

realloc :: proc(ptr: rawptr, size: u32) -> rawptr

format_string :: proc(ret: ^cstring, format: cstring, args: ..any) -> i32

log_to_console :: proc(format: cstring, args: ..any)

error :: proc(format: cstring, args: ..any)

get_language :: proc() -> Language

get_current_time_milliseconds :: proc() -> u32

get_seconds_since_epoch :: proc(milliseconds: ^u32) -> u32

draw_fps :: proc(x, y: i32)


set_update_callback :: proc(update: Callback_Proc, user_data: rawptr)

get_button_state :: proc(current, pushed, released: Buttons)

set_peripherals_enabled :: proc(enabled_peripherals: Peripherals)

// get_accelerometer :: proc() -> x, y, z: f32 {}
get_accelerometer :: proc(x, y, z: ^f32)

get_crank_change :: proc() -> f32

get_crank_angle :: proc() -> f32

is_crank_docked :: proc() -> bool

set_crank_sounds_disabled :: proc(disabled: bool) -> bool // returns previous setting


get_flipped :: proc() -> bool

set_auto_lock_disabled :: proc(disabled: bool)


set_menu_image :: proc(bitmap: gfx.Bitmap, x_offset: i32)

add_menu_item :: proc(title: cstring, callback: Menu_Item_Callback_Proc, user_data: rawptr) -> ^Menu_Item

add_checkmark_menu_item :: proc(title: cstring, value: i32, callback: Menu_Item_Callback_Proc, user_data: rawptr) -> ^Menu_Item

add_options_menu_item :: proc(title: cstring, option_titles: []cstring, callback: Menu_Item_Callback_Proc, user_data: rawptr) -> ^Menu_Item

remove_all_menu_items :: proc()

remove_menu_item :: proc(menu_item: ^Menu_Item)

get_menu_item_value :: proc(menu_item: ^Menu_Item) -> i32

set_menu_item_value :: proc(menu_item: ^Menu_Item, value: i32)

get_menu_item_title :: proc(menu_item: ^Menu_Item) -> cstring

set_menu_item_title :: proc(menu_item: ^Menu_Item, title: cstring)

get_menu_item_user_data :: proc(menu_item: ^Menu_Item) -> rawptr

set_menu_item_user_data :: proc(menu_item: ^Menu_Item, user_data: rawptr)


get_reduce_flashing :: proc() -> bool


get_elapsed_time :: proc() -> f32               // since 1.1
reset_elapsed_time :: proc()                    // since 1.1

get_battery_percentage :: proc() -> f32         // since 1.4
get_battery_voltage :: proc() -> f32            // since 1.4

get_timezone_offset :: proc() -> i32                                // since 1.13
should_display_24_hour_time :: proc() -> bool                       // since 1.13
convert_epoch_to_date_time :: proc(epoch: u32) -> Date_Time         // since 1.13
convert_date_time_to_epoch :: proc(date_time: ^Date_Time) -> u32    // since 1.13

clear_i_cache :: proc()                         // since 2.0