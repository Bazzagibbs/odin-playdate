package playdate_system

import "core:runtime"
import "core:strings"
import "../common"


// Allocates heap space if ptr is nil, else reallocates the given pointer. 
//
// If size is zero, frees the given pointer.
realloc :: #force_inline proc "contextless" (ptr: rawptr, size: u32) -> (data: []byte, ok: bool) {
    ptr := vtable.realloc(ptr, size)
    ok = ptr != nil
    if ok {
        data = ptr[:size]
    }
    return
}

// Allocates heap space.
// 
// Equivalent to `realloc(nil, size)`, not part of the Playdate SDK specification
alloc :: #force_inline proc "contextless" (size: u32) -> (data: []byte, ok: bool) {
    return realloc(nil, size)
} 

// Frees allocated heap space.
// 
// Equivalent to `realloc(ptr, 0)`, not part of the Playdate SDK specification.
free :: #force_inline proc "contextless" (ptr: rawptr) {
    _, _ = realloc(ptr, 0)
}

// Allocates a buffer `ret` and formats a string. Note that the caller is responsible for
// freeing `ret`.
format_string :: #force_inline proc "contextless" (ret: ^cstring, format: cstring, args: ..any) -> i32 {
    return vtable.format_string(ret, format, args)
}

// Calls the log procedure.
log_to_console :: #force_inline proc "contextless" (format: cstring, args: ..any) {
    vtable.log_to_console(format, args)
}

// Calls the log procedure, outputting an error in red to the console, then pauses execution.
error :: #force_inline proc "contextless" (format: cstring, args: ..any) {
    vtable.error(format, args)
}

// Returns the current language of the system.
get_language :: #force_inline proc "contextless" () -> Language {
    return vtable.get_language()
}

// Returns the number of milliseconds since... some arbitrary point in time. 
//
// This should present a consistent timebase while a game is running, but the counter will be disabled when the device is sleeping. 
get_current_time_milliseconds :: #force_inline proc "contextless" () -> u32 {
    return vtable.get_current_time_milliseconds()
}

// Returns the number of seconds (and milliseconds) elapsed since midnight (hour 0), January 1, 2000. 
get_seconds_since_epoch :: #force_inline proc "contextless" () -> (seconds: u32, milliseconds: u32) {
    seconds = vtable.get_seconds_since_epoch(&milliseconds)
    return
}

// Calculates the current frames per second and draws that value at x, y.
draw_fps :: #force_inline proc "contextless" (x, y: i32) {
    vtable.draw_fps(x, y)
}

// Replaces the default Lua run loop function with a custom update procedure. 
// 
// The update procedure should return true to tell the system to update the display, or false if update isn’t needed.
// 
// The `user_ptr` parameter will be provided to the `update` callback as `context.user_ptr`.
set_update_callback :: #force_inline proc "contextless" (update: Callback_Proc, user_ptr: rawptr = nil) {
    _user_update_proc = update
    vtable.set_update_callback(_internal_update_callback, user_ptr)
}

// Returns three `bit_set`s of Buttons. 
// 
// - `current` indicates which buttons are currently down
// - `pushed` and `released` indicate which buttons were pushed or released over the
// previous update cycle.
//
// Note: at the nominal frame rate of 50ms, fast button presses can be missed if you
// just poll the instantaneous (current) state.
get_button_state :: #force_inline proc "contextless" () -> (current, pushed, released: Buttons) {
    b0, b1, b2: Buttons
    vtable.get_button_state(&b0, &b1, &b2)
    return b0, b1, b2
}

// By default, the accelerometer is disabled to save (a small amount of) power. 
// To use a peripheral, it must first be enabled via this function. 
//
// Accelerometer data is not available until the next update cycle after it’s enabled.
set_peripherals_enabled :: #force_inline proc "contextless" (enabled_peripherals: Peripherals) {
    vtable.set_peripherals_enabled(enabled_peripherals)
}

// Returns the last-read accelerometer data 
get_accelerometer :: #force_inline proc "contextless" () -> (x, y, z: f32) {
    vtable.get_accelerometer(&x, &y, &z)
    return
}

//Returns the angle change of the crank since the last time this function was called. 
//
// Negative values are anti-clockwise. 
get_crank_change :: #force_inline proc "contextless" () -> f32 {
    return vtable.get_crank_change()
}

