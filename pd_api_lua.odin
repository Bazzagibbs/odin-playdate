//
//  pdext_lua.h
//  Playdate Simulator
//
//  Created by Dave Hayden on 10/6/17.
//  Copyright © 2017 Panic, Inc. All rights reserved.
//
package playdate

import "core:c"

_ :: c



lua_State :: rawptr

lua_CFunction :: proc "c" (^lua_State) -> c.int

l_valtype :: enum c.int {
	Int,
	Float,
	Str,
}

lua_reg :: struct {
	name: cstring,
	func: lua_CFunction,
}

LuaType :: enum c.int {
	Nil,
	Bool,
	Int,
	Float,
	String,
	Table,
	Function,
	Thread,
	Object,
}

lua_val :: struct {
	name: cstring,
	type: l_valtype,
	v:    struct #raw_union {
		intval:   c.uint,
		floatval: f32,
		strval:   cstring,
	},
}

playdate_lua :: struct {
	// these two return 1 on success, else 0 with an error message in outErr
	addFunction: proc "c" (lua_CFunction, cstring, [^]cstring) -> c.int,
	registerClass:  proc "c" (cstring, ^lua_reg, ^lua_val, c.int, [^]cstring) -> c.int,
	pushFunction:   proc "c" (lua_CFunction),
	indexMetatable: proc "c" (void) -> c.int,
	stop:           proc "c" (void),
	start:          proc "c" (void),

	// stack operations
	getArgCount: proc "c" (void) -> c.int,
	getArgType:     proc "c" (c.int, [^]cstring) -> LuaType,
	argIsNil:       proc "c" (c.int) -> c.int,
	getArgBool:     proc "c" (c.int) -> c.int,
	getArgInt:      proc "c" (c.int) -> c.int,
	getArgFloat:    proc "c" (c.int) -> f32,
	getArgString:   proc "c" (c.int) -> cstring,
	getArgBytes:    proc "c" (c.int, ^c.size_t) -> cstring,
	getArgObject:   proc "c" (c.int, cstring, ^^LuaUDObject) -> rawptr,
	getBitmap:      proc "c" (c.int) -> ^LCDBitmap,
	getSprite:      proc "c" (c.int) -> ^LCDSprite,

	// for returning values back to Lua
	pushNil: proc "c" (void),
	pushBool:       proc "c" (c.int),
	pushInt:        proc "c" (c.int),
	pushFloat:      proc "c" (f32),
	pushString:     proc "c" (cstring),
	pushBytes:      proc "c" (cstring, c.size_t),
	pushBitmap:     proc "c" (^LCDBitmap),
	pushSprite:     proc "c" (^LCDSprite),
	pushObject:     proc "c" (rawptr, cstring, c.int) -> ^LuaUDObject,
	retainObject:   proc "c" (^LuaUDObject) -> ^LuaUDObject,
	releaseObject:  proc "c" (^LuaUDObject),
	setUserValue:   proc "c" (^LuaUDObject, c.uint),          // sets item on top of stack and pops it
	getUserValue:   proc "c" (^LuaUDObject, c.uint) -> c.int, // pushes item at slot to top of stack, returns stack position

	// calling lua from C has some overhead. use sparingly!
	callFunction_deprecated: proc "c" (cstring, c.int),
	callFunction:   proc "c" (cstring, c.int, [^]cstring) -> c.int,
}

