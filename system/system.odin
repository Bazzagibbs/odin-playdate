package playdate_system

// import "../common"
//
// Buttons     :: common.Sys_Buttons
// Button      :: common.Sys_Button
// Language    :: common.Sys_Language
// Date_Time   :: common.Sys_Date_Time
// Menu_Item   :: common.Sys_Menu_Item
// Peripherals :: common.Sys_Peripherals
// Peripheral  :: common.Sys_Peripheral
//
//
// // =================================================================
//
//
// // Allocates heap space if ptr is nil, else reallocates the given pointer. If size is zero, frees the given pointer.
// realloc                       : common.Proc_Sys_Realloc
//
// // Allocates a buffer `ret` and formats a string. Note that the caller is responsible for
// // freeing `ret`.
// format_string                 : common.Proc_Sys_Format_String
//
// // Calls the log procedure.
// log_to_console                : common.Proc_Sys_Log_To_Console
//
// // Calls the log procedure, outputting an error in red to the console, then pauses execution.
// error                         : common.Proc_Sys_Error
//
// // Returns the current language of the system.
// get_language                  : common.Proc_Sys_Get_Language
//
// // Returns the number of milliseconds since... some arbitrary point in time. 
// //
// // This should present a consistent timebase while a game is running, but the counter will be disabled when the device is sleeping. 
// get_current_time_milliseconds : common.Proc_Sys_Get_Current_Time_Milliseconds
//
// // Returns the number of seconds (and milliseconds) elapsed since midnight (hour 0), January 1, 2000. 
// get_seconds_since_epoch       : common.Proc_Sys_Get_Seconds_Since_Epoch
//
// // Calculates the current frames per second and draws that value at x, y.
// draw_fps                      : common.Proc_Sys_Draw_FPS
//
// // Replaces the default Lua run loop function with a custom update procedure. 
// // 
// // The update procedure should return true to tell the system to update the display, or false if update isn’t needed.
// // 
// // The `user_ptr` parameter will be provided to the `update` callback as `context.user_ptr`.
// set_update_callback           : common.Proc_Sys_Set_Update_Callback
//
// // Returns three `bit_set`s of Buttons. 
// // 
// // - `current` indicates which buttons are currently down
// // - `pushed` and `released` indicate which buttons were pushed or released over the
// // previous update cycle.
// //
// // Note: at the nominal frame rate of 50ms, fast button presses can be missed if you
// // just poll the instantaneous (current) state.
// get_button_state              : common.Proc_Sys_Get_Button_State
//
// // By default, the accelerometer is disabled to save (a small amount of) power. 
// // To use a peripheral, it must first be enabled via this function. 
// //
// // Accelerometer data is not available until the next update cycle after it’s enabled.
// set_peripherals_enabled       : common.Proc_Sys_Set_Peripherals_Enabled
//
// // Returns the last-read accelerometer data 
// get_accelerometer             : common.Proc_Sys_Get_Accelerometer
//
// //Returns the angle change of the crank since the last time this function was called. 
// //
// // Negative values are anti-clockwise. 
// get_crank_change              : common.Proc_Sys_Get_Crank_Change
//
// // Returns the current position of the crank, in the range 0-360. 
// // 
// // Zero is pointing up, and the value increases as the crank moves clockwise, 
// // as viewed from the right side of the device.
// get_crank_angle               : common.Proc_Sys_Get_Crank_Angle
//
// // Returns true or false indicating whether or not the crank is folded into the unit.
// is_crank_docked               : common.Proc_Sys_Is_Crank_Docked
//
// // Set whether the DEFAULT system sounds for docking/undocking the crank should be muted or not.
// // This is useful for playing custom sounds instead.
// //
// // Returns the previous value for this setting.
// set_crank_sounds_disabled     : common.Proc_Sys_Set_Crank_Sounds_Disabled
//
// // Returns true if the global "flipped" setting is set, otherwise false.
// get_flipped                   : common.Proc_Sys_Get_Flipped
//
// // Disables or enables the 60 second auto lock feature. 
// // When called, the timer is reset to 60 seconds.
// set_auto_lock_disabled        : common.Proc_Sys_Set_Auto_Lock_Disabled
//
// // A game can optionally provide an image to be displayed alongside the system menu. `bitmap` must be a 400x240 `Bitmap`. 
// // All important content should be in the left half of the image in an area 200 pixels wide, as the menu will obscure the rest. 
// // The right side of the image will be visible briefly as the menu animates in and out.
// // 
// // Optionally, a non-zero `x_offset`, can be provided. This must be a number between 0 and 200 and will cause the menu image to 
// // animate to a position offset left by xoffset pixels as the menu is animated in.
// // 
// // This function could be called in response to the `.pause` event in your implementation of `eventHandler()`.
// set_menu_image                : common.Proc_Sys_Set_Menu_Image
//
// // `title` will be the title displayed by the menu item.
// // 
// // Adds a new menu item to the System Menu. When invoked by the user, this menu item will:
// //
// // 1. Invoke your callback procedure.
// // 2. Hide the System Menu.
// // 3. Unpause your game and call `eventHandler()` with the `.resume` event.
// // 
// // Your game can then present an options interface to the player, or take other action, in whatever manner you choose.
// add_menu_item                 : common.Proc_Sys_Add_Menu_Item
//
// // Adds a new menu item that can be checked or unchecked by the player.
// // 
// // - `title` will be the title displayed by the menu item.
// // - `value` should be false for unchecked, true for checked.
// // 
// // If this menu item is interacted with while the system menu is open, `callback` will be called when the menu is closed.
// add_checkmark_menu_item       : common.Proc_Sys_Add_Checkmark_Menu_Item
//
// // Adds a new menu item that allows the player to cycle through a set of options.
// // 
// // - `title` will be the title displayed by the menu item.
// // - `options` should be a slice of cstrings representing the states this menu item can cycle through. 
// //
// // Due to limited horizontal space, the option strings and title should be kept short for this type of menu item.
// //
// // If this menu item is interacted with while the system menu is open, callback will be called when the menu is closed.
// add_options_menu_item         : common.Proc_Sys_Add_Options_Menu_Item
//
// // Removes all custom menu items from the system menu.
// remove_all_menu_items         : common.Proc_Sys_Remove_All_Menu_Items
//
// // Removes the menu item from the system menu. 
// remove_menu_item              : common.Proc_Sys_Remove_Menu_Item
//
// // Gets the integer value of the menu item.
// //
// // Note: the value of a checkmark menu item may be cast to `bool`. 
// // `1` indicates checked, `0` indicates unchecked.
// get_menu_item_value           : common.Proc_Sys_Get_Menu_Item_Value
//
// // Sets the integer value of the menu item.
// // 
// // Note: for checkmark menu items, a value of `1` indicates checked, `0` indicates unchecked.
// set_menu_item_value           : common.Proc_Sys_Set_Menu_Item_Value
//
// // Gets the display title of the menu item.
// get_menu_item_title           : common.Proc_Sys_Get_Menu_Item_Title
//
// // Sets the display title of the menu item.
// set_menu_item_title           : common.Proc_Sys_Set_Menu_Item_Title
//
// // Gets the user data associated with this menu item.
// get_menu_item_userdata        : common.Proc_Sys_Get_Menu_Item_Userdata
//
// // Sets the user data associated with this menu item.
// set_menu_item_userdata        : common.Proc_Sys_Set_Menu_Item_Userdata
//
// // Returns true if the global "reduce flashing" system setting is set, otherwise false.
// get_reduce_flashing           : common.Proc_Sys_Get_Reduce_Flashing
//
//
//
// // Returns the number of seconds since `reset_elapsed_time()` was called.
// // The value is a floating-point number with microsecond accuracy.
// // 
// // Since v1.1
// get_elapsed_time              : common.Proc_Sys_Get_Elapsed_Time
//
// // Resets the high-resolution timer.
// //
// // Since v1.1
// reset_elapsed_time            : common.Proc_Sys_Reset_Elapsed_Time
//
//
// // Returns a value from 0-100 denoting the current level of battery charge. 0 = empty; 100 = full.
// // 
// // Since v1.4
// get_battery_percentage        : common.Proc_Sys_Get_Battery_Percentage
//
// // Returns the battery's current voltage level.
// // 
// // Since v1.4
// get_battery_voltage           : common.Proc_Sys_Get_Battery_Voltage
//
//
//
// // Returns the system timezone offset from GMT, in seconds.
// // 
// // Since v1.13 
// get_timezone_offset           : common.Proc_Sys_Get_Timezone_Offset
//
// // Returns true if the user has set the 24-Hour Time preference in the Settings program.
// // 
// // Since v1.13 
// should_display_24_hour_time   : common.Proc_Sys_Should_Display_24_Hour_Time
//
// // Converts the given epoch time to a `Date_Time`.
// // 
// // Since v1.13
// convert_epoch_to_date_time    : common.Proc_Sys_Convert_Epoch_To_Date_Time
//
// // Converts the given `Date_Time`.
// // 
// // Since v1.13
// convert_date_time_to_epoch    : common.Proc_Sys_Convert_Date_Time_To_Epoch
//
//
//
// // Flush the CPU instruction cache, on the very unlikely chance you’re modifying instruction code on the fly. 
// // (If you don’t know what I’m talking about, you don’t need this. :)) 
// // 
// // Since v2.0
// clear_i_cache                 : common.Proc_Sys_Clear_I_Cache
//
// // =================================================================
//
//
// //   /////////////////
// //  // LOADER PROC //
// // /////////////////
//
// // System is always loaded by Playdate package. 
// _load_procs :: proc "contextless" (api: ^common.Api) {
//     
//     realloc                        = api.system.realloc
//     format_string                  = api.system.format_string
//     log_to_console                 = api.system.log_to_console
//     error                          = api.system.error
//     get_language                   = api.system.get_language
//     get_current_time_milliseconds  = api.system.get_current_time_milliseconds
//     get_seconds_since_epoch        = api.system.get_seconds_since_epoch
//     draw_fps                       = api.system.draw_fps
//
//     set_update_callback            = api.system.set_update_callback
//     get_button_state               = api.system.get_button_state
//     set_peripherals_enabled        = api.system.set_peripherals_enabled
//     get_accelerometer              = api.system.get_accelerometer
//
//     get_crank_change               = api.system.get_crank_change
//     get_crank_angle                = api.system.get_crank_angle
//     is_crank_docked                = api.system.is_crank_docked
//     set_crank_sounds_disabled      = api.system.set_crank_sounds_disabled
//
//     get_flipped                    = api.system.get_flipped
//     set_auto_lock_disabled         = api.system.set_auto_lock_disabled
//
//     set_menu_image                 = api.system.set_menu_image
//     add_menu_item                  = api.system.add_menu_item
//     add_checkmark_menu_item        = api.system.add_checkmark_menu_item
//     add_options_menu_item          = api.system.add_options_menu_item
//     remove_all_menu_items          = api.system.remove_all_menu_items
//     remove_menu_item               = api.system.remove_menu_item
//     get_menu_item_value            = api.system.get_menu_item_value
//     set_menu_item_value            = api.system.set_menu_item_value
//     get_menu_item_title            = api.system.get_menu_item_title
//     set_menu_item_title            = api.system.set_menu_item_title
//     get_menu_item_userdata         = api.system.get_menu_item_userdata
//     set_menu_item_userdata         = api.system.set_menu_item_userdata
//
//     get_reduce_flashing            = api.system.get_reduce_flashing
//
//     // 1.1
//     get_elapsed_time               = api.system.get_elapsed_time
//     reset_elapsed_time             = api.system.reset_elapsed_time
//
//     // 1.4
//     get_battery_percentage         = api.system.get_battery_percentage
//     get_battery_voltage            = api.system.get_battery_voltage
//
//     // 1.13
//     get_timezone_offset            = api.system.get_timezone_offset
//     should_display_24_hour_time    = api.system.should_display_24_hour_time
//     convert_epoch_to_date_time     = api.system.convert_epoch_to_date_time
//     convert_date_time_to_epoch     = api.system.convert_date_time_to_epoch
//
//     // 2.0
//     clear_i_cache                  = api.system.clear_i_cache
// }
