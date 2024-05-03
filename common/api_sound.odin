package playdate_common

//   ///////////
//  // TYPES //
// ///////////

// =================================================================


//   ////////////////
//  // PROC TYPES //
// ////////////////

Proc_Sound_get_current_time    :: #type proc "c" () -> u32
Proc_Sound_add_source          :: #type proc "c" (Audio_Source_Proc, rawptr, i32) -> Source
Proc_Sound_get_default_channel :: #type proc "c" () -> Channel
Proc_Sound_add_channel         :: #type proc "c" (Channel) -> i32
Proc_Sound_remove_channel      :: #type proc "c" (Channel) -> i32
Proc_Sound_set_mic_callback    :: #type proc "c" (Record_Callback, rawptr, i32)
Proc_Sound_get_headphone_state :: #type proc "c" (^i32, ^i32, Change_Callback)
Proc_Sound_set_outputs_active  :: #type proc "c" (i32, i32)

// =================================================================


//   ////////////////
//  // API STRUCT //
// ////////////////

Api_Sound_Procs :: struct {
    channel:        ^Api_Sound_Channel_Procs,
    file_player:    ^Api_Sound_File_Player_Procs,
    sample:         ^Api_Sound_Sample_Procs,
    sample_player:  ^Api_Sound_Sample_Player_Procs,
    synth:          ^Api_Sound_Synth_Procs,
    sequence:       ^Api_Sound_Sequence_Procs,
    effect:         ^Api_Sound_Effect_Procs,
    lfo:            ^Api_Sound_LFO_Procs,
    envelope:       ^Api_Sound_Envelope_Procs,
    source:         ^Api_Sound_Source_Procs,
    control_signal: ^Api_Sound_Control_Signal_Procs,
    track:          ^Api_Sound_Track_Procs,
    instrument:     ^Api_Sound_Instrument_Procs,

    get_current_time:    #type proc "c" () -> u32,
    add_source:          #type proc "c" (Audio_Source_Proc, rawptr, i32) -> Source,
    get_default_channel: #type proc "c" () -> Channel,
    add_channel:         #type proc "c" (Channel) -> i32,
    remove_channel:      #type proc "c" (Channel) -> i32,
    set_mic_callback:    #type proc "c" (Record_Callback, rawptr, i32),
    get_headphone_state: #type proc "c" (^i32, ^i32, Change_Callback),
    set_outputs_active:  #type proc "c" (i32, i32),

    remove_source: #type proc "c" (Source) -> i32,

    signal: ^Api_Sound_Signal_Procs,
}


