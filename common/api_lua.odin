package playdate_common

//   ///////////
//  // TYPES //
// ///////////

Lua_State :: distinct Handle

Lua_C_Function :: #type proc "c" (state: Lua_State) -> i32

Lua_UD_Object :: distinct Handle // User Defined?

Lua_Value_Type :: enum {
    Int,
    Float, 
    String,
}

Lua_Reg :: struct {
    name: cstring,
    func: Lua_C_Function,
}

Lua_Type :: enum {
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

Lua_Value :: struct {
    name: cstring,
    type: Lua_Value_Type,
    val : struct #raw_union {
        int_val  : u32,
        float_val: f32,
        str_val  : cstring,
    },
}

// =================================================================


//   ////////////////
//  // PROC TYPES //
// ////////////////

Proc_Lua_Add_Function       :: #type proc "c" (f: Lua_C_Function, name: cstring, out_err: ^cstring) -> i32
Proc_Lua_Register_Class     :: #type proc "c" (name: cstring, reg: [^]Lua_Reg, vals: [^]Lua_Value, is_static: b32, out_err: ^cstring) -> i32
                         
Proc_Lua_Push_Function      :: #type proc "c" (f: Lua_C_Function)
Proc_Lua_Index_Metatable    :: #type proc "c" () -> i32
                         
Proc_Lua_Stop               :: #type proc "c" ()
Proc_Lua_Start              :: #type proc "c" ()
                         
Proc_Lua_Get_Arg_Count      :: #type proc "c" () -> i32
Proc_Lua_Get_Arg_Type       :: #type proc "c" (pos: i32, out_class: ^cstring) -> Lua_Type
                         
Proc_Lua_Arg_Is_Nil         :: #type proc "c" (pos: i32) -> i32
Proc_Lua_Get_Arg_Bool       :: #type proc "c" (pos: i32) -> i32
Proc_Lua_Get_Arg_Int        :: #type proc "c" (pos: i32) -> i32
Proc_Lua_Get_Arg_Float      :: #type proc "c" (pos: i32) -> f32
Proc_Lua_Get_Arg_String     :: #type proc "c" (pos: i32) -> cstring
Proc_Lua_Get_Arg_Bytes      :: #type proc "c" (pos: i32, out_len: ^u32) -> [^]byte
Proc_Lua_Get_Arg_Object     :: #type proc "c" (pos: i32, type: cstring, out_ud: ^Lua_UD_Object) -> rawptr
                         
Proc_Lua_Get_Bitmap         :: #type proc "c" (pos: i32) -> Bitmap
Proc_Lua_Get_Sprite         :: #type proc "c" (pos: i32) -> Sprite
                         
Proc_Lua_Push_Nil           :: #type proc "c" ()
Proc_Lua_Push_Bool          :: #type proc "c" (val: i32)
Proc_Lua_Push_Int           :: #type proc "c" (val: i32)
Proc_Lua_Push_Float         :: #type proc "c" (val: f32)
Proc_Lua_Push_String        :: #type proc "c" (str: cstring)
Proc_Lua_Push_Bytes         :: #type proc "c" (bytes: [^]byte, length: u32)
Proc_Lua_Push_Bitmap        :: #type proc "c" (bitmap: Bitmap)
Proc_Lua_Push_Sprite        :: #type proc "c" (sprite: Sprite)

Proc_Lua_Push_Object        :: #type proc "c" (obj: rawptr, type: cstring, n_values: i32) -> Lua_UD_Object
Proc_Lua_Retain_Object      :: #type proc "c" (obj: Lua_UD_Object) -> Lua_UD_Object
Proc_Lua_Release_Object     :: #type proc "c" (obj: Lua_UD_Object)

Proc_Lua_Set_User_Value     :: #type proc "c" (obj: Lua_UD_Object, slot: u32)
Proc_Lua_Get_User_Value     :: #type proc "c" (obj: Lua_UD_Object, slot: u32) -> i32

Proc_Lua_Call_Function_Deprecated   :: #type proc "c" (name: cstring, n_args: i32)
Proc_Lua_Call_Function              :: #type proc "c" (name: cstring, n_args: i32, out_err: ^cstring) -> i32


// =================================================================


//   ////////////////
//  // API STRUCT //
// ////////////////

Api_Lua_Procs :: struct {
    add_function    : Proc_Lua_Add_Function,
    register_class  : Proc_Lua_Register_Class,
                                         
    push_function   : Proc_Lua_Push_Function, 
    index_metatable : Proc_Lua_Index_Metatable,
                                         
    stop            : Proc_Lua_Stop,
    start           : Proc_Lua_Start,

    get_arg_count   : Proc_Lua_Get_Arg_Count,
    get_arg_type    : Proc_Lua_Get_Arg_Type,
                                         
    arg_is_nil      : Proc_Lua_Arg_Is_Nil,
    get_arg_bool    : Proc_Lua_Get_Arg_Bool,
    get_arg_int     : Proc_Lua_Get_Arg_Int,
    get_arg_float   : Proc_Lua_Get_Arg_Float, 
    get_arg_string  : Proc_Lua_Get_Arg_String,
    get_arg_bytes   : Proc_Lua_Get_Arg_Bytes, 
    get_arg_object  : Proc_Lua_Get_Arg_Object,
                                         
    get_bitmap      : Proc_Lua_Get_Bitmap,
    get_sprite      : Proc_Lua_Get_Sprite,
                                         
    push_nil        : Proc_Lua_Push_Nil,
    push_bool       : Proc_Lua_Push_Bool,
    push_int        : Proc_Lua_Push_Int,
    push_float      : Proc_Lua_Push_Float,
    push_string     : Proc_Lua_Push_String,
    push_bytes      : Proc_Lua_Push_Bytes,
    push_bitmap     : Proc_Lua_Push_Bitmap,
    push_sprite     : Proc_Lua_Push_Sprite,
                      

    push_object     : Proc_Lua_Push_Object,
    retain_object   : Proc_Lua_Retain_Object, 
    release_object  : Proc_Lua_Release_Object,

    set_user_value  : Proc_Lua_Set_User_Value,
    get_user_value  : Proc_Lua_Get_User_Value,

    call_function_deprecated    : Proc_Lua_Call_Function_Deprecated,
    call_function               : Proc_Lua_Call_Function,
}
