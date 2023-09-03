package playdate_json

/*
init_encoder :: proc(encoder: ^Encoder, write: Write_Proc, user_data: rawptr, pretty: bool)

decode :: proc(decoder: ^Decoder, reader: Reader) -> []Value
decode_string :: proc(decoder: ^Decoder, json_string: cstring) -> []Value

set_table_decode :: #force_inline proc(decoder: ^Decoder, 
    will_decode_sublist: Decoder_Will_Decode_Sublist, 
    did_decode_table_value: Decoder_Did_Decode_Table_Value, 
    did_decode_sublist: Decoder_Did_Decode_Sublist) {

    decoder.did_decode_table_value  = did_decode_table_value
    decoder.did_decode_array_value  = nil
    decoder.will_decode_sublist     = will_decode_sublist
    decoder.did_decode_sublist      = did_decode_sublist
}

set_array_decode :: #force_inline proc(decoder: ^Decoder, 
    will_decode_sublist: Decoder_Will_Decode_Sublist, 
    did_decode_array_value: Decoder_Did_Decode_Array_Value, 
    did_decode_sublist: Decoder_Did_Decode_Sublist) {

    decoder.did_decode_table_value  = nil
    decoder.did_decode_array_value  = did_decode_array_value
    decoder.will_decode_sublist     = will_decode_sublist
    decoder.did_decode_sublist      = did_decode_sublist
}
*/
