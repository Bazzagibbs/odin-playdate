package playdate

import "core:math"

// TODO: test this API, it's probably incorrect

AUDIO_FRAMES_PER_CYCLE :: 512

MIDI_Note :: distinct f32 

Sound_Format :: enum {
    Mono_8_Bit      = 0,
    Stereo_8_Bit    = 1,
    Mono_16_Bit     = 2,
    Stereo_16_Bit   = 3,
    Mono_ADPCM      = 4,
    Stereo_ADPCM    = 5,
}

sound_format_is_stereo :: proc "contextless" (format: Sound_Format) -> b32 {
    return (i32(format) & 1) != 0
}

sound_format_is_16_bit :: proc "contextless" (format: Sound_Format) -> b32 {
    return format >= Sound_Format.Mono_16_Bit
}

sound_format_bytes_per_frame :: proc "contextless" (format: Sound_Format) -> u32 {
    return (sound_format_is_stereo(format) ? 2 : 1) * (sound_format_is_16_bit(format) ? 2 : 1)
}

note_to_frequency :: proc "contextless" (n: MIDI_Note) -> f32 {
    return 440 * math.pow(2, (f32(n)-69)/12)
}

frequency_to_note :: proc "contextless" (f: f32) -> MIDI_Note {
    return MIDI_Note(12 * math.log2(f) - 36.376316562)
}


// SOUND SOURCES

Sound_Source        :: distinct Opaque_Struct
Sound_Callback_Proc :: #type proc "c" (c: ^Sound_Source)

Api_Sound_Source_Procs :: struct {
    set_volume:          proc "c" (source: ^Sound_Source, left_vol, right_vol: f32),
    get_volume:          proc "c" (source: ^Sound_Source, left_vol, right_vol: ^f32),
    is_playing:          proc "c" (source: ^Sound_Source) -> b32,
    set_finish_callback: proc "c" (source: ^Sound_Source, callback: Sound_Callback_Proc),
}


File_Player            :: distinct Sound_Source
Sound_Data_Source_Proc :: #type proc "c" (data: [^]u8, bytes: i32, user_data: rawptr) -> i32

Api_Sound_File_Player_Procs :: struct {
    new_player:            proc "c" () -> ^File_Player,
    free_player:           proc "c" (player: ^File_Player),
    load_into_player:      proc "c" (player: ^File_Player, path: cstring) -> b32,
    set_buffer_length:     proc "c" (player: ^File_Player, length: f32),
    play:                  proc "c" (player: ^File_Player, repeat: b32) -> b32,
    is_playing:            proc "c" (player: ^File_Player) -> b32,
    pause:                 proc "c" (player: ^File_Player),
    stop:                  proc "c" (player: ^File_Player),
    set_volume:            proc "c" (player: ^File_Player, left_vol, right_vol: f32),
    get_volume:            proc "c" (player: ^File_Player, left_vol, right_vol: ^f32),
    get_length:            proc "c" (player: ^File_Player) -> f32,
    set_offset:            proc "c" (player: ^File_Player, offset: f32),
    set_rate:              proc "c" (player: ^File_Player, rate: f32),
    set_loop_range:        proc "c" (player: ^File_Player, start, end: f32),
    did_underrun:          proc "c" (player: ^File_Player) -> b32,
    set_finish_callback:   proc "c" (player: ^File_Player, callback: Sound_Callback_Proc),
    set_loop_callback:     proc "c" (player: ^File_Player, callback: Sound_Callback_Proc),
    get_offset:            proc "c" (player: ^File_Player) -> f32,
    get_rate:              proc "c" (player: ^File_Player) -> f32,
    set_stop_on_underrun:  proc "c" (player: ^File_Player, should_stop: b32),
    fade_volume:           proc "c" (player: ^File_Player, left, right: f32, length: i32, callback: Sound_Callback_Proc),
    set_mp3_stream_source: proc "c" (player: ^File_Player, data_source_proc: Sound_Data_Source_Proc, user_data: rawptr, buffer_length: f32),
}


