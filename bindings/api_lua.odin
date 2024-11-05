package playdate_bindings

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

Api_Lua_Procs :: struct {
    add_function               : proc "c" (f: Lua_C_Function, name: cstring, out_err: ^cstring) -> i32,
    register_class             : proc "c" (name: cstring, reg: [^]Lua_Reg, vals: [^]Lua_Value, is_static: b32, out_err: ^cstring) -> i32,

    push_function              : proc "c" (f: Lua_C_Function),
    index_metatable            : proc "c" () -> i32,

    stop                       : proc "c" (),
    start                      : proc "c" (),

    get_arg_count              : proc "c" () -> i32,
    get_arg_type               : proc "c" (pos: i32, out_class: ^cstring) -> Lua_Type,
    arg_is_nil                 : proc "c" (pos: i32) -> i32,
    get_arg_bool               : proc "c" (pos: i32) -> i32,
    get_arg_int                : proc "c" (pos: i32) -> i32,
    get_arg_float              : proc "c" (pos: i32) -> f32,
    get_arg_string             : proc "c" (pos: i32) -> cstring,
    get_arg_bytes              : proc "c" (pos: i32, out_len: ^u32) -> [^]byte,
    get_arg_object             : proc "c" (pos: i32, type: cstring, out_ud: ^Lua_UD_Object) -> rawptr,

    get_bitmap                 : proc "c" (pos: i32) -> Bitmap,
    get_sprite                 : proc "c" (pos: i32) -> Sprite,

    push_nil                   : proc "c" (),
    push_bool                  : proc "c" (val: i32),
    push_int                   : proc "c" (val: i32),
    push_float                 : proc "c" (val: f32),
    push_string                : proc "c" (str: cstring),
    push_bytes                 : proc "c" (bytes: [^]byte, length: u32),
    push_bitmap                : proc "c" (bitmap: Bitmap),
    push_sprite                : proc "c" (sprite: Sprite),

    push_object                : proc "c" (obj: rawptr, type: cstring, n_values: i32) -> Lua_UD_Object,
    retain_object              : proc "c" (obj: Lua_UD_Object) -> Lua_UD_Object,
    release_object             : proc "c" (obj: Lua_UD_Object),

    set_user_value             : proc "c" (obj: Lua_UD_Object, slot: u32),
    get_user_value             : proc "c" (obj: Lua_UD_Object, slot: u32) -> i32,

    call_function_deprecated   : proc "c" (name: cstring, n_args: i32),
    call_function              : proc "c" (name: cstring, n_args: i32, out_err: ^cstring) -> i32,
}

// =================================================================

