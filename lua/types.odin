package playdate_lua
import "../common"

State :: distinct common.Handle

C_Function :: #type proc "c" (state: State) -> i32

UD_Object :: distinct common.Handle // User Defined?

Bitmap :: common.Bitmap
Sprite :: common.Sprite

Value_Type :: enum {
    Int,
    Float, 
    String,
}

Reg :: struct {
    name: cstring,
    func: C_Function,
}

Type :: enum {
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

Value :: struct {
    name: cstring,
    type: Value_Type,
    val: struct #raw_union {
        int_val: u32,
        float_val: f32,
        str_val: cstring,
    },
}