Audio_Sample  :: distinct Opaque_Struct
Sample_Player :: distinct Sound_Source


Api_Sound_Sample_Procs :: struct {
    new_sample_buffer:    proc "c" (byte_count: i32) -> ^Audio_Sample,
    load_into_sample:     proc "c" (sample: ^Audio_Sample, path: cstring) -> b32,
    load:                 proc "c" (path: cstring) -> ^Audio_Sample,
    new_sample_from_data: proc "c" (data: [^]u8, format: Sound_Format, sample_rate: u32, byte_count: i32, should_free_data: b32) -> ^Audio_Sample,
    get_data:             proc "c" (sample: ^Audio_Sample, data: ^[^]u8, format: ^Sound_Format, sample_rate: ^u32, byte_count: ^u32),
    free_sample:          proc "c" (sample: ^Audio_Sample),
    get_length:           proc "c" (sample: ^Audio_Sample) -> f32,

    // 2.4
    decompress:           proc "c" (sample: ^Audio_Sample) -> b32,
}

Api_Sound_Sample_Player_Procs :: struct { // Extends SoundSource
    new_player:          proc "c" () -> ^Sample_Player,
    free_player:         proc "c" (player: ^Sample_Player),
    set_sample:          proc "c" (player: ^Sample_Player, sample: ^Audio_Sample),
    play:                proc "c" (player: ^Sample_Player, repeat: i32, rate: f32) -> b32, // repeat: n times, 0 endless, -1 ping-pong
    is_playing:          proc "c" (player: ^Sample_Player) -> b32,
    stop:                proc "c" (player: ^Sample_Player),
    set_volume:          proc "c" (player: ^Sample_Player, left, right: f32),
    get_volume:          proc "c" (player: ^Sample_Player, left, right: ^f32),
    get_length:          proc "c" (player: ^Sample_Player) -> f32,
    set_offset:          proc "c" (player: ^Sample_Player, offset: f32),
    set_rate:            proc "c" (player: ^Sample_Player, rate: f32),
    set_play_range:      proc "c" (player: ^Sample_Player, start, end: i32),
    set_finish_callback: proc "c" (player: ^Sample_Player, callback: Sound_Callback_Proc),
    set_loop_callback:   proc "c" (player: ^Sample_Player, callback: Sound_Callback_Proc),
    get_offset:          proc "c" (player: ^Sample_Player) -> f32,
    get_rate:            proc "c" (player: ^Sample_Player) -> f32,
    set_paused:          proc "c" (player: ^Sample_Player, paused: b32),
}


// SIGNALS

Synth_Signal_Value :: distinct Opaque_Struct
Synth_Signal       :: distinct Synth_Signal_Value

Signal_Step_Proc     :: #type proc "c" (user_data: rawptr, io_frames: ^i32, if_val: ^f32) -> f32
Signal_Note_On_Proc  :: #type proc "c" (user_data: rawptr, note: MIDI_Note, velocity, length: f32)
Signal_Note_Off_Proc :: #type proc "c" (user_data: rawptr, stopped, offset: i32)
Signal_Dealloc_Proc  :: #type proc "c" (user_data: rawptr)


Api_Sound_Signal_Procs :: struct {
    new_signal:           proc "c" (step: Signal_Step_Proc, note_on: Signal_Note_On_Proc, note_off: Signal_Note_Off_Proc, dealloc: Signal_Dealloc_Proc, user_data: rawptr) -> ^Synth_Signal,
    free_signal:          proc "c" (signal: ^Synth_Signal),
    get_value:            proc "c" (signal: ^Synth_Signal) -> f32,
    set_value_scale:      proc "c" (signal: ^Synth_Signal, scale: f32),
    set_value_offset:     proc "c" (signal: ^Synth_Signal, offset: f32),
    new_signal_for_value: proc "c" (signal: ^Synth_Signal_Value) -> ^Synth_Signal,
}


Synth_LFO :: distinct Synth_Signal

LFO_Type :: enum {
    Square,
    Triangle,
    Sample_And_Hold,
    Sawtooth_Up,
    Sawtooth_Down,
    Arpeggiator,
    Function,
}

