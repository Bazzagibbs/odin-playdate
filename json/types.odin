package playdate_json

Value_Type :: enum u8 {
    Null,
    True,
    False,
    Integer,
    Float,
    String,
    Array,
    Table,
}

Value :: struct {
    type: Value_Type,
    data: struct #raw_union {
        int_val     : i32,
        float_val   : f32,
        string_val  : cstring,
        array_val   : rawptr, 
        table_val   : rawptr,
    },
}

Reader :: struct {
    read        : Proc_Reader_Read,
    user_data   : rawptr,
}


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
Encoder :: struct {
    write_proc          : Write_Proc,
    user_data           : rawptr,
    pretty              : i32,
    started_table       : i32,
    started_array       : i32,
    depth               : i32,

    start_array         : Proc_Encoder_Start_Array,
    add_array_member    : Proc_Encoder_Add_Array_member,
    end_array           : Proc_Encoder_End_Array,
    start_table         : Proc_Encoder_Start_Table,
    add_table_member    : Proc_Encoder_Add_Table_Member,
    end_table           : Proc_Encoder_End_Table,
    write_null          : Proc_Encoder_Write_Null,
    write_false         : Proc_Encoder_Write_False,
    write_true          : Proc_Encoder_Write_True,
    write_int           : Proc_Encoder_Write_Int,
    write_double        : Proc_Encoder_Write_Double,
    write_string        : Proc_Encoder_Write_String,
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
Decoder :: struct {
    decode_error                        : Proc_Decoder_Decode_Error,

    // The following procs are each optional
    will_decode_sublist                 : Proc_Decoder_Will_Decode_Sublist,
    should_decode_table_value_for_key   : Proc_Decoder_Should_Decode_Table_Value_For_Key,
    did_decode_table_value              : Proc_Decoder_Did_Decode_Table_Value,
    should_decode_array_value_at_index  : Proc_Decoder_Should_Decode_Array_Value_At_Index,
    did_decode_array_value              : Proc_Decoder_Did_Decode_Array_Value,
    did_decode_sublist                  : Proc_Decoder_Did_Decode_Sublist,

    user_data       : rawptr,
    return_string   : i32,
    path            : cstring,
}


Write_Proc ::  proc "c" (user_data: rawptr, str: cstring, length: i32)