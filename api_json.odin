package playdate

import "core:c"

Json_Value_Type :: enum u8 {
    Null,
    True,
    False,
    Integer,
    Float,
    String,
    Array,
    Table,
}

Json_Value :: struct {
    type: Json_Value_Type,
    data: struct #raw_union {
        int_val     : c.int,
        float_val   : f32,
        string_val  : cstring,
        array_val   : rawptr, 
        table_val   : rawptr,
    },
}

// =================================================================

// - `decode_error`: Called when the decoder encounters an error.
// - `will_decode_sublist`: Called before attempting to decode a JSON object or array.
// - `did_decode_sublist`: Called after successfully decoding a JSON object or array. The returned value is passed to the corresponding `did_decode_table_value()`
// or `did_decode_array_value()` callback one level up, or the calling `decode()` or `decode_string()` procedure if the list is the top-level json object.
// - `should_decode_table_value_for_key`: Called before decoding a key/value pair from an object. Return 1 to proceed with decoding or return 0 to skip this pair.
// - `should_decode_array_value_at_index`: Called before decoding the value at pos from an array (note that pos is base 1 not 0). Return 1 to proceed with decoding or return 0 to skip this index.
// - `did_decode_table_value`: Called after successfully decoding a key/value pair from an object.
// - `did_decode_array_value`: Called after successfully decoding the value at pos from an array.
// - `user_data`: A storage slot for the API client.
// - `return_string`: If set in `will_decode_sublist()`, the sublist is returned as a string instead of parsed.
// - `path`: The current path in the parse tree. The root scope is named _root, but this is not included in the path when parsing the root’s children.
Json_Decoder :: struct {
    decode_error                        : proc "c" (decoder: ^Json_Decoder, error: cstring, line_number: c.int),
    will_decode_sublist                 : proc "c" (decoder: ^Json_Decoder, name: cstring, type: Json_Value_Type),
    should_decode_table_value_for_key   : proc "c" (decoder: ^Json_Decoder, key: cstring) -> c.int,
    did_decode_table_value              : proc "c" (decoder: ^Json_Decoder, key: cstring, value: Json_Value),
    should_decode_array_value_at_index  : proc "c" (decoder: ^Json_Decoder, position: c.int) -> c.int,
    did_decode_array_value              : proc "c" (decoder: ^Json_Decoder, position: c.int, value: Json_Value),
    did_decode_sublist                  : proc "c" (decoder: ^Json_Decoder, name: cstring, type: Json_Value_Type),
    
    user_data       : rawptr,
    return_string   : c.int,
    path            : cstring,
}


Write_Proc :: #type proc "c" (user_data: rawptr, str: cstring, length: c.int)

// Note that the encoder doesn’t perform any validation. It is up to the caller to ensure they are generating valid JSON.
// 
// - `start_array`: Opens a new JavaScript Array.
// - `add_array_member`: Creates a new index in the current JavaScript Array.
// - `end_array`: Closes the current JavaScript Array.
// - `start_table`: Opens a new JavaScript Object.
// - `add_table_member`: Creates a new property in the current JavaScript Object.
// - `end_table`: Closes the current JavaScript Object.
// - `write_null`: Writes the JavaScript primitive null.
// - `write_false`: Writes the JavaScript boolean value false.
// - `write_true`: Writes the JavaScript boolean value true.
// - `write_int`: Writes `num` as a JavaScript number.
// - `write_double`: Writes `num` as a JavaScript number.
// - `write_string`: Writes `str` of length `len` as a JavaScript string literal.
Json_Encoder :: struct {
    write_string_proc   : Write_Proc,
    user_data           : rawptr,

    pretty              : c.int,
    started_table       : c.int,
    started_array       : c.int,
    depth               : c.int,

    start_array        : proc "c" (encoder: ^Json_Encoder),
    add_array_member   : proc "c" (encoder: ^Json_Encoder),
    end_array          : proc "c" (encoder: ^Json_Encoder),
    start_table        : proc "c" (encoder: ^Json_Encoder),
    add_table_member   : proc "c" (encoder: ^Json_Encoder, name: cstring, length: c.int),
    end_table          : proc "c" (encoder: ^Json_Encoder),
    write_null         : proc "c" (encoder: ^Json_Encoder),
    write_false        : proc "c" (encoder: ^Json_Encoder),
    write_true         : proc "c" (encoder: ^Json_Encoder),
    write_int          : proc "c" (encoder: ^Json_Encoder, num: c.int),
    write_double       : proc "c" (encoder: ^Json_Encoder, num: f64),
    write_string       : proc "c" (encoder: ^Json_Encoder, str: cstring, length: c.int),
}


Json_Reader :: struct {
    read        : proc "c" (user_data: rawptr, buffer: [^]u8, buffer_size: c.int) -> c.int,
    user_data   : rawptr,
}

// =================================================================

Api_Json_Procs :: struct {
    init_encoder   : proc "c" (encoder: ^Json_Encoder, write: Write_Proc, user_data: rawptr, pretty: c.int),
    decode         : proc "c" (decoder: ^Json_Decoder, reader: Json_Reader, out_val: ^Json_Value) -> c.int,
    decode_string  : proc "c" (decoder: ^Json_Decoder, json_str: cstring, out_val: ^Json_Value) -> c.int,
}