LFO_Proc :: #type proc "c" (Synth_LFO, rawptr) -> f32

Api_Sound_LFO_Procs :: struct {
    new_lfo:          proc "c" (type: LFO_Type) -> ^Synth_LFO,
    free_lfo:         proc "c" (lfo: ^Synth_LFO),
    set_type:         proc "c" (lfo: ^Synth_LFO, type: LFO_Type),
    set_rate:         proc "c" (lfo: ^Synth_LFO, rate: f32),
    set_phase:        proc "c" (lfo: ^Synth_LFO, phase: f32),
    set_center:       proc "c" (lfo: ^Synth_LFO, center: f32),
    set_depth:        proc "c" (lfo: ^Synth_LFO, depth: f32),
    set_arpeggiation: proc "c" (lfo: ^Synth_LFO, n_steps: i32, steps: [^]f32),
    set_function:     proc "c" (lfo: ^Synth_LFO, lfo_proc: LFO_Proc, user_data: rawptr, interpolate: b32), 
    set_delay:        proc "c" (lfo: ^Synth_LFO, holdoff, ramp: f32),
    set_retrigger:    proc "c" (lfo: ^Synth_LFO, retrigger: b32),
    get_value:        proc "c" (lfo: ^Synth_LFO) -> f32,
    
    // 1.10
    set_global:       proc "c" (lfo: ^Synth_LFO, global: b32),

    // 2.2
    set_start_phase: proc "c" (lfo: ^Synth_LFO, phase: f32),
}



Synth_Envelope :: distinct Synth_Signal

Api_Sound_Envelope_Procs :: struct {
        new_envelope:         #type proc "c" (attack, decay, sustain, release: f32) -> ^Synth_Envelope,
    free_envelope:            #type proc "c" (env: ^Synth_Envelope),
    set_attack:               #type proc "c" (env: ^Synth_Envelope, attack: f32),
    set_decay:                #type proc "c" (env: ^Synth_Envelope, decay: f32),
    set_sustain:              #type proc "c" (env: ^Synth_Envelope, sustain: f32),
    set_release:              #type proc "c" (env: ^Synth_Envelope, release: f32),
    set_legato:               #type proc "c" (env: ^Synth_Envelope, legato: b32), 
    set_retrigger:            #type proc "c" (env: ^Synth_Envelope, retrigger: b32),
    get_value:                #type proc "c" (env: ^Synth_Envelope) -> f32,

    // 1.13
    set_curvature:            #type proc "c" (env: ^Synth_Envelope, amount: f32),
    set_velocity_sensitivity: #type proc "c" (env: ^Synth_Envelope, sensitivity: f32),
    set_rate_scaling:         #type proc "c" (env: ^Synth_Envelope, scaling: f32, start, end: MIDI_Note),
}



// SYNTHS

Sound_Waveform :: enum {
    Square,
    Triangle,
    Sine,
    Noise,
    Sawtooth,
    PO_Phase,
    PO_Digital,
    PO_VOSim,
}

Synth_Render_Proc           :: #type proc "c" (user_data: rawptr, left, right: ^i32, n_samples: i32, rate: u32, d_rate: i32) -> i32
Synth_Note_On_Proc          :: #type proc "c" (user_data: rawptr, note: MIDI_Note, velocity, length: f32)
Synth_Release_Proc          :: #type proc "c" (user_data: rawptr, stop: i32)
Synth_Set_Parameter_Proc    :: #type proc "c" (user_data: rawptr, parameter: i32, value: f32) -> i32 // b32?
Synth_Dealloc_Proc          :: #type proc "c" (user_data: rawptr)
Synth_Copy_Userdata_Proc    :: #type proc "c" (user_data: rawptr) -> rawptr

Synth :: distinct Sound_Source

