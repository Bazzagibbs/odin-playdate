package playdate_json

Proc_Init_Encoder   :: #type proc "c" (encoder: ^Encoder, write: Write_Proc, user_data: rawptr, pretty: i32)
Proc_Decode         :: #type proc "c" (decoder: ^Decoder, reader: Reader, out_val: ^Value) -> i32
Proc_Decode_String  :: #type proc "c" (decoder: ^Decoder, json_str: cstring, out_val: ^Value) -> i32

Proc_Decoder_Decode_Error                        :: #type proc "c" (decoder: ^Decoder, error: cstring, line_number: i32)
Proc_Decoder_Will_Decode_Sublist                 :: #type proc "c" (decoder: ^Decoder, name: cstring, type: Value_Type)
Proc_Decoder_Should_Decode_Table_Value_For_Key   :: #type proc "c" (decoder: ^Decoder, key: cstring) -> i32
Proc_Decoder_Did_Decode_Table_Value              :: #type proc "c" (decoder: ^Decoder, key: cstring, value: Value)
Proc_Decoder_Should_Decode_Array_Value_At_Index  :: #type proc "c" (decoder: ^Decoder, position: i32) -> i32
Proc_Decoder_Did_Decode_Array_Value              :: #type proc "c" (decoder: ^Decoder, position: i32, value: Value)
Proc_Decoder_Did_Decode_Sublist                  :: #type proc "c" (decoder: ^Decoder, name: cstring, type: Value_Type)
    
Proc_Encoder_Start_Array         :: #type proc "c" (encoder: ^Encoder)
Proc_Encoder_Add_Array_member    :: #type proc "c" (encoder: ^Encoder)
Proc_Encoder_End_Array           :: #type proc "c" (encoder: ^Encoder)
Proc_Encoder_Start_Table         :: #type proc "c" (encoder: ^Encoder)
Proc_Encoder_Add_Table_Member    :: #type proc "c" (encoder: ^Encoder, name: cstring, length: i32)
Proc_Encoder_End_Table           :: #type proc "c" (encoder: ^Encoder)
Proc_Encoder_Write_Null          :: #type proc "c" (encoder: ^Encoder)
Proc_Encoder_Write_False         :: #type proc "c" (encoder: ^Encoder)
Proc_Encoder_Write_True          :: #type proc "c" (encoder: ^Encoder)
Proc_Encoder_Write_Int           :: #type proc "c" (encoder: ^Encoder, num: i32)
Proc_Encoder_Write_Double        :: #type proc "c" (encoder: ^Encoder, num: f64)
Proc_Encoder_Write_String        :: #type proc "c" (encoder: ^Encoder, str: cstring, length: i32)

Proc_Reader_Read    :: #type proc "c" (user_data: rawptr, buffer: [^]u8, buffer_size: i32) -> i32


vtable : ^VTable

VTable :: struct {
    init_encoder    : Proc_Init_Encoder,
    decode          : Proc_Decode,
    decode_string   : Proc_Decode_String,
}