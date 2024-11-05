# Odin-Playdate

##  ⚠️⚠️ WORK IN PROGRESS ⚠️⚠️ Not ready for production

Up to date with Playdate SDK version 2.6

Odin-lang API bindings for the [Playdate SDK](https://play.date/dev/), used to develop games for the Playdate handheld game system.

While this package is documented, the original [C API documentation can be found here](https://sdk.play.date/2.6.0/Inside%20Playdate%20with%20C.html).

## Differences from the C API

This package can be used in the same manner as the C API, or the procedures can be loaded into Odin-style packages.

Note: Odin-style packages are incomplete and subject to breaking changes. If stability is important, use the C API bindings.

```odin
import "playdate"
import "playdate/graphics"

pd: ^playdate.Api

my_load_font :: proc () {
    // C bindings
    err: cstring
    my_font := pd.graphics.load_font("my/font/path", &out_err)

    // Odin-style wrapper
    my_font, err := graphics.load_font("my/font/path")
}
```

## Other features

- Custom allocator for Playdate memory allocations (`new()`, `make()`, etc should work as expected)
- Custom logger for Playdate logging system (`core:log` procedures should work as expected)

## Prerequisites

1. Download the [Playdate SDK](https://play.date/dev/) for your development platform. 
2. Make sure you have the `PLAYDATE_SDK_PATH` environment variable set to the directory you installed it to.

## Creating a Playdate application

WIP - Expected to change

Playdate applications are libraries that export the following procedure:

```odin
@(export)
eventHandler :: proc "c" (pd_api: ^playdate.Api, event: playdate.System_Event, arg: u32) -> i32 {}
```

Create a context that uses the Playdate's allocator:

```odin
import "base:runtime"
import "playdate"
import "core:log"

global_ctx : runtime.Context

my_init :: proc "contextless" (pd: ^playdate.Api) {
    global_ctx = playdate.default_context(pd)
}


update :: proc "c" (user_data: rawptr) -> playdate.Update_Result {
    context = global_ctx

    my_slice := make([]string, 99) // allocates using pd.system.realloc
    delete(my_slice)

    log.info("Hellope") // logs to Playdate console
}
```

From here, follow the official Playdate C guide for Game Initialization.

## Compiling for the Playdate

WIP - Expected to change

### Option A: Build scripts

1. Copy the build scripts from `playdate/_scripts` to the root directory of your project. 
2. Add the directories `out_sim` and `out_device` to your .gitignore file.

### Option B: Manual

1. Create an intermediate directory that the shared library will be compiled into, and an output directory, e.g. "./intermediate/" and "./out/"
2. Compile your Odin project into your intermediate directory with the `-build-mode:shared` option (and `-debug` if desired)
```sh
odin build . -out=intermediate/pdex.dll -build-mode:shared
```
3. Compile the intermediate directory using the Playdate Compiler, into your output directory
```sh
$PLAYDATE_SDK_PATH/bin/pdc intermediate/ out/Game_Name.pdx
```
4. Run the simulator with your game
```sh
$PLAYDATE_SDK_PATH/bin/PlaydateSimulator out/Game_Name.pdx
```


## Contributing

Please feel free to contribute! Here is the current implementation status of each API feature:

- ➕ Implemented
- ➖ Partially implemented (see Notes)
- ❌ Not implemented

| Package       | C bindings | Odin-style wrapper | Tests   | Notes |
|---------------|:----------:|:------------------:|:-------:|-------|
| `display`     | ➕         | ➕                 | ❌      |       |
| `file`        | ➕         | ➕                 | ❌      |       |
| `graphics`    | ➕         | ➕                 | ❌      |       |
| `json`        | ➕         | ❌                 | ❌      | Need someone to see if it's functional |
| `lua`         | ➕         | ❌                 | ❌      | `register_class` is unsafe, See issue #12|
| `scoreboards` | ➕         | ➕                 | ❌      | Can't test/no documentation - only approved games can use Scoreboards API |
| `sound`       | ➕         | ❌                 | ❌      |       |
| `sprite`      | ➕         | ❌                 | ❌      | Sprite update and draw callbacks are contextless. |
| `system`      | ➕         | ❌                 | ❌      | Documentation comments may be slightly inaccurate, needs double checking |


## Other notes

- `pd->lua->registerClass()` takes two null-terminated arrays as parameters (yuck), I'd like to instead be able to pass slices and enforce the null terminators
