package playdate_bindings

display     : ^Api_Display_Procs
file        : ^Api_File_Procs
graphics    : ^Api_Graphics_Procs
json        : ^Api_Json_Procs
lua         : ^Api_Lua_Procs
scoreboards : ^Api_Scoreboards_Procs
sound       : ^Api_Sound_Procs
sprite      : ^Api_Sprite_Procs
system      : ^Api_System_Procs


load_procs :: proc "contextless" (api: ^Api) {
    display     = api.display
    file        = api.file
    graphics    = api.graphics
    json        = api.json
    lua         = api.lua
    scoreboards = api.scoreboards
    sound       = api.sound
    sprite      = api.sprite
    system      = api.system
}
