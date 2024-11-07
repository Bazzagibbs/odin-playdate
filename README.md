# Odin-Playdate

Up to date with Playdate SDK version 2.6

Odin-lang API bindings for the [Playdate SDK](https://play.date/dev/), used to develop games for the Playdate handheld game system.

## Additional features

- Custom allocator for Playdate memory allocations (`new()`, `make()`, etc should work as expected)
- Custom logger for Playdate logging system (`core:log` procedures should work as expected)

## Prerequisites

1. Download the [Playdate SDK](https://play.date/dev/) for your development platform. 
2. Make sure you have the `PLAYDATE_SDK_PATH` environment variable set to the directory you installed it to.

## Creating a Playdate application

WIP - Expected to change

#### Export the Playdate event handler procedure:

```odin
@(export)
eventHandler :: proc "c" (pd_api: ^playdate.Api, event: playdate.System_Event, arg: u32) -> i32 {}
```

#### Create a context that uses the Playdate's allocator:

```odin
import "base:runtime"
import "playdate"
import "core:log"

global_ctx : runtime.Context

// Call on eventHandler .Init
my_init :: proc "contextless" (pd: ^playdate.Api) {
    global_ctx = playdate.playdate_context_create(pd)
}

// Call on eventHandler .Terminate
my_terminate :: proc "contextless" () {
    playdate.playdate_context_destroy(&global_ctx)
}


update :: proc "c" (user_data: rawptr) -> playdate.Update_Result {
    context = global_ctx

    my_slice := make([]string, 99) // allocates using pd.system.realloc
    delete(my_slice)

    log.info("Hellope") // logs to Playdate console

    return .Update_Display
}
```

From here, follow the official Playdate C guide for Game Initialization.

## Compiling for the Playdate

WIP - Expected to change

#### Option A: Build scripts

1. Copy the build scripts from `playdate/_scripts` to the root directory of your project. 
2. Add the directories `out_sim` and `out_device` to your .gitignore file.

#### Option B: Manual

1. Create an intermediate directory that the shared library will be compiled into, and an output directory, e.g. "./intermediate/" and "./out/"
2. Compile your Odin project into your intermediate directory as a shared library with no default allocators
```sh
odin build . -out=intermediate/pdex.dll -build-mode:shared -default-to-nil-allocator
```
3. Compile the intermediate directory using the Playdate Compiler, into your output directory
```sh
$PLAYDATE_SDK_PATH/bin/pdc intermediate/ out/Game_Name.pdx
```
4. Run the simulator with your game
```sh
$PLAYDATE_SDK_PATH/bin/PlaydateSimulator out/Game_Name.pdx
```

Note: if you don't need a temporary allocator or you need as much memory as possible, the following Odin build flags are available:

- `-define:NO_PLAYDATE_TEMP_ALLOCATOR` to not create a temporary allocator with `playdate_context_create` (you can provide your own later)
- `-define:DEFAULT_TEMP_ALLOCATOR_BACKING_SIZE=<n_bytes>` to resize the default temporary allocator arena (default: 4MB, with provided build script: 1MB)


## Contributing

Please feel free to contribute! Here is the current implementation status of each API feature:

- ➕ Implemented
- ➖ Partially implemented (see Notes)
- ❌ Not implemented

| Package       | C bindings | Tests   | Notes |
|---------------|:----------:|:-------:|-------|
| `display`     | ➕         | ❌      |       |
| `file`        | ➕         | ❌      |       |
| `graphics`    | ➕         | ❌      |       |
| `json`        | ➕         | ❌      |       |
| `lua`         | ➕         | ❌      |       |
| `scoreboards` | ➕         | ❌      | Only approved games can use Scoreboards API |
| `sound`       | ➕         | ❌      |       |
| `sprite`      | ➕         | ❌      |       |
| `system`      | ➕         | ❌      |       |


