package playdate_lua


// Adds the Lua function `fn` to the Lua runtime, with name `name`. 
// (`name` can be a table path using dots, e.g. if `name` = “mycode.myDrawingFunction” adds the function 
// “myDrawingFunction” to the global table “myCode”.) 
// 
// Returns `ok = true` on success; on failure, returns `ok = false` and an error message `err`. 
add_function :: #force_inline proc "contextless" (fn: C_Function, name: cstring) -> (err: cstring, ok: bool) {
    ok = bool(vtable.add_function(fn, name, &err))
    return
}

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
register_class :: #force_inline proc "contextless" (name: cstring, reg: []Reg, vals: []Value, is_static: bool) -> (err: cstring, ok: bool) {
    ok = bool(vtable.register_class(name, raw_data(reg), raw_data(vals), i32(is_static), &err))
    return 
}
          
// Pushes a C_Function onto the stack.  
push_function  :: #force_inline proc "contextless" (fn: C_Function) {
    vtable.push_function(fn)
}

// If a class includes an `__index` function, it should call this first to check if the indexed variable exists in the metatable. 
//
// If the `index_metatable()` call returns true, it has located the variable and put it on the stack, 
// and the `__index` function should return 1 to indicate a value was found. 
//
// If `index_metatable()` doesn’t find a value, the `__index` function can then do its custom getter magic.
index_metatable:: #force_inline proc "contextless" () -> bool {
    return bool(vtable.index_metatable())
}

// Stops the run loop.
stop           :: #force_inline proc "contextless" () {
    vtable.stop()
}

// Starts the run loop back up.
start          :: #force_inline proc "contextless" () {
    vtable.start()
}

// Returns the number of arguments passed to the function.
get_arg_count  :: #force_inline proc "contextless" () -> i32 {
    return vtable.get_arg_count()
}

// Returns the type of the variable at stack position pos. 
// If the type is `.Object` and `class` is non-nil, it returns the name of the object’s metatable.
get_arg_type   :: #force_inline proc "contextless" (pos: i32) -> (type: Type, class: cstring) {
    type = vtable.get_arg_type(pos, &class)
    return
}

// Returns true if the argument at position `pos` is nil.
arg_is_nil     :: #force_inline proc "contextless" (pos: i32) -> bool {
    return vtable.arg_is_nil(pos)
}

// Returns the argument at position `pos` as a bool.
get_arg_bool   :: #force_inline proc "contextless" (pos: i32) -> bool {
    return bool(vtable.get_arg_bool(pos))
}

// Returns the argument at position `pos` as an int.
get_arg_int    :: #force_inline proc "contextless" (pos: i32) -> i32 {
    return vtable.get_arg_int(pos)
}

// Returns the argument at position `pos` as a float.
get_arg_float  :: #force_inline proc "contextless" (pos: i32) -> f32 {
    return vtable.get_arg_float(pos)
}

// Returns the argument at position `pos` as a cstring.
get_arg_string :: #force_inline proc "contextless" (pos: i32) -> cstring {
    return vtable.get_arg_string(pos)
}

// Returns the argument at position `pos` as a byte slice.
get_arg_bytes  :: #force_inline proc "contextless" (pos: i32) -> []byte {
    length: i32
    ptr := vtable.get_arg_bytes(pos, &length)
    return ptr[:length]
}

// Checks the object type of the argument at position `pos` and returns a pointer to it 
// if it’s the correct type. Optionally returns a pointer to the opaque UD_Object for the given stack.
get_arg_object :: #force_inline proc "contextless" (pos: i32, type: cstring) -> (obj: rawptr, ud_obj: UD_Object) {
    obj = vtable.get_arg_object(pos, type, &ud_obj)
    return
}
              
// Returns the argument at position `pos` as a Bitmap.
get_bitmap     :: #force_inline proc "contextless" (pos: i32) -> Bitmap {
    return vtable.get_bitmap(pos)
}

// Returns the argument at position `pos` as a Sprite.
get_sprite     :: #force_inline proc "contextless" (pos: i32) -> Sprite {
    return vtable.get_sprite(pos)
}
   

// Pushes nil onto the stack. 
push_nil       :: #force_inline proc "contextless" () {
    vtable.push_nil()
}

// Pushes the bool `val` onto the stack.`
push_bool      :: #force_inline proc "contextless" (val: bool) {
    vtable.push_bool(i32(val))
}

// Pushes the int `val` onto the stack.`
push_int       :: #force_inline proc "contextless" (val: i32) {
    vtable.push_int(val)
}

// Pushes the float `val` onto the stack.`
push_float     :: #force_inline proc "contextless" (val: f32) {
    vtable.push_float(val)
}

// Pushes the cstring `str` onto the stack.`
push_string    :: #force_inline proc "contextless" (str: cstring) {
    vtable.push_string(val)
}

// Like `push_string()`, but pushes an arbitrary byte array to the stack, ignoring `\0` characters.
push_bytes     :: #force_inline proc "contextless" (bytes: []byte) {
    vtable.push_bytes(raw_ptr(val), i32(len(val)))
}

// Pushes the Bitmap `bitmap` onto the stack.
push_bitmap    :: #force_inline proc "contextless" (bitmap: Bitmap) {
    vtable.push_bitmap(bitmap)
}

// Pushes the Sprite `sprite` onto the stack.
push_sprite    :: #force_inline proc "contextless" (sprite: Sprite) {
    vtable.push_sprite(sprite)
}
              
// Pushes the Pushes the given custom object `obj` onto the stack and returns a handle to the opaque UD_Object. 
// 
// `type` must match the class name used in `lua.register_class()`. `n_values` is the number of slots to allocate for 
// Lua values (see `set/get_object_value()`). 
push_object    :: #force_inline proc "contextless" (obj: rawptr, type: cstring, n_values: i32) -> UD_Object {
    return vtable.push_object(obj, type, n_values)
}


// Retains the opaque UD_Object `obj` and returns same.
retain_object  :: #force_inline proc "contextless" (obj: UD_Object) -> UD_Object {
    return vtable.retain_object(obj)
}

// Releases the opaque UD_Object `obj`.
release_object :: #force_inline proc "contextless" (obj: UD_Object) {
    vtable.release_object(obj)
}

// Sets the value of object `obj`'s uservalue slot number `slot` (starting at 1, not zero) to the value at the top of the stack.
set_user_value :: #force_inline proc "contextless" (obj: UD_Object, slot: u32) {
    vtable.set_user_value(obj, slot)
}

// Copies the value at `obj`'s given uservalue slot to the top of the stack and returns its stack position.
get_user_value :: #force_inline proc "contextless" (obj: UD_Object, slot: u32) -> i32 {
    return vtable.get_user_value(obj, slot)
}

// Calls the Lua function `name` and and indicates that `n_args` number of arguments have already been pushed to the stack for the function to use. 
// 
// `name` can be a table path using dots, e.g. “playdate.apiVersion”. 
// 
// Returns `ok = true` on success; on failure, returns `ok = false` and an error message `err`. 
// 
// Calling Lua from C is slow, so use sparingly.
call_function :: #force_inline proc "contextless" (name: cstring, n_args: i32) -> (err: cstring, ok: bool) {
    ok = bool(vtable.call_function(name, n_args, &err))
    return
}