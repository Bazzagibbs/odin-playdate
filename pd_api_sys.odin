//
//  pdext_sys.h
//  Playdate Simulator
//
//  Created by Dave Hayden on 10/6/17.
//  Copyright © 2017 Panic, Inc. All rights reserved.
//
package playdate

import "core:c"

_ :: c



PDButtons :: enum c.int {
	Left  = 1,
	Right = 2,
	Up    = 4,
	Down  = 8,
	B     = 16,
	A     = 32,
}

PDLanguage :: enum c.int {
	English,
	Japanese,
	Unknown,
}

AccessRequestCallback :: proc "c" (bool, rawptr)

accessReply :: enum c.int {
	Ask,
	Deny,
	Allow,
}

PDDateTime :: struct {
	year:    u16,
	month:   u8, // 1-12
	day:     u8, // 1-31
	weekday: u8, // 1=monday-7=sunday
	hour:    u8, // 0-23
	minute:  u8,
	second:  u8,
}

PDPeripherals :: enum c.int {
	None           = 0,
	Accelerometer  = 1,

	// ...
	AllPeripherals = 65535,
}

PDCallbackFunction :: proc "c" (rawptr) -> c.int // return 0 when done

PDMenuItemCallbackFunction :: proc "c" (rawptr)

PDButtonCallbackFunction :: proc "c" (PDButtons, c.int, u32, rawptr) -> c.int

PDSerialMessageCallback :: #type proc "c" (data: cstring)

PDServerTimeCallback :: #type proc "c" (time: cstring, err: cstring)

playdate_sys :: struct {
	realloc:                    proc "c" (rawptr, c.size_t) -> rawptr, // ptr = NULL -> malloc, size = 0 -> free
	formatString:               proc "c" (ret: ^cstring, fmt: cstring, #c_vararg args: ..any) -> c.int,
	logToConsole:               proc "c" (fmt: cstring, #c_vararg args: ..any),
	error:                      proc "c" (fmt: cstring, #c_vararg args: ..any),
	getLanguage:                proc "c" (void) -> PDLanguage,
	getCurrentTimeMilliseconds: proc "c" (void) -> c.uint,
	getSecondsSinceEpoch:       proc "c" (^c.uint) -> c.uint,
	drawFPS:                    proc "c" (c.int, c.int),
	setUpdateCallback:          proc "c" (PDCallbackFunction, rawptr),
	getButtonState:             proc "c" (^PDButtons, ^PDButtons, ^PDButtons),
	setPeripheralsEnabled:      proc "c" (PDPeripherals),
	getAccelerometer:           proc "c" (^f32, ^f32, ^f32),
	getCrankChange:             proc "c" (void) -> f32,
	getCrankAngle:              proc "c" (void) -> f32,
	isCrankDocked:              proc "c" (void) -> c.int,
	setCrankSoundsDisabled:     proc "c" (c.int) -> c.int,             // returns previous setting
	getFlipped:                 proc "c" (void) -> c.int,
	setAutoLockDisabled:        proc "c" (c.int),
	setMenuImage:               proc "c" (^LCDBitmap, c.int),
	addMenuItem:                proc "c" (cstring, PDMenuItemCallbackFunction, rawptr) -> ^PDMenuItem,
	addCheckmarkMenuItem:       proc "c" (cstring, c.int, PDMenuItemCallbackFunction, rawptr) -> ^PDMenuItem,
	addOptionsMenuItem:         proc "c" (cstring, [^]cstring, c.int, PDMenuItemCallbackFunction, rawptr) -> ^PDMenuItem,
	removeAllMenuItems:         proc "c" (void),
	removeMenuItem:             proc "c" (^PDMenuItem),
	getMenuItemValue:           proc "c" (^PDMenuItem) -> c.int,
	setMenuItemValue:           proc "c" (^PDMenuItem, c.int),
	getMenuItemTitle:           proc "c" (^PDMenuItem) -> cstring,
	setMenuItemTitle:           proc "c" (^PDMenuItem, cstring),
	getMenuItemUserdata:        proc "c" (^PDMenuItem) -> rawptr,
	setMenuItemUserdata:        proc "c" (^PDMenuItem, rawptr),
	getReduceFlashing:          proc "c" (void) -> c.int,

	// 1.1
	getElapsedTime: proc "c" (void) -> f32,
	resetElapsedTime:           proc "c" (void),

	// 1.4
	getBatteryPercentage: proc "c" (void) -> f32,
	getBatteryVoltage:          proc "c" (void) -> f32,

	// 1.13
	getTimezoneOffset: proc "c" (void) -> i32,
	shouldDisplay24HourTime:    proc "c" (void) -> c.int,
	convertEpochToDateTime:     proc "c" (u32, ^PDDateTime),
	convertDateTimeToEpoch:     proc "c" (^PDDateTime) -> u32,

	// 2.0
	clearICache: proc "c" (void),

	// 2.4
	setButtonCallback: proc "c" (PDButtonCallbackFunction, rawptr, c.int),
	setSerialMessageCallback:   proc "c" (callback: PDSerialMessageCallback),
	vaFormatString:             proc "c" ([^]cstring, cstring, ^c.va_list) -> c.int,
	parseString:                proc "c" (str: cstring, #c_vararg args: ..any),

	// ???
	delay: proc "c" (u32),

	// 2.7
	getServerTime: proc "c" (callback: PDServerTimeCallback),
	restartGame:                proc "c" (cstring),
	getLaunchArgs:              proc "c" ([^]cstring) -> cstring,
	sendMirrorData:             proc "c" (u8, rawptr, c.int) -> bool,
}

