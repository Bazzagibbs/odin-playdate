package playdate_lua

Proc_Add_Function       :: #type proc "c" (f: C_Function, name: cstring, out_err: ^cstring) -> i32
Proc_Register_Class     :: #type proc "c" (name: cstring, reg: Reg, vals: [^]Value, is_static: i32, out_err: ^cstring) -> i32
                         
Proc_Push_Function      :: #type proc "c" (f: C_Function)
Proc_Index_Metatable    :: #type proc "c" () -> i32
                         
Proc_Stop               :: #type proc "c" ()
Proc_Start              :: #type proc "c" ()
                         
Proc_Get_Arg_Count      :: #type proc "c" () -> i32
Proc_Get_Arg_Type       :: #type proc "c" (pos: i32, out_class: ^cstring) -> Type
                         
Proc_Arg_Is_Nil         :: #type proc "c" (pos: i32) -> i32
Proc_Get_Arg_Bool       :: #type proc "c" (pos: i32) -> i32
Proc_Get_Arg_Int        :: #type proc "c" (pos: i32) -> i32
Proc_Get_Arg_Float      :: #type proc "c" (pos: i32) -> f32
Proc_Get_Arg_String     :: #type proc "c" (pos: i32) -> cstring
Proc_Get_Arg_Bytes      :: #type proc "c" (pos: i32, out_len: u32) -> [^]byte
Proc_Get_Arg_Object     :: #type proc "c" (pos: i32, type: cstring, out_ud: ^UD_Object) -> rawptr
                         
Proc_Get_Bitmap         :: #type proc "c" (pos: i32) -> Bitmap
Proc_Get_Sprite         :: #type proc "c" (pos: i32) -> Sprite
                         
Proc_Push_Nil           :: #type proc "c" ()
Proc_Push_Bool          :: #type proc "c" (val: i32)
Proc_Push_Int           :: #type proc "c" (val: i32)
Proc_Push_Float         :: #type proc "c" (val: f32)
Proc_Push_String        :: #type proc "c" (str: cstring)
Proc_Push_Bytes         :: #type proc "c" (bytes: [^]byte, len: u32)
Proc_Push_Bitmap        :: #type proc "c" (bitmap: Bitmap)
Proc_Push_Sprite        :: #type proc "c" (sprite: Sprite)

Proc_Push_Object        :: #type proc "c" (obj: rawptr, type: cstring, n_values: i32) -> UD_Object
Proc_Retain_Object      :: #type proc "c" (obj: UD_Object) -> UD_Object
Proc_Release_Object     :: #type proc "c" (obj: UD_Object)

Proc_Set_User_Value     :: #type proc "c" (obj: UD_Object, slot: u32)
Proc_Get_User_Value     :: #type proc "c" (obj: UD_Object, slot: u32) -> i32

Proc_Call_Function_Deprecated   :: #type proc "c" (name: cstring, n_args: i32)
Proc_Call_Function              :: #type proc "c" (name: cstring, n_args: i32, out_err: ^cstring) -> i32


vtable: ^VTable

VTable :: struct {
    add_function    : Proc_Add_Function,
    register_class  : Proc_Register_Class,
                                         
    push_function   : Proc_Push_Function, 
    index_metatable : Proc_Index_Metatable,
                                         
    stop            : Proc_Stop,
    start           : Proc_Start,

    get_arg_count   : Proc_Get_Arg_Count,
    get_arg_type    : Proc_Get_Arg_Type,
                                         
    arg_is_nil      : Proc_Arg_Is_Nil,
    get_arg_bool    : Proc_Get_Arg_Bool,
    get_arg_int     : Proc_Get_Arg_Int,
    get_arg_float   : Proc_Get_Arg_Float, 
    get_arg_string  : Proc_Get_Arg_String,
    get_arg_bytes   : Proc_Get_Arg_Bytes, 
    get_arg_object  : Proc_Get_Arg_Object,
                                         
    get_bitmap      : Proc_Get_Bitmap,
    get_sprite      : Proc_Get_Sprite,
                                         
    push_nil        : Proc_Push_Nil,
    push_bool       : Proc_Push_Bool,
    push_int        : Proc_Push_Int,
    push_float      : Proc_Push_Float,
    push_string     : Proc_Push_String,
    push_bytes      : Proc_Push_Bytes,
    push_bitmap     : Proc_Push_Bitmap,
    push_sprite     : Proc_Push_Sprite,
                      

    push_object     : Proc_Push_Object,
    retain_object   : Proc_Retain_Object, 
    release_object  : Proc_Release_Object,

    set_user_value  : Proc_Set_User_Value,
    get_user_value  : Proc_Get_User_Value,

    call_function_deprecated    : Proc_Call_Function_Deprecated,
    call_function               : Proc_Call_Function,
}