Api_Sound_Synth_Procs :: struct {
    new_synth:                proc "c" () -> ^Synth,
    free_synth:               proc "c" (synth: ^Synth),

    set_waveform:             proc "c" (synth: ^Synth, wave: ^Sound_Waveform),
    set_generator_deprecated: proc "c" (synth: ^Synth, stereo: b32, render: Synth_Render_Proc, note_on: Synth_Note_On_Proc, release: Synth_Release_Proc, set_param: Synth_Set_Parameter_Proc, dealloc: Synth_Dealloc_Proc, user_data: rawptr),
    set_sample:               proc "c" (synth: ^Synth, sample: ^Audio_Sample, sustain_start, sustain_end: u32),

    set_attack_time:          proc "c" (synth: ^Synth, attack: f32),
    set_decay_time:           proc "c" (synth: ^Synth, decay: f32),
    set_sustain_level:        proc "c" (synth: ^Synth, sustain: f32), 
    set_release_time:         proc "c" (synth: ^Synth, release: f32), 

    set_transpose:            proc "c" (synth: ^Synth, half_steps: f32),

    set_frequency_modulator:  proc "c" (synth: ^Synth, mod: ^Synth_Signal_Value),
    get_frequrency_modulator: proc "c" (synth: ^Synth) -> ^Synth_Signal_Value,
    set_amplitude_modulator:  proc "c" (synth: ^Synth, mod: ^Synth_Signal_Value), 
    get_amplitude_modulator:  proc "c" (synth: ^Synth) -> ^Synth_Signal_Value,

    get_parameter_count:      proc "c" (synth: ^Synth) -> i32,
    set_parameter:            proc "c" (synth: ^Synth, parameter: i32, value: f32) -> i32,
    set_parameter_modulator:  proc "c" (synth: ^Synth, parameter: i32, mod: ^Synth_Signal_Value),
    get_parameter_modulator:  proc "c" (synth: ^Synth, parameter: i32) -> ^Synth_Signal_Value,

    play_note:                proc "c" (synth: ^Synth, frequency, velocity, length: f32, _when: u32), // length == -1 for indefinite
    play_midi_note:           proc "c" (synth: ^Synth, note: MIDI_Note, velocity, length: f32, _when: u32), // length == -1 for indefinite
    note_off:                 proc "c" (synth: ^Synth, _when: u32),
    stop:                     proc "c" (synth: ^Synth),

    set_volume:               proc "c" (synth: ^Synth, left, right: f32),
    get_volume:               proc "c" (synth: ^Synth, left, right: ^f32),
    is_playing:               proc "c" (synth: ^Synth) -> b32,

    // 1.13
    get_envelope:             proc "c" (synth: ^Synth) -> ^Synth_Envelope,

    // 2.2
    set_wavetable:            proc "c" (synth: ^Synth, sample: ^Audio_Sample, log_2_size, columns, rows: i32) -> b32,

    // 2.4
    set_generator:            proc "c" (synth: ^Synth, stereo: b32, render: Synth_Render_Proc, note_on: Synth_Note_On_Proc, release: Synth_Release_Proc, dealloc: Synth_Dealloc_Proc, copy_user_data: Synth_Copy_Userdata_Proc, user_data: rawptr),
    copy:                     proc "c" (synth: ^Synth) -> ^Synth,

    // 2.6
    clear_envelope:           proc "c" (synth: ^Synth),
}


// SEQUENCES

Control_Signal :: distinct Synth_Signal

Api_Sound_Control_Signal_Procs :: struct {
    new_signal:                 proc "c" () -> ^Control_Signal,
    free_signal:                proc "c" (control: ^Control_Signal),
    clear_events:               proc "c" (control: ^Control_Signal),
    add_event:                  proc "c" (control: ^Control_Signal, step: i32, value: f32, interpolate: b32),
    remove_event:               proc "c" (control: ^Control_Signal, step: i32),
    get_midi_controller_number: proc "c" (control: ^Control_Signal) -> i32,
}


Synth_Instrument :: distinct Opaque_Struct

