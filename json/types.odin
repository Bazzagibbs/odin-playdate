// TODO(Bailey): revisit this package when I need it. I don't know enough about the internals to Odin-ify it.
package playdate_json

/*
Value_Type :: enum u8 {
    _null,
    _true,
    _false,
    _integer,
    _float,
    _string,
    _array,
    _table,
}

// TODO: parapoly
Value :: struct {
    type: u8,
    data: union {
        u32,
        f32,
        cstring,
        rawptr, 
    },
}

Decoder :: struct {
    decode_error                        : Decoder_Decode_Error,
    will_decode_sublist                 : Decoder_Will_Decode_Sublist,
    should_decode_table_value_for_key   : Decoder_Should_Decode_Table_Value_For_Key,
    did_decode_table_value              : Decoder_Did_Decode_Table_Value,
    should_decode_array_value_at_index  : Decoder_Should_Decode_Array_Value_At_Index,
    did_decode_array_value              : Decoder_Did_Decode_Array_Value,
    did_decode_sublist                  : Decoder_Did_Decode_Sublist,

    user_data       : rawptr,
    return_string   : bool,
    path            : cstring,
}

Decoder_Decode_Error                        :: proc "c" (decoder: ^Decoder, error: cstring, line_number: i32)
Decoder_Will_Decode_Sublist                 :: proc "c" (decoder: ^Decoder, name: cstring, type: Value_Type)
Decoder_Should_Decode_Table_Value_For_Key   :: proc "c" (decoder: ^Decoder, key: cstring) -> bool
Decoder_Did_Decode_Table_Value              :: proc "c" (decoder: ^Decoder, key: cstring, value: Value)
Decoder_Should_Decode_Array_Value_At_Index  :: proc "c" (decoder: ^Decoder, position: i32) -> bool
Decoder_Did_Decode_Array_Value              :: proc "c" (decoder: ^Decoder, position: i32, value: Value)
Decoder_Did_Decode_Sublist                  :: proc "c" (decoder: ^Decoder, name: cstring, type: Value_Type)


Reader :: struct {
    read: proc "c" (user_data: rawptr, buffer: ^u8, buffer_size: i32) -> i32,
    user_data: rawptr,
}

Write_Proc ::  proc "c" (user_data: rawptr, str: cstring, length: i32)
*/