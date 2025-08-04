//
//  pdext_json.h
//  Playdate Simulator
//
//  Created by Dave Hayden on 10/6/17.
//  Copyright © 2017 Panic, Inc. All rights reserved.
//
package playdate

import "core:c"

_ :: c



json_value_type :: enum c.int {
	Null,
	True,
	False,
	Integer,
	Float,
	String,
	Array,
	Table,
}

json_value :: struct {
	type: c.char,
	data: struct #raw_union {
		intval:    c.int,
		floatval:  f32,
		stringval: cstring,
		arrayval:  rawptr,
		tableval:  rawptr,
	},
}

json_decoder :: struct {
	decodeError:                   proc "c" (^json_decoder, cstring, c.int),

	// the following functions are each optional
	willDecodeSublist: proc "c" (^json_decoder, cstring, json_value_type),
	shouldDecodeTableValueForKey:  proc "c" (^json_decoder, cstring) -> c.int,
	didDecodeTableValue:           proc "c" (^json_decoder, cstring, json_value),
	shouldDecodeArrayValueAtIndex: proc "c" (^json_decoder, c.int) -> c.int,
	didDecodeArrayValue:           proc "c" (^json_decoder, c.int, json_value), // if pos==0, this was a bare value at the root of the file
	didDecodeSublist:              proc "c" (^json_decoder, cstring, json_value_type) -> rawptr,
	userdata:                      rawptr,
	returnString:                  c.int,                                       // when set, the decoder skips parsing and returns the current subtree as a string
	path:                          cstring,                                     // updated during parsing, reflects current position in tree
}

// fill buffer, return bytes written or -1 on end of data
json_readFunc :: proc "c" (rawptr, ^u8, c.int) -> c.int

json_reader :: struct {
	read:     json_readFunc,
	userdata: rawptr, // passed back to the read function above
}

// encoder
json_writeFunc :: proc "c" (rawptr, cstring, c.int)

json_encoder :: struct {
	writeStringFunc: json_writeFunc,
	userdata:        rawptr,
	pretty:          c.int,
	startedTable:    c.int,
	startedArray:    c.int,
	depth:           c.int,
	startArray:      proc "c" (^json_encoder),
	addArrayMember:  proc "c" (^json_encoder),
	endArray:        proc "c" (^json_encoder),
	startTable:      proc "c" (^json_encoder),
	addTableMember:  proc "c" (^json_encoder, cstring, c.int),
	endTable:        proc "c" (^json_encoder),
	writeNull:       proc "c" (^json_encoder),
	writeFalse:      proc "c" (^json_encoder),
	writeTrue:       proc "c" (^json_encoder),
	writeInt:        proc "c" (^json_encoder, c.int),
	writeDouble:     proc "c" (^json_encoder, f64),
	writeString:     proc "c" (^json_encoder, cstring, c.int),
}

playdate_json :: struct {
	initEncoder:  proc "c" (^json_encoder, json_writeFunc, rawptr, c.int),
	decode:       proc "c" (^json_decoder, json_reader, ^json_value) -> c.int,
	decodeString: proc "c" (^json_decoder, cstring, ^json_value) -> c.int,
}

@(default_calling_convention="c", link_prefix="")
foreign lib {
	json_intValue    :: proc(value: json_value) -> c.int ---
	json_floatValue  :: proc(value: json_value) -> f32 ---
	json_boolValue   :: proc(value: json_value) -> c.int ---
	json_stringValue :: proc(value: json_value) -> cstring ---

	// convenience functions for setting up a table-only or array-only decoder
	json_setTableDecode :: proc(decoder: ^json_decoder, willDecodeSublist: proc "c" (^json_decoder, cstring, json_value_type), didDecodeTableValue: proc "c" (^json_decoder, cstring, json_value), didDecodeSublist: proc "c" (^json_decoder, cstring, json_value_type) -> rawptr) ---
	json_setArrayDecode :: proc(decoder: ^json_decoder, willDecodeSublist: proc "c" (^json_decoder, cstring, json_value_type), didDecodeArrayValue: proc "c" (^json_decoder, c.int, json_value), didDecodeSublist: proc "c" (^json_decoder, cstring, json_value_type) -> rawptr) ---
}
