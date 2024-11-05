@echo off

set game_name=game
set assets_dir=assets

if not defined PLAYDATE_SDK_PATH (
    echo "environment variable PLAYDATE_SDK_PATH not defined."
    exit 1
)

:: Prepare output directories
if not exist ".\out_sim\intermediate\" mkdir ".\out_sim\intermediate"
if not exist ".\out_sim\bin\" mkdir ".\out_sim\bin\"

:: Build the game DLL
odin build . -out:out_sim/intermediate/pdex.dll -build-mode:shared -define:DEFAULT_TEMP_ALLOCATOR_BACKING_SIZE=1048576 %*
if %ERRORLEVEL% neq 0 (
    echo "Odin build failed"
    exit 1
)

:: TODO: copy asset directory

:: Compile for the Playdate simulator
%PLAYDATE_SDK_PATH%\bin\pdc out_sim/intermediate/ out_sim/bin/%game_name%.pdx
if %ERRORLEVEL% neq 0 (
    echo "Playdate Compiler failed"
    exit 1
)

:: Run the simulator
%PLAYDATE_SDK_PATH%\bin\PlaydateSimulator out_sim/bin/%game_name%.pdx