Api_Sound_Instrument_Procs :: struct {
    new_instrument:       proc "c" () -> ^Synth_Instrument,
    free_instrument:      proc "c" (inst: ^Synth_Instrument),
    add_voice:            proc "c" (inst: ^Synth_Instrument, synth: ^Synth, range_start, range_end: MIDI_Note, transpose: f32) -> b32,
    play_note:            proc "c" (inst: ^Synth_Instrument, frequency, velocity, length: f32, _when: u32) -> ^Synth,
    play_midi_note:       proc "c" (inst: ^Synth_Instrument, note: MIDI_Note, velocity, length: f32, _when: u32) -> ^Synth,
    set_pitch_bend:       proc "c" (inst: ^Synth_Instrument, bend: f32),
    set_pitch_bend_range: proc "c" (inst: ^Synth_Instrument, half_steps: f32),
    set_transpose:        proc "c" (inst: ^Synth_Instrument, half_steps: f32),
    note_off:             proc "c" (inst: ^Synth_Instrument, note: MIDI_Note, _when: u32),
    all_notes_off:        proc "c" (inst: ^Synth_Instrument, _when: u32),
    set_volume:           proc "c" (inst: ^Synth_Instrument, left, right: f32),
    get_volume:           proc "c" (inst: ^Synth_Instrument, left, right: ^f32),
    active_voice_count:   proc "c" (inst: ^Synth_Instrument) -> i32,
}


Sequence_Track :: distinct Opaque_Struct

Api_Sound_Track_Procs :: struct {
    new_track:                 #type proc "c" () -> ^Sequence_Track,
    free_track:                #type proc "c" (track: ^Sequence_Track),

    set_instrument:            #type proc "c" (track: ^Sequence_Track, inst: ^Synth_Instrument),
    get_instrument:            #type proc "c" (track: ^Sequence_Track) -> ^Synth_Instrument,

    add_note_event:            #type proc "c" (track: ^Sequence_Track, step, length: u32, note: MIDI_Note, velocity: f32),
    remove_note_event:         #type proc "c" (track: ^Sequence_Track, step: u32, note: MIDI_Note),
    clear_notes:               #type proc "c" (track: ^Sequence_Track),

    get_control_signal_count:  #type proc "c" (track: ^Sequence_Track) -> i32,
    get_control_signal:        #type proc "c" (track: ^Sequence_Track, idx: i32) -> ^Control_Signal,
    clear_control_events:      #type proc "c" (track: ^Sequence_Track),

    get_polyphony:             #type proc "c" (track: ^Sequence_Track) -> i32,
    active_voice_count:        #type proc "c" (track: ^Sequence_Track) -> i32,

    set_muted:                 #type proc "c" (track: ^Sequence_Track, muted: b32),

    // 1.1
    get_length:                #type proc "c" (track: ^Sequence_Track) -> u32,
    get_index_for_step:        #type proc "c" (track: ^Sequence_Track, step: u32) -> i32,
    get_note_at_index:         #type proc "c" (track: ^Sequence_Track, index: i32, out_step, out_length: ^u32, out_note: ^MIDI_Note, out_velocity: ^f32) -> b32,

    // 1.10
    get_signal_for_controller: #type proc "c" (track: ^Sequence_Track, controller: i32, create: b32) -> ^Control_Signal,
}



Sequence :: distinct Opaque_Struct

Sequence_Finished_Callback  :: #type proc "c" (seq: ^Sequence, user_data: rawptr)

