// Build script overview:
// - Find Playdate SDK path
// - Make sure output directories exist
// - Call "odin build" on the source directory with the required arguments depending on build target
// - Call "pdc <intermediate> <output>"
// - Run the simulator with the built program if requested

// This is a little overkill for just the simulator, but I think it will be useful if/when Odin gets arm32 build support

package adrastea_program

USAGE :: `Copy this build script to your project's root level directory.

!!!!! WARNING: Odin does not support arm32 targets yet - device builds don't work !!!!!

Usage: odin run . [optional_arguments] 
Optional arguments:
     -debug

  Build targets
     -define:build_device=false                  Builds for Playdate hardware.
     -define:build_simulator=false               Builds for the Playdate simulator.
     -define:run_simulator=false                 Builds and runs the program in the Playdate simulator.
 
  Files and Directories
     -define:name="root_directory_name"          Sets the filename of the output program.
     -define:source_dir="src"                    Sets the program's source code directory.
     -define:intermediate_dir="intermediate"     Sets the intermediate directory (shared library and program metadata).
     -define:output_dir="out"                    Sets the output directory. Includes .pdx file.
     -define:simulator_subdir="simulator"        Sets the subdirectory for storing simulator files: "intermediate/simulator/".
     -define:device_subdir="device"              Sets the subdirectory for storing device files: "intermediate/device/".
`


import "core:c/libc"
import "core:fmt"
import "core:os"
import "core:strings"

PROGRAM_NAME     :: #config(name, ODIN_BUILD_PROJECT_NAME)

// Targets
SIMULATOR_RUN    :: #config(run_simulator, false)
SIMULATOR_BUILD  :: #config(build_simulator, false) || SIMULATOR_RUN
DEVICE_BUILD     :: #config(build_device, false)

// Directories
SOURCE_DIR       :: #config(source_dir, "src")
INTERMEDIATE_DIR :: #config(intermediate_dir, "intermediate")
OUTPUT_DIR       :: #config(output_dir, "out")
SIMULATOR_SUBDIR :: #config(simulator_subdir, "simulator")
DEVICE_SUBDIR    :: #config(device_subdir, "simulator")


// Build flags
BUILD_FLAGS_COMMON :: []string {
    "-build-mode:shared", 
    "-default-to-nil-allocator", // Playdate only has 16MB of memory, the default temporary allocator has 4MB backing :(
}

BUILD_FLAGS_DEVICE :: []string {
    "-target:freestanding_arm32", // this doesn't exist yet
}

BUILD_FLAGS_SIMULATOR :: []string {}


when ODIN_OS == .Windows {
    SHARED_EXT :: "dll"
} else when ODIN_OS == .Darwin || ODIN_OS == .Linux {
    SHARED_EXT :: "so"
}


path_sdk     : string
path_int_sim : cstring
path_out_sim : cstring
path_int_dev : cstring
path_out_dev : cstring


main :: proc() {
    context.allocator = context.temp_allocator

    when !DEVICE_BUILD && !SIMULATOR_BUILD {
        fmt.print(USAGE)
        return
    }


    // Find Playdate SDK
    path_sdk = os.get_env("PLAYDATE_SDK_PATH")
    if (path_sdk == {}) {
        panic("PLAYDATE_SDK_PATH environment variable not defined.")
    }

    prepare_directories()


    when DEVICE_BUILD {
        build_device()
    }
  

    when SIMULATOR_BUILD {
        build_simulator()
    }


    when SIMULATOR_RUN {
        run_simulator()
    }


    return 
}



prepare_directories :: proc() {
    sb := strings.builder_make()

    err: os.Errno

    when SIMULATOR_BUILD {
        // int_sim
        fmt.sbprintf(&sb, "%v/%v", INTERMEDIATE_DIR, SIMULATOR_SUBDIR)
        path_int_sim = strings.clone_to_cstring(strings.to_string(sb))
    
        if !os.is_dir(strings.to_string(sb)) {
            err = os.make_directory(strings.to_string(sb))
            if err != 0 {
                panic("Error creating directory int/sim")
            }
        }

        strings.builder_reset(&sb)

        // out_sim
        fmt.sbprintf(&sb, "%v/%v", OUTPUT_DIR, SIMULATOR_SUBDIR)
        path_out_sim = strings.clone_to_cstring(strings.to_string(sb))
       
        if !os.is_dir(strings.to_string(sb)) {
            err = os.make_directory(strings.to_string(sb))
            if err != 0 {
                panic("Error creating directory out/sim")
            }
        }
       
        strings.builder_reset(&sb)
    }

    when DEVICE_BUILD {
        // int_dev
        fmt.sbprintf(&sb, "%v/%v", INTERMEDIATE_DIR, DEVICE_SUBDIR)
        path_int_dev = strings.clone_to_cstring(strings.to_string(sb))

        if !os.is_dir(strings.to_string(sb)) {
            err = os.make_directory(strings.to_string(sb))
            if err != 0 {
                panic("Error creating directory int/dev")
            }
        }
        strings.builder_reset(&sb)

        // out_dev
        fmt.sbprintf(&sb, "%v/%v", OUTPUT_DIR, DEVICE_SUBDIR)
        path_out_dev = strings.clone_to_cstring(strings.to_string(sb))
        
        if !os.is_dir(strings.to_string(sb)) {
            err = os.make_directory(strings.to_string(sb))
            if err != 0 {
                panic("Error creating directory out/sim")
            }
        }
    }
}



build_device :: proc() {
    fmt.println("Building for device - NOT IMPLEMENTED: Odin does not currently support ARM32 build targets.")
}



build_simulator :: proc() {
    fmt.println("Building for simulator")
    
    sb := strings.builder_make()

    // Make directory paths


    
    // Prepare Odin build command
    fmt.sbprintf(&sb, "odin build %v", SOURCE_DIR)
    
    fmt.sbprintf(&sb, " -out:%v/pdex.%v", path_int_sim, SHARED_EXT)
    
    for flag in BUILD_FLAGS_COMMON {
        fmt.sbprint(&sb, "", flag)
    }
    
    for flag in BUILD_FLAGS_SIMULATOR {
        fmt.sbprint(&sb, "", flag)
    }

    when ODIN_DEBUG {
        fmt.sbprint(&sb, " -debug")
    }
    

    // Execute Odin build
    odin_build_command := strings.clone_to_cstring(strings.to_string(sb))
    fmt.println(">", strings.to_string(sb))
    result := libc.system(odin_build_command)
    if result != 0 {
        panic("Odin DLL build failed")
    }


    // Prepare Playdate build command
    strings.builder_reset(&sb)
    fmt.sbprintf(&sb, "%v/bin/pdc %v %v/%v.pdx", path_sdk, path_int_sim, path_out_sim, PROGRAM_NAME)
    
    // Execute Playdate build
    pd_build_command := strings.clone_to_cstring(strings.to_string(sb))
    fmt.println(">", strings.to_string(sb))
    result = libc.system(pd_build_command)
    if result != 0 {
        panic("Playdate pdx build failed")
    }
}



run_simulator :: proc() {
    fmt.println("Running simulator")

    sb := strings.builder_make()

    fmt.sbprintf(&sb, "%v/bin/PlaydateSimulator %v/%v.pdx", path_sdk, path_out_sim, PROGRAM_NAME)
    fmt.println(">", strings.to_string(sb))

    pd_sim_command := strings.clone_to_cstring(strings.to_string(sb))
    result := libc.system(pd_sim_command)
    if result != 0 {
        panic("Error while running Playdate Simulator")
    }
}


