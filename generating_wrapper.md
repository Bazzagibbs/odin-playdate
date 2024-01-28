# Generating wrapper code

This could be done programatically, but it's easier to do it in editor since a lot
of work has already been done manually (docs, replacing types)

This document is also


## Vim macro for changing `Proc_type_names` to `Proc_Type_Names`

```
qp                                   // Record macro to @p      
fPviw                                // find 'P' and visual select its word (we're looking for Proc_...)
:'<,'>s/\%V_\(\w\)/_\u\1\e/g   <RET> // substitute only visual selected, "_<letter>" with "_<UpperLetter>" until end of line
<ESC>q                               // finish recording macro
```
use the macro by moving to a line and @p
NOTE: change the line `fPviw` to `viw` if the Proc_ is the first character on the line.


## Aligning types/assignments using mini.align

visual select the contents to align
```
ga <wait 1s>                         // Begin align tool
s <separator>   <RET>                // Split by a symbol, e.g. "::" in "my_proc :: proc(foo: int) {}"
```

## Generating `Api_Procs` struct

TODO


## Generating `_load_procs()`

Copy the body of `Api_Procs` struct into a new proc, `_load_procs :: proc(api_procs: ^Api_Procs)`
Visual select the body
```
:'<,'>s/\(\w\+\)\s\+: Proc_\w\+,/\1 = api_procs.\1

:'<,'>s/                                             // Substitute on selected line
        \(w\+\)                                      // Store backreference of the proc name, e.g. "my_proc"
               \s\+:                                 // discard whitespace and ":"
                     Proc_\w\+,/                     // discard the Proc_... type
                                \1 = api_procs.\1    // replace the line with the new format, "my_proc = api_procs.my_proc"
```
Align using mini.align (or manually)