Api_Sound_Sequence_Procs :: struct {
    new_sequence:       #type proc "c" () -> ^Sequence,
    free_sequence:      #type proc "c" (seq: ^Sequence),
    load_midi_file:     #type proc "c" (seq: ^Sequence, path: cstring) -> b32,

    get_time:           #type proc "c" (seq: ^Sequence) -> u32,
    set_time:           #type proc "c" (seq: ^Sequence, time: u32),
    set_loops:          #type proc "c" (seq: ^Sequence, loop_start, loop_end, loops: i32),
    get_tempo_deprecated: #type proc "c" (seq: ^Sequence) -> i32,
    set_tempo:          #type proc "c" (seq: ^Sequence, steps_per_second: i32),
    get_track_count:    #type proc "c" (seq: ^Sequence) -> i32,
    add_track:          #type proc "c" (seq: ^Sequence) -> ^Sequence_Track,
    get_track_at_index: #type proc "c" (seq: ^Sequence, index: u32) -> ^Sequence_Track,
    set_track_at_index: #type proc "c" (seq: ^Sequence, track: ^Sequence_Track, index: u32),
    all_notes_off:      #type proc "c" (seq: ^Sequence),

    // 1.1
    is_playing:         #type proc "c" (seq: ^Sequence) -> b32,
    get_length:         #type proc "c" (seq: ^Sequence) -> u32, // in steps, includes full last note
    play:               #type proc "c" (seq: ^Sequence, finish_callback: Sequence_Finished_Callback, user_data: rawptr),
    stop:               #type proc "c" (seq: ^Sequence),
    get_current_step:   #type proc "c" (seq: ^Sequence, time_offset: ^i32) -> i32,
    set_current_step:   #type proc "c" (seq: ^Sequence, step, time_offset: i32, play_notes: b32),

    // 2.5
    get_tempo:          #type proc "c" (seq: ^Sequence) -> f32,
}



// EFFECTS

Sound_Effect          :: distinct Opaque_Struct

Sound_Effect_Proc     :: #type proc "c" (effect: ^Sound_Effect, left, right: ^i32, n_samples, buf_active: i32) -> i32
Record_Callback       :: #type proc "c" (ctx: rawptr, buffer: ^i16, length: i32) -> i32 // data is mono
Change_Callback       :: #type proc "c" (headphone: i32, mic: i32)



Sound_Two_Pole_Filter_Type :: enum {
    Low_Pass,
    High_Pass,
    Band_Pass,
    Notch,
    PEQ,
    Low_Shelf,
    High_Shelf,
}

Sound_Two_Pole_Filter :: distinct Sound_Effect

Api_Sound_Effect_Two_Pole_Filter_Procs :: struct {
    new_filter:               proc "c" () -> ^Sound_Two_Pole_Filter,
    free_filter:              proc "c" (filter: ^Sound_Two_Pole_Filter),
    set_type:                 proc "c" (filter: ^Sound_Two_Pole_Filter, type: Sound_Two_Pole_Filter_Type),
    set_frequency:            proc "c" (filter: ^Sound_Two_Pole_Filter, freq: f32),
    set_frequency_modulator:  proc "c" (filter: ^Sound_Two_Pole_Filter, signal: ^Synth_Signal_Value),
    get_frequrency_modulator: proc "c" (filter: ^Sound_Two_Pole_Filter) -> ^Synth_Signal_Value,
    set_gain:                 proc "c" (filter: ^Sound_Two_Pole_Filter, gain: f32),
    set_resonance:            proc "c" (filter: ^Sound_Two_Pole_Filter, resonance: f32),
    set_resonance_modulator:  proc "c" (filter: ^Sound_Two_Pole_Filter, signal: ^Synth_Signal_Value),
    get_resonance_modulator:  proc "c" (filter: ^Sound_Two_Pole_Filter) -> ^Synth_Signal_Value,
}


Sound_One_Pole_Filter :: distinct Sound_Effect

Api_Sound_Effect_One_Pole_Filter_Procs :: struct {
    new_filter:              proc "c" () -> ^Sound_One_Pole_Filter,
    free_filter:             proc "c" (filter: ^Sound_One_Pole_Filter),
    set_parameter:           proc "c" (filter: ^Sound_One_Pole_Filter, parameter: f32),
    set_parameter_modulator: proc "c" (filter: ^Sound_One_Pole_Filter, signal: ^Synth_Signal_Value),
    get_parameter_modulator: proc "c" (filter: ^Sound_One_Pole_Filter) -> ^Synth_Signal_Value,
}



Sound_Bit_Crusher :: distinct Sound_Effect

