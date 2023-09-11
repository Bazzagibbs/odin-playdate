package playdate_sound

import "../common"

AUDIO_FRAMES_PER_CYCLE :: 512

Source              :: distinct common.Handle
Synth               :: distinct common.Handle
Synth_Instrument    :: distinct common.Handle
Synth_LFO           :: distinct common.Handle
Synth_Envelope      :: distinct common.Handle
Synth_Signal_Value  :: distinct common.Handle
Synth_Signal        :: distinct common.Handle
Control_Signal      :: distinct common.Handle
Sequence_Track      :: distinct common.Handle
Sequence            :: distinct common.Handle
Two_Pole_Filter     :: distinct common.Handle
One_Pole_Filter     :: distinct common.Handle
Bit_Crusher         :: distinct common.Handle
Ring_Modulator      :: distinct common.Handle
Delay_Line          :: distinct common.Handle
Delay_Line_Tap      :: distinct common.Handle
Overdrive           :: distinct common.Handle
Effect              :: distinct common.Handle
Channel             :: distinct common.Handle


MIDI_Note           :: distinct f32 
NOTE_C4             : MIDI_Note : 60

Format :: enum {
    mono_8_bit      = 0,
    stereo_8_bit    = 1,
    mono_16_bit     = 2,
    stereo_16_bit   = 3,
    mono_ADPCM      = 4,
    stereo_ADPCM    = 5,
}

LFO_Type :: enum {
    square,
    triangle,
    sample_and_hold,
    sawtooth_up,
    sawtooth_down,
    arpeggiator,
    function,
}

Waveform :: enum {
    square,
    triangle,
    sine,
    noise,
    sawtooth,
    po_phase,
    po_digital,
    po_vosim,
}

Two_Pole_Filter_Type :: enum {
    low_pass,
    high_pass,
    band_pass,
    notch,
    peq,
    low_shelf,
    high_shelf,
}

Callback_Proc               :: #type proc "c" (source: Source)

Signal_Step_Proc            :: #type proc "c" (user_data: rawptr, io_frames: ^i32, if_val: ^f32) -> f32
Signal_Note_On_Proc         :: #type proc "c" (user_data: rawptr, note: MIDI_Note, velocity, length: f32)
Signal_Note_Off_Proc        :: #type proc "c" (user_data: rawptr, stopped, offset: i32)
Signal_Dealloc_Proc         :: #type proc "c" (user_data: rawptr)

Synth_Render_Proc           :: #type proc "c" (user_data: rawptr, left, right: ^i32, n_samples: i32, rate: u32, d_rate: i32) -> i32
Synth_Note_On_Proc          :: #type proc "c" (user_data: rawptr, note: MIDI_Note, velocity, length: f32)
Synth_Release_Proc          :: #type proc "c" (user_data: rawptr, stop: i32)
Synth_Set_Parameter_Proc    :: #type proc "c" (user_data: rawptr, parameter: i32, value: f32)
Synth_Dealloc_Proc          :: #type proc "c" (user_data: rawptr)

Sequence_Finished_Callback  :: #type proc "c" (seq: Sequence, user_data: rawptr)

Effect_Proc                 :: #type proc "c" (effect: Effect, left, right: ^i32, n_samples, buf_active: i32) -> i32
Audio_Source_Proc           :: #type proc "c" (ctx: rawptr, left, right: ^i16, length: i32) -> i32
Record_Callback             :: #type proc "c" (ctx: rawptr, buffer: ^i16, length: i32) -> i32 // data is mono