// Returns the current position of the crank, in the range 0-360. 
// 
// Zero is pointing up, and the value increases as the crank moves clockwise, 
// as viewed from the right side of the device.
get_crank_angle :: #force_inline proc "contextless" () -> f32 {
    return vtable.get_crank_angle()
}

// Returns true or false indicating whether or not the crank is folded into the unit.
is_crank_docked :: #force_inline proc "contextless" () -> bool {
    return vtable.is_crank_docked() != 0
}

// Set whether the DEFAULT system sounds for docking/undocking the crank should be muted or not.
// This is useful for playing custom sounds instead.
//
// Returns the previous value for this setting.
set_crank_sounds_disabled :: #force_inline proc "contextless" (disabled: bool) -> bool {
    return cast(bool) vtable.set_crank_sounds_disabled(i32(disabled))
}

// Returns true if the global "flipped" setting is set, otherwise false.
get_flipped :: #force_inline proc "contextless" () -> bool {
    return cast(bool) vtable.get_flipped()
}

// Disables or enables the 60 second auto lock feature. 
// When called, the timer is reset to 60 seconds.
set_auto_lock_disabled :: #force_inline proc "contextless" (disabled: bool) {
    vtable.set_auto_lock_disabled(i32(disabled))
}

// A game can optionally provide an image to be displayed alongside the system menu. `bitmap` must be a 400x240 `Bitmap`. 
// All important content should be in the left half of the image in an area 200 pixels wide, as the menu will obscure the rest. 
// The right side of the image will be visible briefly as the menu animates in and out.
// 
// Optionally, a non-zero `x_offset`, can be provided. This must be a number between 0 and 200 and will cause the menu image to 
// animate to a position offset left by xoffset pixels as the menu is animated in.
// 
// This function could be called in response to the `.pause` event in your implementation of `eventHandler()`.
set_menu_image :: #force_inline proc "contextless" (bitmap: common.Bitmap, x_offset: i32 = 0) {
    vtable.set_menu_image(bitmap, x_offset)
}

// `title` will be the title displayed by the menu item.
// 
// Adds a new menu item to the System Menu. When invoked by the user, this menu item will:
//
// 1. Invoke your callback procedure.
// 2. Hide the System Menu.
// 3. Unpause your game and call `eventHandler()` with the `.resume` event.
// 
// Your game can then present an options interface to the player, or take other action, in whatever manner you choose.
add_menu_item :: #force_inline proc(title: cstring, callback: Menu_Item_Callback_Proc, user_ptr := context.user_ptr) -> Menu_Item {
    // return vtable.add_menu_item(title, _wrap_menu_item_callback(callback), user_ptr )
    return vtable.add_menu_item(title, callback, user_ptr)
}

// Adds a new menu item that can be checked or unchecked by the player.
// 
// - `title` will be the title displayed by the menu item.
// - `value` should be false for unchecked, true for checked.
// 
// If this menu item is interacted with while the system menu is open, `callback` will be called when the menu is closed.
add_checkmark_menu_item :: #force_inline proc(title: cstring, value: bool, callback: Menu_Item_Callback_Proc, user_ptr := context.user_ptr) -> Menu_Item {
    return vtable.add_checkmark_menu_item(title, i32(value), callback, user_ptr)
}

// Adds a new menu item that allows the player to cycle through a set of options.
// 
// - `title` will be the title displayed by the menu item.
// - `options` should be a slice of cstrings representing the states this menu item can cycle through. 
//
// Due to limited horizontal space, the option strings and title should be kept short for this type of menu item.
//
// If this menu item is interacted with while the system menu is open, callback will be called when the menu is closed.
add_options_menu_item :: #force_inline proc(title: cstring, option_titles: []cstring, callback: Menu_Item_Callback_Proc, user_ptr := context.user_ptr) -> Menu_Item {
    return vtable.add_options_menu_item(title, raw_data(option_titles), i32(len(option_titles)), callback, user_ptr)
}

// Removes all custom menu items from the system menu.
remove_all_menu_items :: #force_inline proc "contextless" () {
    vtable.remove_all_menu_items()
}

// Removes the menu item from the system menu. 
remove_menu_item :: #force_inline proc "contextless" (menu_item: Menu_Item) {
    vtable.remove_menu_item(menu_item)
}