Api_Sound_Effect_Bit_Crusher_Procs :: struct {
    new_bit_crusher:           proc "c" () -> ^Sound_Bit_Crusher,
    free_bit_crusher:          proc "c" (filter: ^Sound_Bit_Crusher),
    set_amount:                proc "c" (filter: ^Sound_Bit_Crusher, amount: f32),
    set_amount_modulator:      proc "c" (filter: ^Sound_Bit_Crusher, signal: ^Synth_Signal_Value),
    get_amount_modulator:      proc "c" (filter: ^Sound_Bit_Crusher) -> ^Synth_Signal_Value,
    set_undersampling:         proc "c" (filter: ^Sound_Bit_Crusher, undersampling: f32),
    set_undersample_modulator: proc "c" (filter: ^Sound_Bit_Crusher, signal: ^Synth_Signal_Value),
    get_undersample_modulator: proc "c" (filter: ^Sound_Bit_Crusher) -> ^Synth_Signal_Value,
}


Sound_Ring_Modulator :: distinct Sound_Effect

Api_Sound_Effect_Ring_Modulator_Procs :: struct {
    new_ringmod:             proc "c" () -> ^Sound_Ring_Modulator,
    free_ringmod:            proc "c" (filter: ^Sound_Ring_Modulator),
    set_frequency:           proc "c" (filter: ^Sound_Ring_Modulator, frequency: f32),
    set_frequency_modulator: proc "c" (filter: ^Sound_Ring_Modulator, signal: ^Synth_Signal_Value),
    get_frequency_modulator: proc "c" (filter: ^Sound_Ring_Modulator) -> ^Synth_Signal_Value,
}


Sound_Delay_Line     :: distinct Sound_Effect
Sound_Delay_Line_Tap :: distinct Sound_Source

Api_Sound_Effect_Delay_Line_Procs :: struct {
    new_delay_line:  proc "c" (length: i32, stereo: b32) -> ^Sound_Delay_Line,
    free_delay_line: proc "c" (d: ^Sound_Delay_Line),
    set_length:      proc "c" (d: ^Sound_Delay_Line, length: i32),
    set_feedback:    proc "c" (d: ^Sound_Delay_Line, feedback: f32),
    add_tap:         proc "c" (d: ^Sound_Delay_Line, delay: i32) -> ^Sound_Delay_Line_Tap,

    free_tap:                 proc "c" (d: ^Sound_Delay_Line_Tap),
    set_tap_delay:            proc "c" (d: ^Sound_Delay_Line_Tap, delay: i32),
    set_tap_delay_modulator:  proc "c" (d: ^Sound_Delay_Line_Tap, signal: ^Synth_Signal_Value),
    get_tap_delay_modulator:  proc "c" (d: ^Sound_Delay_Line_Tap) -> ^Synth_Signal_Value,
    set_tap_channels_flipped: proc "c" (d: ^Sound_Delay_Line_Tap, flip: b32),
}


Sound_Overdrive :: distinct Sound_Effect

Api_Sound_Effect_Overdrive_Procs :: struct {
    new_overdrive:        proc "c" () -> ^Sound_Overdrive,
    free_overdrive:       proc "c" (o: ^Sound_Overdrive),
    set_gain:             proc "c" (o: ^Sound_Overdrive, gain: f32),
    set_limit:            proc "c" (o: ^Sound_Overdrive, limit: f32),
    set_limit_modulator:  proc "c" (o: ^Sound_Overdrive, signal: ^Synth_Signal_Value),
    get_limit_modulator:  proc "c" (o: ^Sound_Overdrive) -> ^Synth_Signal_Value,
    set_offset:           proc "c" (o: ^Sound_Overdrive, offset: f32),
    set_offset_modulator: proc "c" (o: ^Sound_Overdrive, signal: ^Synth_Signal_Value),
    get_offset_modulator: proc "c" (o: ^Sound_Overdrive) -> ^Synth_Signal_Value,
}


