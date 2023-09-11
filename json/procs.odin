package playdate_json
import "core:strconv"
import "core:strings"
// import "../common"
import "../system"

// Value accessors
int_value       :: #force_inline proc "contextless" (value: Value) -> i32 {
    context = system.playdate_context()

    #partial switch value.type {
        case .Integer   : return value.data.int_val
        case .Float     : return i32(value.data.float_val)
        case .String    : return i32(strconv.parse_i64(string(value.data.string_val), 10) or_else 0)
        case .True      : return 1
        case            : return 0
    }

    return 0
}

float_value     :: #force_inline proc "contextless" (value: Value) -> f32 {
    #partial switch value.type {
        case .Integer   : return f32(value.data.int_val)
        case .Float     : return value.data.float_val
        // case .String    : return 0
        case .True      : return 1
        case            : return 0
    }

    return 0
}

bool_value       :: #force_inline proc "contextless" (value: Value) -> i32 {
    context = system.playdate_context()
    if value.type != .String {
        return 1 if strings.compare(string(value.data.string_val), "") != 0 else 0
    }
    return int_value(value)
}

string_value     :: #force_inline proc "contextless" (value: Value) -> cstring {
    return value.data.string_val if value.type == .String else nil
}


set_table_decode :: #force_inline proc(decoder: ^Decoder, 
        will_decode_sublist         : Proc_Decoder_Will_Decode_Sublist, 
        did_decode_table_value      : Proc_Decoder_Did_Decode_Table_Value, 
        did_decode_sublist          : Proc_Decoder_Did_Decode_Sublist) {

    decoder.did_decode_table_value  = did_decode_table_value
    decoder.did_decode_array_value  = nil
    decoder.will_decode_sublist     = will_decode_sublist
    decoder.did_decode_sublist      = did_decode_sublist
}

set_array_decode :: #force_inline proc(decoder: ^Decoder, 
        will_decode_sublist         : Proc_Decoder_Will_Decode_Sublist, 
        did_decode_array_value      : Proc_Decoder_Did_Decode_Array_Value, 
        did_decode_sublist          : Proc_Decoder_Did_Decode_Sublist) {

    decoder.did_decode_table_value  = nil
    decoder.did_decode_array_value  = did_decode_array_value
    decoder.will_decode_sublist     = will_decode_sublist
    decoder.did_decode_sublist      = did_decode_sublist
}


init_encoder :: #force_inline proc "contextless" (encoder: ^Encoder, write: Write_Proc, user_data: rawptr, pretty: bool = true) {
    vtable.init_encoder(encoder, write, user_data, i32(pretty))
}

// Decodes a JSON file with the given `decoder`. An instance of Decoder must implement `decode_error()`. 
// The remaining procedures are optional although you’ll probably want to implement at least `did_decode_table_value()` and `did_decode_array_value()`. 
// 
// `val` contains the value retured from the top-level `did_decode_sublist()` callback.
decode :: #force_inline proc "contextless" (decoder: ^Decoder, reader: Reader) -> (val: Value, ok: i32) {
    ok = vtable.decode(decoder, reader, &val)
    return
}

// Decodes a JSON string with the given `decoder`. An instance of Decoder must implement `decode_error()`. 
// The remaining procedures are optional although you’ll probably want to implement at least `did_decode_table_value()` and `did_decode_array_value()`. 
// 
// `val` contains the value retured from the top-level `did_decode_sublist()` callback.
decode_string :: proc(decoder: ^Decoder, json_string: cstring) -> (val: Value, ok: i32) {
    ok = vtable.decode_string(decoder, json_string, &val)
    return
}