// Gets the integer value of the menu item.
//
// Note: the value of a checkmark menu item may be cast to `bool`. 
// `1` indicates checked, `0` indicates unchecked.
get_menu_item_value :: #force_inline proc "contextless" (menu_item: Menu_Item) -> i32 {
    return vtable.get_menu_item_value(menu_item)
}

// Sets the integer value of the menu item.
// 
// Note: for checkmark menu items, a value of `1` indicates checked, `0` indicates unchecked.
set_menu_item_value :: #force_inline proc "contextless" (menu_item: Menu_Item, value: i32) {
    vtable.set_menu_item_value(menu_item, value)
}

// Gets the display title of the menu item.
get_menu_item_title :: #force_inline proc "contextless" (menu_item: Menu_Item) -> cstring {
    return vtable.get_menu_item_title(menu_item)
}

// Sets the display title of the menu item.
set_menu_item_title :: #force_inline proc "contextless" (menu_item: Menu_Item, title: cstring) { 
    vtable.set_menu_item_title(menu_item, title)
}

// Gets the user data associated with this menu item.
get_menu_item_user_data :: #force_inline proc "contextless" (menu_item: Menu_Item) -> rawptr {
    return vtable.get_menu_item_userdata(menu_item)
}

// Sets the user data associated with this menu item.
set_menu_item_user_data :: #force_inline proc "contextless" (menu_item: Menu_Item, user_data: rawptr) {
    vtable.set_menu_item_userdata(menu_item, user_data)
}

// Returns true if the global "reduce flashing" system setting is set, otherwise false.
get_reduce_flashing :: #force_inline proc "contextless" () -> bool {
    return vtable.get_reduce_flashing() != 0
}



// Returns the number of seconds since `reset_elapsed_time()` was called.
// The value is a floating-point number with microsecond accuracy.
// 
// Since v1.1
get_elapsed_time :: #force_inline proc "contextless" () -> f32 {
    return vtable.get_elapsed_time()
}

// Resets the high-resolution timer.
//
// Since v1.1
reset_elapsed_time :: #force_inline proc "contextless" () {
    vtable.reset_elapsed_time()
}



// Returns a value from 0-100 denoting the current level of battery charge. 0 = empty; 100 = full.
// 
// Since v1.4
get_battery_percentage :: #force_inline proc "contextless" () -> f32 {
    return vtable.get_battery_percentage()
}

// Returns the battery's current voltage level.
// 
// Since v1.4
get_battery_voltage :: #force_inline proc "contextless" () -> f32 {
    return vtable.get_battery_voltage()
}



// Returns the system timezone offset from GMT, in seconds.
// 
// Since v1.13 
get_timezone_offset :: #force_inline proc "contextless" () -> i32 {
    return vtable.get_timezone_offest()
}

// Returns true if the user has set the 24-Hour Time preference in the Settings program.
// 
// Since v1.13 
should_display_24_hour_time :: #force_inline proc "contextless" () -> bool {
    return vtable.should_display_24_hour_time() != 0
}

// Converts the given epoch time to a `Date_Time`.
// 
// Since v1.13
convert_epoch_to_date_time :: #force_inline proc "contextless" (epoch: u32) -> Date_Time {
    date_time: Date_Time
    vtable.convert_epoch_to_date_time(epoch, &date_time)
    return date_time
}

// Converts the given `Date_Time`.
// 
// Since v1.13
convert_date_time_to_epoch :: #force_inline proc "contextless" (date_time: ^Date_Time) -> u32 {
    return vtable.convert_date_time_to_epoch(date_time)
}



// Flush the CPU instruction cache, on the very unlikely chance you’re modifying instruction code on the fly. 
// (If you don’t know what I’m talking about, you don’t need this. :)) 
// 
// Since v2.0
clear_i_cache :: #force_inline proc "contextless" () {
    vtable.clear_i_cache()
}


// =============================

@(private)
_user_update_proc: Callback_Proc

// Sets up Odin context before calling user-specified update procedure.
@(private)
_internal_update_callback :: proc "c" (userdata: rawptr) -> i32 {
    context = common.global_context
    context.user_ptr = userdata
    user_return_val := _user_update_proc()
    return i32(user_return_val)
}

