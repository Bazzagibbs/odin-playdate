package playdate_common

import "core:c"

//   ///////////
//  // TYPES //
// ///////////

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

Json_Reader :: struct {
    read        : Proc_Json_Reader_Read,
    user_data   : rawptr,
}

Json_Write_Proc ::  proc "c" (user_data: rawptr, str: cstring, length: c.int)

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
    write_proc          : Json_Write_Proc,
    user_data           : rawptr,
    pretty              : c.int,
    started_table       : c.int,
    started_array       : c.int,
    depth               : c.int,

    start_array         : Proc_Json_Encoder_Start_Array,
    add_array_member    : Proc_Json_Encoder_Add_Array_member,
    end_array           : Proc_Json_Encoder_End_Array,
    start_table         : Proc_Json_Encoder_Start_Table,
    add_table_member    : Proc_Json_Encoder_Add_Table_Member,
    end_table           : Proc_Json_Encoder_End_Table,
    write_null          : Proc_Json_Encoder_Write_Null,
    write_false         : Proc_Json_Encoder_Write_False,
    write_true          : Proc_Json_Encoder_Write_True,
    write_int           : Proc_Json_Encoder_Write_Int,
    write_double        : Proc_Json_Encoder_Write_Double,
    write_string        : Proc_Json_Encoder_Write_String,
}


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
    decode_error                        : Proc_Json_Decoder_Decode_Error,

    // The following procs are each optional
    will_decode_sublist                 : Proc_Json_Decoder_Will_Decode_Sublist,
    should_decode_table_value_for_key   : Proc_Json_Decoder_Should_Decode_Table_Value_For_Key,
    did_decode_table_value              : Proc_Json_Decoder_Did_Decode_Table_Value,
    should_decode_array_value_at_index  : Proc_Json_Decoder_Should_Decode_Array_Value_At_Index,
    did_decode_array_value              : Proc_Json_Decoder_Did_Decode_Array_Value,
    did_decode_sublist                  : Proc_Json_Decoder_Did_Decode_Sublist,

    user_data       : rawptr,
    return_string   : c.int,
    path            : cstring,
}


// =================================================================


//   ////////////////
//  // PROC TYPES //
// ////////////////

Proc_Json_Init_Encoder                                :: #type proc "c" (encoder: ^Json_Encoder, write: Json_Write_Proc, user_data: rawptr, pretty: c.int)
Proc_Json_Decode                                      :: #type proc "c" (decoder: ^Json_Decoder, reader: Json_Reader, out_val: ^Json_Value) -> c.int
Proc_Json_Decode_String                               :: #type proc "c" (decoder: ^Json_Decoder, json_str: cstring, out_val: ^Json_Value) -> c.int

Proc_Json_Decoder_Decode_Error                        :: #type proc "c" (decoder: ^Json_Decoder, error: cstring, line_number: c.int)
Proc_Json_Decoder_Will_Decode_Sublist                 :: #type proc "c" (decoder: ^Json_Decoder, name: cstring, type: Json_Value_Type)
Proc_Json_Decoder_Should_Decode_Table_Value_For_Key   :: #type proc "c" (decoder: ^Json_Decoder, key: cstring) -> c.int
Proc_Json_Decoder_Did_Decode_Table_Value              :: #type proc "c" (decoder: ^Json_Decoder, key: cstring, value: Json_Value)
Proc_Json_Decoder_Should_Decode_Array_Value_At_Index  :: #type proc "c" (decoder: ^Json_Decoder, position: c.int) -> c.int
Proc_Json_Decoder_Did_Decode_Array_Value              :: #type proc "c" (decoder: ^Json_Decoder, position: c.int, value: Json_Value)
Proc_Json_Decoder_Did_Decode_Sublist                  :: #type proc "c" (decoder: ^Json_Decoder, name: cstring, type: Json_Value_Type)
    
Proc_Json_Encoder_Start_Array                         :: #type proc "c" (encoder: ^Json_Encoder)
Proc_Json_Encoder_Add_Array_member                    :: #type proc "c" (encoder: ^Json_Encoder)
Proc_Json_Encoder_End_Array                           :: #type proc "c" (encoder: ^Json_Encoder)
Proc_Json_Encoder_Start_Table                         :: #type proc "c" (encoder: ^Json_Encoder)
Proc_Json_Encoder_Add_Table_Member                    :: #type proc "c" (encoder: ^Json_Encoder, name: cstring, length: c.int)
Proc_Json_Encoder_End_Table                           :: #type proc "c" (encoder: ^Json_Encoder)
Proc_Json_Encoder_Write_Null                          :: #type proc "c" (encoder: ^Json_Encoder)
Proc_Json_Encoder_Write_False                         :: #type proc "c" (encoder: ^Json_Encoder)
Proc_Json_Encoder_Write_True                          :: #type proc "c" (encoder: ^Json_Encoder)
Proc_Json_Encoder_Write_Int                           :: #type proc "c" (encoder: ^Json_Encoder, num: c.int)
Proc_Json_Encoder_Write_Double                        :: #type proc "c" (encoder: ^Json_Encoder, num: f64)
Proc_Json_Encoder_Write_String                        :: #type proc "c" (encoder: ^Json_Encoder, str: cstring, length: c.int)

Proc_Json_Reader_Read                                 :: #type proc "c" (user_data: rawptr, buffer: [^]u8, buffer_size: c.int) -> c.int

// =================================================================


//   ////////////////
//  // API STRUCT //
// ////////////////

Api_Json_Procs :: struct {
    init_encoder : Proc_Json_Init_Encoder,
    decode       : Proc_Json_Decode,
    decode_string: Proc_Json_Decode_String,
}