Api_Sound_Effect_Procs :: struct {
    new_effect:        proc "c" (effect: ^Sound_Effect_Proc, user_data: rawptr) -> ^Sound_Effect,
    free_effect:       proc "c" (effect: ^Sound_Effect),

    set_mix:           proc "c" (effect: ^Sound_Effect, level: f32),
    set_mix_modulator: proc "c" (effect: ^Sound_Effect, signal: ^Synth_Signal_Value),
    get_mix_modulator: proc "c" (effect: ^Sound_Effect) -> ^Synth_Signal_Value,

    set_user_data:     proc "c" (effect: ^Sound_Effect, user_data: rawptr),
    get_user_data:     proc "c" (effect: ^Sound_Effect) -> rawptr,
    
    two_pole_filter: ^Api_Sound_Effect_Two_Pole_Filter_Procs,
    one_pole_filter: ^Api_Sound_Effect_One_Pole_Filter_Procs,
    bit_crusher:     ^Api_Sound_Effect_Bit_Crusher_Procs,
    ring_modulator:  ^Api_Sound_Effect_Ring_Modulator_Procs,
    delay_line:      ^Api_Sound_Effect_Delay_Line_Procs,
    overdrive:       ^Api_Sound_Effect_Overdrive_Procs,
}


Sound_Channel :: distinct Opaque_Struct

Audio_Source_Proc :: #type proc "c" (ctx: rawptr, left, right: ^i16, length: i32) -> i32

Api_Sound_Channel_Procs :: struct {
    new_channel:          proc "c" () -> ^Sound_Channel,
    free_channel:         proc "c" (channel: ^Sound_Channel),
    add_source:           proc "c" (channel: ^Sound_Channel, source: ^Sound_Source) -> b32, // return value not documented
    remove_source:        proc "c" (channel: ^Sound_Channel, source: ^Sound_Source) -> b32, // return value not documented
    add_callback_source:  proc "c" (channel: ^Sound_Channel, callback: Audio_Source_Proc, user_data: rawptr, stereo: b32) -> ^Sound_Source,
    add_effect:           proc "c" (channel: ^Sound_Channel, effect: ^Sound_Effect),
    remove_effect:        proc "c" (channel: ^Sound_Channel, effect: ^Sound_Effect),
    set_volume:           proc "c" (channel: ^Sound_Channel, volume: f32),
    get_volume:           proc "c" (channel: ^Sound_Channel) -> f32,
    set_volume_modulator: proc "c" (channel: ^Sound_Channel, signal: ^Synth_Signal_Value),
    get_volume_modulator: proc "c" (channel: ^Sound_Channel) -> ^Synth_Signal_Value,
    set_pan:              proc "c" (channel: ^Sound_Channel, pan: f32),
    set_pan_modulator:    proc "c" (channel: ^Sound_Channel, signal: ^Synth_Signal_Value),
    get_pan_modulator:    proc "c" (channel: ^Sound_Channel) -> ^Synth_Signal_Value,
    get_dry_level_signal: proc "c" (channel: ^Sound_Channel) -> ^Synth_Signal_Value,
    get_wet_level_signal: proc "c" (channel: ^Sound_Channel) -> ^Synth_Signal_Value,
}


// =================================================================


Sound_Mic_Source :: enum {
    Autodetect = 0,
    Internal   = 1,
    Headset    = 2,
}


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

    get_current_time:    proc "c" () -> u32,
    add_source:          proc "c" (source: Audio_Source_Proc, user_data: rawptr, stereo: b32) -> ^Sound_Source,

    get_default_channel: proc "c" () -> ^Sound_Channel,

    add_channel:         proc "c" (channel: ^Sound_Channel) -> i32,
    remove_channel:      proc "c" (channel: ^Sound_Channel) -> i32,

    set_mic_callback:    proc "c" (callback: Record_Callback, user_data: rawptr, source: Sound_Mic_Source),
    get_headphone_state: proc "c" (headphone, headset_mic: ^b32, change_callback: Change_Callback),
    set_outputs_active:  proc "c" (headphone, speaker: b32),

    // 1.5
    remove_source:       proc "c" (^Sound_Source) -> i32,

    // 1.12
    signal: ^Api_Sound_Signal_Procs,

    // 2.2
    get_error:           proc "c" () -> cstring,
}

