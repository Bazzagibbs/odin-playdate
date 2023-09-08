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
2. Make sure you have the `PLAYDATE_SDK` environment variable set to the directory you installed it to.

## Creating a Playdate application

WIP

## Compiling for the Playdate

WIP

## Contributing

Please feel free to contribute! Here is the current implementation status of each API feature:

- ➕ Implemented
- ➖ Partially implemented (see Notes)
- ❌ Not implemented

| Package       | C bindings | Odin-ified | Notes |
|---------------|:----------:|:----------:|-------|
| `display`     |  ➕        |  ➕        | Untested |
| `file`        |  ➕        |  ➕        | Untested |
| `graphics`    |  ➕        |  ➕        |       |
| `json`        |  ❌        |  ❌        |       |
| `lua`         |  ❌        |  ❌        |       |
| `scoreboards` |  ❌        |  ➖        |       |
| `sound`       |  ❌        |  ❌        |       |
| `sprite`      |  ❌        |  ❌        |       |
| `system`      |  ➕        |  ➖        | Callbacks still take `userdata` pointers. MenuItem callbacks are contextless. |