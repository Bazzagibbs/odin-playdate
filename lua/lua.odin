package playdate_lua

import "../common"
import ".."

State :: common.Lua_State

UD_Object :: common.Lua_UD_Object
Value_Type :: common.Lua_Value_Type
Reg :: common.Lua_Reg
Type :: common.Lua_Type
Value :: common.Lua_Value


// =================================================================

// Adds the Lua function `fn` to the Lua runtime, with name `name`. 
// (`name` can be a table path using dots, e.g. if `name` = “mycode.myDrawingFunction” adds the function 
// “myDrawingFunction” to the global table “myCode”.) 
// 
// Returns `ok = true` on success; on failure, returns `ok = false` and an error message `err`. 
add_function  : common.Proc_Lua_Add_Function 

// Creates a new "class" (i.e., a Lua metatable containing functions) 
// with the given name and adds the given functions and constants to it. 
//
// If the table is simply a list of functions that won’t be used as a metatable, 
// `isstatic` should be set to true to create a plain table instead of a metatable. 
//
// Returns `ok = true` on success; on failure, returns `ok = false` and an error message `err`. 
//
// Please see `C_API/Examples/Array` for an example of how to use `register_class` 
// to create a Lua table-like object from C.
//
// WARNING: `reg` and `vals` must be nil-terminated.
register_class  : common.Proc_Lua_Register_Class 
          
// Pushes a C_Function onto the stack.  
push_function   : common.Proc_Lua_Push_Function  

// If a class includes an `__index` function, it should call this first to check if the indexed variable exists in the metatable. 
//
// If the `index_metatable()` call returns true, it has located the variable and put it on the stack, 
// and the `__index` function should return 1 to indicate a value was found. 
//
// If `index_metatable()` doesn’t find a value, the `__index` function can then do its custom getter magic.
index_metatable : common.Proc_Lua_Index_Metatable

// Stops the run loop.
stop            : common.Proc_Lua_Stop           

// Starts the run loop back up.
start           : common.Proc_Lua_Start          

// Returns the number of arguments passed to the function.
get_arg_count   : common.Proc_Lua_Get_Arg_Count  

// Returns the type of the variable at stack position pos. 
// If the type is `.Object` and `class` is non-nil, it returns the name of the object’s metatable.
get_arg_type    : common.Proc_Lua_Get_Arg_Type   

// Returns true if the argument at position `pos` is nil.
arg_is_nil      : common.Proc_Lua_Arg_Is_Nil     

// Returns the argument at position `pos` as a bool.
get_arg_bool    : common.Proc_Lua_Get_Arg_Bool   

// Returns the argument at position `pos` as an int.
get_arg_int     : common.Proc_Lua_Get_Arg_Int    

// Returns the argument at position `pos` as a float.
get_arg_float   : common.Proc_Lua_Get_Arg_Float  

// Returns the argument at position `pos` as a cstring.
get_arg_string  : common.Proc_Lua_Get_Arg_String 

// Returns the argument at position `pos` as a byte slice.
get_arg_bytes   : common.Proc_Lua_Get_Arg_Bytes  

// Checks the object type of the argument at position `pos` and returns a pointer to it 
// if it’s the correct type. Optionally returns a pointer to the opaque UD_Object for the given stack.
get_arg_object  : common.Proc_Lua_Get_Arg_Object 
              
// Returns the argument at position `pos` as a Bitmap.
get_bitmap      : common.Proc_Lua_Get_Bitmap     

// Returns the argument at position `pos` as a Sprite.
get_sprite      : common.Proc_Lua_Get_Sprite     
   

// Pushes nil onto the stack. 
push_nil        : common.Proc_Lua_Push_Nil       

// Pushes the bool `val` onto the stack.`
push_bool       : common.Proc_Lua_Push_Bool      

// Pushes the int `val` onto the stack.`
push_int        : common.Proc_Lua_Push_Int       

// Pushes the float `val` onto the stack.`
push_float      : common.Proc_Lua_Push_Float     

// Pushes the cstring `str` onto the stack.`
push_string     : common.Proc_Lua_Push_String    

// Like `push_string()`, but pushes an arbitrary byte array to the stack, ignoring `\0` characters.
push_bytes      : common.Proc_Lua_Push_Bytes     

// Pushes the Bitmap `bitmap` onto the stack.
push_bitmap     : common.Proc_Lua_Push_Bitmap    

// Pushes the Sprite `sprite` onto the stack.
push_sprite     : common.Proc_Lua_Push_Sprite    
              
// Pushes the Pushes the given custom object `obj` onto the stack and returns a handle to the opaque UD_Object. 
// 
// `type` must match the class name used in `lua.register_class()`. `n_values` is the number of slots to allocate for 
// Lua values (see `set/get_object_value()`). 
push_object     : common.Proc_Lua_Push_Object    


// Retains the opaque UD_Object `obj` and returns same.
retain_object   : common.Proc_Lua_Retain_Object  

// Releases the opaque UD_Object `obj`.
release_object  : common.Proc_Lua_Release_Object 

// Sets the value of object `obj`'s uservalue slot number `slot` (starting at 1, not zero) to the value at the top of the stack.
set_user_value  : common.Proc_Lua_Set_User_Value 

// Copies the value at `obj`'s given uservalue slot to the top of the stack and returns its stack position.
get_user_value  : common.Proc_Lua_Get_User_Value 

// Calls the Lua function `name` and and indicates that `n_args` number of arguments have already been pushed to the stack for the function to use. 
// 
// `name` can be a table path using dots, e.g. “playdate.apiVersion”. 
// 
// Returns `ok = true` on success; on failure, returns `ok = false` and an error message `err`. 
// 
// Calling Lua from C is slow, so use sparingly.
call_function  : common.Proc_Lua_Call_Function 



// =================================================================


//   /////////////////
//  // LOADER PROC //
// /////////////////

// Position in PlaydateAPI struct (see pd_api.h)
API_INDEX :: 6

@(init)
_register :: proc() {
    playdate._loaders[API_INDEX] = _load_procs
}

_load_procs :: proc "contextless" (api: ^playdate.Api) {

}
