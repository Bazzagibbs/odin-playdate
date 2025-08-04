//
//  pd_api.h
//  Playdate C API
//
//  Created by Dave Hayden on 7/30/14.
//  Copyright (c) 2014 Panic, Inc. All rights reserved.
//
package playdate

import "core:c"

_ :: c



PlaydateAPI :: struct {
	system:      ^playdate_sys,
	file:        ^playdate_file,
	graphics:    ^playdate_graphics,
	sprite:      ^playdate_sprite,
	display:     ^playdate_display,
	sound:       ^playdate_sound,
	lua:         ^playdate_lua,
	json:        ^playdate_json,
	scoreboards: ^playdate_scoreboards,
	network:     ^playdate_network,
}

PDSystemEvent :: enum c.int {
	Init,
	InitLua,
	Lock,
	Unlock,
	Pause,
	Resume,
	Terminate,
	KeyPressed, // arg is keycode
	KeyReleased,
	LowPower,
	MirrorStarted,
	MirrorEnded,
}

@(default_calling_convention="c", link_prefix="")
foreign lib {
	eventHandler :: proc(playdate: ^PlaydateAPI, event: PDSystemEvent, arg: u32) -> c.int ---
}
