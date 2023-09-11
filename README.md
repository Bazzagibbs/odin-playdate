# Odin-Playdate

Up to date with Playdate SDK version 2.0.3

Odin-lang API bindings for the [Playdate SDK](https://play.date/dev/), used to develop games for the Playdate handheld game system.

While this package is documented, the original [C API documentation can be found here](https://sdk.play.date/2.0.3/Inside%20Playdate%20with%20C.html).

## Differences from the C API

Some minor changes have been made to make use of Odin's features: 

- Odin-style import packages: instead of `pd->graphics->video->foo()` syntax, prefer
```odin
import "playdate/graphics/video"
video.foo()
```
- Procedures with `out` parameters instead use multiple return values.
- `int` success/fail return flags instead use `(ok: bool)` returns.
- Procedures that encode a failure state as a specific value (e.g. "Returns -1 on failure") now also return `ok = false` in addition to the encoded state
- Procedures that take a buffer pointer + length to populate (e.g. `file.read(...)`) instead take a slice
- Procedures that take a `void *userdata` parameter instead support `context.user_ptr`

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
eventHandler :: proc "c" (pd_api: ^playdate.Api, event: playdate.System_Event, arg: u32) -> i32
```

The API can be used in two ways:
 - By loading the function pointers into the package's vtables with `playdate.init(pd_api)`.
 - As you would with the C api by passing the `pd_api` handle as userdata.

 Using the latter option may be more difficult and many Odin features will not be available.

`playdate.init()` captures its context and uses it for callbacks where possible, so make sure your context is set up before it is called.

## Compiling for the Playdate

WIP - Expected to change

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

| Package       | C bindings | Odin-ified | Tests | Notes |
|---------------|:----------:|:----------:|:-----:|-------|
| `display`     |  ➕        |  ➕        | ❌   |       |
| `file`        |  ➕        |  ➕        | ❌   |       |
| `graphics`    |  ➕        |  ➕        | ❌   |       |
| `json`        |  ➕        |  ➖        | ❌   | Need someone to see if it's functional |
| `lua`         |  ➕        |  ➖        | ❌   | `register_class` is unsafe, See issue #12|
| `scoreboards` |  ➕        |  ➖        | ❌   | Can't test/no documentation - only approved games can use Scoreboards API |
| `sound`       |  ❌        |  ❌        | ❌   |       |
| `sprite`      |  ➕        |  ➖        | ❌   | Sprite update and draw callbacks are contextless. |
| `system`      |  ➕        |  ➖        | ❌   | Callbacks still take `userdata` pointers. MenuItem callbacks are contextless. |


## Other notes

- `pd->lua->registerClass()` takes two null-terminated arrays as parameters (yuck), I'd like to instead be able to pass slices and enforce the null terminators