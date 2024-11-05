# Odin Build program for Playdate Simulator and (eventually) Playdate Device

!!! WARNING: Odin does not support the arm32 build target yet - device builds don't work !!!

Structure your project as follows:

```
Project_Root
| src          (dir)
| | main.odin
|
| intermediate (dir)
| | pdinfo
|
| out          (dir)
| build.odin
```

- Copy `build.odin` to your project's root directory
- Run `odin run .` for usage
- Run `odin run . -define:run_simulator=true` to build and run in the simulator
