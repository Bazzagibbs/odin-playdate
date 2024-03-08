package playdate_common

//   ///////////
//  // TYPES //
// ///////////
Sound_Source              :: distinct Handle
Sound_File_Player         :: distinct Sound_Source
Sound_Audio_Sample        :: distinct Handle
Sound_Sample_Player       :: distinct Sound_Source
Sound_Synth               :: distinct Handle
Sound_Synth_Instrument    :: distinct Handle
Sound_Synth_LFO           :: distinct Handle
Sound_Synth_Envelope      :: distinct Handle
Sound_Synth_Signal_Value  :: distinct Handle
Sound_Synth_Signal        :: distinct Handle
Sound_Control_Signal      :: distinct Handle
Sound_Sequence_Track      :: distinct Handle
Sound_Sequence            :: distinct Handle
Sound_Two_Pole_Filter     :: distinct Handle
Sound_One_Pole_Filter     :: distinct Handle
Sound_Bit_Crusher         :: distinct Handle
Sound_Ring_Modulator      :: distinct Handle
Sound_Delay_Line          :: distinct Handle
Sound_Delay_Line_Tap      :: distinct Handle
Sound_Overdrive           :: distinct Handle
Sound_Effect              :: distinct Handle
Sound_Channel             :: distinct Handle


Sound_MIDI_Note           :: distinct f32 

Sound_Format :: enum {
    mono_8_bit      = 0,
    stereo_8_bit    = 1,
    mono_16_bit     = 2,
    stereo_16_bit   = 3,
    mono_ADPCM      = 4,
    stereo_ADPCM    = 5,
}

Sound_LFO_Type :: enum {
    square,
    triangle,
    sample_and_hold,
    sawtooth_up,
    sawtooth_down,
    arpeggiator,
    function,
}

Sound_Waveform :: enum {
    square,
    triangle,
    sine,
    noise,
    sawtooth,
    po_phase,
    po_digital,
    po_vosim,
}

Sound_Two_Pole_Filter_Type :: enum {
    low_pass,
    high_pass,
    band_pass,
    notch,
    peq,
    low_shelf,
    high_shelf,
}

Sound_Callback_Proc               :: #type proc "c" (source: Sound_Source)

Sound_Signal_Step_Proc            :: #type proc "c" (user_data: rawptr, io_frames: ^i32, if_val: ^f32) -> f32
Sound_Signal_Note_On_Proc         :: #type proc "c" (user_data: rawptr, note: Sound_MIDI_Note, velocity, length: f32)
Sound_Signal_Note_Off_Proc        :: #type proc "c" (user_data: rawptr, stopped, offset: i32)
Sound_Signal_Dealloc_Proc         :: #type proc "c" (user_data: rawptr)

Sound_Synth_Render_Proc           :: #type proc "c" (user_data: rawptr, left, right: ^i32, n_samples: i32, rate: u32, d_rate: i32) -> i32
Sound_Synth_Note_On_Proc          :: #type proc "c" (user_data: rawptr, note: Sound_MIDI_Note, velocity, length: f32)
Sound_Synth_Release_Proc          :: #type proc "c" (user_data: rawptr, stop: i32)
Sound_Synth_Set_Parameter_Proc    :: #type proc "c" (user_data: rawptr, parameter: i32, value: f32)
Sound_Synth_Dealloc_Proc          :: #type proc "c" (user_data: rawptr)

Sound_Sequence_Finished_Callback  :: #type proc "c" (seq: Sound_Sequence, user_data: rawptr)

Sound_Effect_Proc                 :: #type proc "c" (effect: Sound_Effect, left, right: ^i32, n_samples, buf_active: i32) -> i32
Sound_Audio_Source_Proc           :: #type proc "c" (ctx: rawptr, left, right: ^i16, length: i32) -> i32
Sound_Record_Callback             :: #type proc "c" (ctx: rawptr, buffer: ^i16, length: i32) -> i32 // data is mono
Sound_Change_Callback             :: #type proc "c" (headphone: i32, mic: i32)

Sound_Data_Source_Proc            :: #type proc "c" (data: [^]u8, bytes: i32, user_data: rawptr) -> i32
Sound_LFO_Proc                    :: #type proc "c" (Sound_Synth_LFO, rawptr) -> f32
// =================================================================


//   ////////////////
//  // PROC TYPES //
// ////////////////
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
    add_source:          #type proc "c" (Sound_Audio_Source_Proc, rawptr, i32) -> Sound_Source,
    get_default_channel: #type proc "c" () -> Sound_Channel,
    add_channel:         #type proc "c" (Sound_Channel) -> i32,
    remove_channel:      #type proc "c" (Sound_Channel) -> i32,
    set_mic_callback:    #type proc "c" (Sound_Record_Callback, rawptr, i32),
    get_headphone_state: #type proc "c" (^i32, ^i32, Sound_Change_Callback),
    set_outputs_active:  #type proc "c" (i32, i32),

    remove_source: #type proc "c" (Sound_Source) -> i32,

    signal: ^Api_Sound_Signal_Procs,
}

Api_Sound_Source_Procs :: struct {
    set_volume:          #type proc "c" (Sound_Source, f32, f32),
    get_volume:          #type proc "c" (Sound_Source, ^f32, ^f32),
    is_playing:          #type proc "c" (Sound_Source) -> i32,
    set_finish_callback: #type proc "c" (Sound_Source, Sound_Callback_Proc),
}

Api_Sound_File_Player_Procs :: struct {
    new_player:            #type proc "c" () -> Sound_File_Player,
    free_player:           #type proc "c" (Sound_File_Player),
    load_into_player:      #type proc "c" (Sound_File_Player, cstring) -> i32,
    set_buffer_length:     #type proc "c" (Sound_File_Player, f32),
    play:                  #type proc "c" (Sound_File_Player, f32) -> i32,
    is_playing:            #type proc "c" (Sound_File_Player) -> i32,
    pause:                 #type proc "c" (Sound_File_Player),
    stop:                  #type proc "c" (Sound_File_Player),
    set_volume:            #type proc "c" (Sound_File_Player, f32, f32),
    get_volume:            #type proc "c" (Sound_File_Player, ^f32, ^f32),
    get_length:            #type proc "c" (Sound_File_Player) -> f32,
    set_offset:            #type proc "c" (Sound_File_Player, f32),
    set_rate:              #type proc "c" (Sound_File_Player, f32),
    set_loop_range:        #type proc "c" (Sound_File_Player, f32, f32),
    did_underrun:          #type proc "c" (Sound_File_Player) -> i32,
    set_finish_callback:   #type proc "c" (Sound_File_Player, Sound_Callback_Proc),
    set_loop_callback:     #type proc "c" (Sound_File_Player, Sound_Callback_Proc),
    get_offset:            #type proc "c" (Sound_File_Player) -> f32,
    get_rate:              #type proc "c" (Sound_File_Player) -> f32,
    set_stop_on_underrun:  #type proc "c" (Sound_File_Player, i32),
    fade_volume:           #type proc "c" (Sound_File_Player, f32, f32, i32, Sound_Callback_Proc),
    set_mp3_stream_source: #type proc "c" (Sound_File_Player, Sound_Data_Source_Proc, rawptr, f32),
}

Api_Sound_Sample_Procs :: struct {
    new_sample_buffer:    #type proc "c" (i32) -> Sound_Audio_Sample,
    load_into_sample:     #type proc "c" (Sound_Audio_Sample, cstring) -> i32,
    load:                 #type proc "c" (cstring) -> Sound_Audio_Sample,
    new_sample_from_data: #type proc "c" ([^]u8, Sound_Format, u32, i32) -> Sound_Audio_Sample,
    get_data:             #type proc "c" (Sound_Audio_Sample, ^[^]u8, Sound_Format, ^u32, ^u32),
    free_sample:          #type proc "c" (Sound_Audio_Sample),
    get_length:           #type proc "c" (Sound_Audio_Sample) -> f32,
}

Api_Sound_Sample_Player_Procs :: struct { // Extends SoundSource
    new_player:          #type proc "c" () -> Sound_Sample_Player,
    free_player:         #type proc "c" (Sound_Sample_Player),
    set_sample:          #type proc "c" (Sound_Sample_Player, Sound_Audio_Sample),
    play:                #type proc "c" (Sound_Sample_Player, i32, f32) -> i32,
    is_playing:          #type proc "c" (Sound_Sample_Player) -> i32,
    stop:                #type proc "c" (Sound_Sample_Player),
    set_volume:          #type proc "c" (Sound_Sample_Player, f32, f32),
    get_volume:          #type proc "c" (Sound_Sample_Player, ^f32, ^f32),
    get_length:          #type proc "c" (Sound_Sample_Player) -> f32,
    set_offset:          #type proc "c" (Sound_Sample_Player, f32),
    set_rate:            #type proc "c" (Sound_Sample_Player, f32),
    set_play_range:      #type proc "c" (Sound_Sample_Player, i32, i32),
    set_finish_callback: #type proc "c" (Sound_Sample_Player, Sound_Callback_Proc),
    set_loop_callback:   #type proc "c" (Sound_Sample_Player, Sound_Callback_Proc),
    get_offset:          #type proc "c" (Sound_Sample_Player) -> f32,
    get_rate:            #type proc "c" (Sound_Sample_Player) -> f32,
    set_paused:          #type proc "c" (Sound_Sample_Player, i32),
}

Api_Sound_Signal_Procs :: struct {
    new_signal:       #type proc "c" (Sound_Signal_Step_Proc, Sound_Signal_Note_On_Proc, Sound_Signal_Note_Off_Proc, Sound_Signal_Dealloc_Proc, rawptr) -> Sound_Synth_Signal,
    free_signal:      #type proc "c" (Sound_Synth_Signal),
    get_value:        #type proc "c" (Sound_Synth_Signal) -> f32,
    set_value_scale:  #type proc "c" (Sound_Synth_Signal, f32),
    set_value_offset: #type proc "c" (Sound_Synth_Signal, f32),
}

Api_Sound_LFO_Procs :: struct {
    new_lfo:          #type proc "c" (Sound_LFO_Type) -> Sound_Synth_LFO,
    free_lfo:         #type proc "c" (Sound_Synth_LFO),
    set_type:         #type proc "c" (Sound_Synth_LFO, Sound_LFO_Type),
    set_rate:         #type proc "c" (Sound_Synth_LFO, f32),
    set_phase:        #type proc "c" (Sound_Synth_LFO, f32),
    set_center:       #type proc "c" (Sound_Synth_LFO, f32),
    set_depth:        #type proc "c" (Sound_Synth_LFO, f32),
    set_arpeggiation: #type proc "c" (Sound_Synth_LFO, i32, [^]f32),
    set_function:     #type proc "c" (Sound_Synth_LFO, Sound_LFO_Proc, rawptr, i32),
    set_delay:        #type proc "c" (Sound_Synth_LFO, f32, f32),
    set_retrigger:    #type proc "c" (Sound_Synth_LFO, i32),
    get_value:        #type proc "c" (Sound_Synth_LFO) -> f32,
    set_global:       #type proc "c" (Sound_Synth_LFO, i32),
}

Api_Sound_Envelope_Procs :: struct {
    new_envelope:             #type proc "c" (f32, f32, f32, f32) -> Sound_Synth_Envelope,
    free_envelope:            #type proc "c" (Sound_Synth_Envelope),
    set_attack:               #type proc "c" (Sound_Synth_Envelope, f32),
    set_decay:                #type proc "c" (Sound_Synth_Envelope, f32),
    set_sustain:              #type proc "c" (Sound_Synth_Envelope, f32),
    set_release:              #type proc "c" (Sound_Synth_Envelope, f32),
    set_legato:               #type proc "c" (Sound_Synth_Envelope, i32), 
    set_retrigger:            #type proc "c" (Sound_Synth_Envelope, i32),
    get_value:                #type proc "c" (Sound_Synth_Envelope) -> f32,
    set_curvature:            #type proc "c" (Sound_Synth_Envelope, f32),
    set_velocity_sensitivity: #type proc "c" (Sound_Synth_Envelope, f32),
    set_rate_scaling:         #type proc "c" (Sound_Synth_Envelope, f32, Sound_MIDI_Note, Sound_MIDI_Note),
}

Api_Sound_Synth_Procs :: struct {
    new_synth:                #type proc "c" () -> Sound_Synth,
    free_synth:               #type proc "c" (Sound_Synth),
    set_waveform:             #type proc "c" (Sound_Synth, Sound_Waveform),
    set_generator:            #type proc "c" (Sound_Synth, i32, Sound_Synth_Render_Proc, Sound_Synth_Note_On_Proc, Sound_Synth_Release_Proc, Sound_Synth_Set_Parameter_Proc, Sound_Synth_Dealloc_Proc, rawptr),
    set_sample:               #type proc "c" (Sound_Synth, Sound_Audio_Sample, u32, u32),
    set_attack_time:          #type proc "c" (Sound_Synth, f32),
    set_decay_time:           #type proc "c" (Sound_Synth, f32),
    set_sustain_level:        #type proc "c" (Sound_Synth, f32), 
    set_release_time:         #type proc "c" (Sound_Synth, f32), 
    set_transpose:            #type proc "c" (Sound_Synth, f32),
    set_frequency_modulator:  #type proc "c" (Sound_Synth, Sound_Synth_Signal_Value),
    get_frequrency_modulator: #type proc "c" (Sound_Synth) -> Sound_Synth_Signal_Value,
    set_amplitude_modulator:  #type proc "c" (Sound_Synth, Sound_Synth_Signal_Value), 
    get_amplitude_modulator:  #type proc "c" (Sound_Synth) -> Sound_Synth_Signal_Value,
    get_parameter_count:      #type proc "c" (Sound_Synth) -> i32,
    set_parameter:            #type proc "c" (Sound_Synth, i32, f32) -> i32,
    set_parameter_modulator:  #type proc "c" (Sound_Synth, i32, Sound_Synth_Signal_Value),
    get_parameter_modulator:  #type proc "c" (Sound_Synth, i32) -> Sound_Synth_Signal_Value,
    play_note:                #type proc "c" (Sound_Synth, f32, f32, f32, u32),
    play_midi_note:           #type proc "c" (Sound_Synth, Sound_MIDI_Note, f32, f32, u32),
    note_off:                 #type proc "c" (Sound_Synth, u32),
    stop:                     #type proc "c" (Sound_Synth),
    set_volume:               #type proc "c" (Sound_Synth, f32, f32),
    get_volume:               #type proc "c" (Sound_Synth, ^f32, ^f32),
    is_playing:               #type proc "c" (Sound_Synth) -> i32,
    get_envelope:             #type proc "c" (Sound_Synth) -> Sound_Synth_Envelope,
}

Api_Sound_Control_Signal_Procs :: struct {
    new_signal:                 #type proc "c" () -> Sound_Control_Signal,
    free_signal:                #type proc "c" (Sound_Control_Signal),
    clear_events:               #type proc "c" (Sound_Control_Signal),
    add_event:                  #type proc "c" (Sound_Control_Signal, i32, f32, i32),
    remove_event:               #type proc "c" (Sound_Control_Signal, i32),
    get_midi_controller_number: #type proc "c" (Sound_Control_Signal) -> i32,
}

Api_Sound_Instrument_Procs :: struct {
    new_instrument:       #type proc "c" () -> Sound_Synth_Instrument,
    free_instrument:      #type proc "c" (Sound_Synth_Instrument),
    add_voice:            #type proc "c" (Sound_Synth_Instrument, Sound_Synth, Sound_MIDI_Note, Sound_MIDI_Note, f32) -> i32,
    play_note:            #type proc "c" (Sound_Synth_Instrument, f32, f32, f32, u32) -> Sound_Synth,
    play_midi_note:       #type proc "c" (Sound_Synth_Instrument, Sound_MIDI_Note, f32, f32, u32) -> Sound_Synth,
    set_pitch_bend:       #type proc "c" (Sound_Synth_Instrument, f32),
    set_pitch_bend_range: #type proc "c" (Sound_Synth_Instrument, f32),
    set_transpose:        #type proc "c" (Sound_Synth_Instrument, f32),
    note_off:             #type proc "c" (Sound_Synth_Instrument, Sound_MIDI_Note, u32),
    all_notes_off:        #type proc "c" (Sound_Synth_Instrument, u32),
    set_volume:           #type proc "c" (Sound_Synth_Instrument, f32, f32),
    get_volume:           #type proc "c" (Sound_Synth_Instrument, ^f32, ^f32),
    active_voice_count:   #type proc "c" (Sound_Synth_Instrument) -> i32,
}

Api_Sound_Track_Procs :: struct {
    new_track:                 #type proc "c" () -> Sound_Sequence_Track,
    free_track:                #type proc "c" (Sound_Sequence_Track),
    set_instrument:            #type proc "c" (Sound_Sequence_Track, Sound_Synth_Instrument),
    get_instrument:            #type proc "c" (Sound_Sequence_Track) -> Sound_Synth_Instrument,
    add_note_event:            #type proc "c" (Sound_Sequence_Track, u32, u32, Sound_MIDI_Note, f32),
    remove_note_event:         #type proc "c" (Sound_Sequence_Track, u32, Sound_MIDI_Note),
    clear_notes:               #type proc "c" (Sound_Sequence_Track),
    get_control_signal_count:  #type proc "c" (Sound_Sequence_Track) -> i32,
    get_control_signal:        #type proc "c" (Sound_Sequence_Track, i32) -> Sound_Control_Signal,
    clear_control_events:      #type proc "c" (Sound_Sequence_Track),
    get_polyphony:             #type proc "c" (Sound_Sequence_Track) -> i32,
    active_voice_count:        #type proc "c" (Sound_Sequence_Track) -> i32,
    set_muted:                 #type proc "c" (Sound_Sequence_Track, i32),
    get_length:                #type proc "c" (Sound_Sequence_Track) -> u32,
    get_index_for_step:        #type proc "c" (Sound_Sequence_Track, u32) -> i32,
    get_note_at_index:         #type proc "c" (Sound_Sequence_Track, i32, ^u32, ^u32, ^Sound_MIDI_Note, ^f32) -> i32,
    get_signal_for_controller: #type proc "c" (Sound_Sequence_Track, i32, i32) -> Sound_Control_Signal,
}

Api_Sound_Sequence_Procs :: struct {
    new_sequence:       #type proc "c" () -> Sound_Sequence,
    free_sequence:      #type proc "c" (Sound_Sequence),
    load_midi_file:     #type proc "c" (Sound_Sequence, cstring) -> i32,
    get_time:           #type proc "c" (Sound_Sequence) -> u32,
    set_time:           #type proc "c" (Sound_Sequence, u32),
    set_loops:          #type proc "c" (Sound_Sequence, i32, i32, i32),
    get_tempo:          #type proc "c" (Sound_Sequence) -> i32,
    set_tempo:          #type proc "c" (Sound_Sequence, i32),
    get_track_count:    #type proc "c" (Sound_Sequence) -> i32,
    add_track:          #type proc "c" (Sound_Sequence) -> Sound_Sequence_Track,
    get_track_at_index: #type proc "c" (Sound_Sequence, u32) -> Sound_Sequence_Track,
    set_track_at_index: #type proc "c" (Sound_Sequence, Sound_Sequence_Track, u32),
    all_notes_off:      #type proc "c" (Sound_Sequence),
    is_playing:         #type proc "c" (Sound_Sequence) -> i32,
    get_length:         #type proc "c" (Sound_Sequence) -> u32,
    play:               #type proc "c" (Sound_Sequence, Sound_Sequence_Finished_Callback, rawptr),
    stop:               #type proc "c" (Sound_Sequence),
    get_current_step:   #type proc "c" (Sound_Sequence, ^i32) -> i32,
    set_current_step:   #type proc "c" (Sound_Sequence, i32, i32, i32),
}

Api_Sound_Effect_Two_Pole_Filter_Procs :: struct {
    new_filter:               #type proc "c" () -> Sound_Two_Pole_Filter,
    free_filter:              #type proc "c" (Sound_Two_Pole_Filter),
    set_type:                 #type proc "c" (Sound_Two_Pole_Filter, Sound_Two_Pole_Filter_Type),
    set_frequency:            #type proc "c" (Sound_Two_Pole_Filter, f32),
    set_frequency_modulator:  #type proc "c" (Sound_Two_Pole_Filter, Sound_Synth_Signal_Value),
    get_frequrency_modulator: #type proc "c" (Sound_Two_Pole_Filter) -> Sound_Synth_Signal_Value,
    set_gain:                 #type proc "c" (Sound_Two_Pole_Filter, f32),
    set_resonance:            #type proc "c" (Sound_Two_Pole_Filter, f32),
    set_resonance_modulator:  #type proc "c" (Sound_Two_Pole_Filter, Sound_Synth_Signal_Value),
    get_resonance_modulator:  #type proc "c" (Sound_Two_Pole_Filter) -> Sound_Synth_Signal_Value,
}

Api_Sound_Effect_One_Pole_Filter_Procs :: struct {
    new_filter:              #type proc "c" () -> Sound_One_Pole_Filter,
    free_filter:             #type proc "c" (Sound_One_Pole_Filter),
    set_parameter:           #type proc "c" (Sound_One_Pole_Filter, f32),
    set_parameter_modulator: #type proc "c" (Sound_One_Pole_Filter, Sound_Synth_Signal_Value),
    get_parameter_modulator: #type proc "c" (Sound_One_Pole_Filter) -> Sound_Synth_Signal_Value,
}

Api_Sound_Effect_Bit_Crusher_Procs :: struct {
    new_bit_crusher:           #type proc "c" () -> Sound_Bit_Crusher,
    free_bit_crusher:          #type proc "c" (Sound_Bit_Crusher),
    set_amount:                #type proc "c" (Sound_Bit_Crusher, f32),
    set_amount_modulator:      #type proc "c" (Sound_Bit_Crusher, Sound_Synth_Signal_Value),
    get_amount_modulator:      #type proc "c" (Sound_Bit_Crusher) -> Sound_Synth_Signal_Value,
    set_undersampling:         #type proc "c" (Sound_Bit_Crusher, f32),
    set_undersample_modulator: #type proc "c" (Sound_Bit_Crusher, Sound_Synth_Signal_Value),
    get_undersample_modulator: #type proc "c" (Sound_Bit_Crusher) -> Sound_Synth_Signal_Value,
}

Api_Sound_Effect_Ring_Modulator_Procs :: struct {
    new_ringmod:             #type proc "c" () -> Sound_Ring_Modulator,
    free_ringmod:            #type proc "c" (Sound_Ring_Modulator),
    set_frequency:           #type proc "c" (Sound_Ring_Modulator, f32),
    set_frequency_modulator: #type proc "c" (Sound_Ring_Modulator, Sound_Synth_Signal_Value),
    get_frequency_modulator: #type proc "c" (Sound_Ring_Modulator) -> Sound_Synth_Signal_Value,
}

Api_Sound_Effect_Delay_Line_Procs :: struct {
    new_delay_line:  #type proc "c" (i32, i32) -> Sound_Delay_Line,
    free_delay_line: #type proc "c" (Sound_Delay_Line),
    set_length:      #type proc "c" (Sound_Delay_Line, i32),
    set_feedback:    #type proc "c" (Sound_Delay_Line, f32),
    add_tap:         #type proc "c" (Sound_Delay_Line, i32) -> Sound_Delay_Line_Tap,

    free_tap:                 #type proc "c" (Sound_Delay_Line_Tap),
    set_tap_delay:            #type proc "c" (Sound_Delay_Line_Tap, i32),
    set_tap_delay_modulator:  #type proc "c" (Sound_Delay_Line_Tap, Sound_Synth_Signal_Value),
    get_tap_delay_modulator:  #type proc "c" (Sound_Delay_Line_Tap) -> Sound_Synth_Signal_Value,
    set_tap_channels_flipped: #type proc "c" (Sound_Delay_Line_Tap, i32),
}

Api_Sound_Effect_Overdrive_Procs :: struct {
    new_overdrive:        #type proc "c" () -> Sound_Overdrive,
    free_overdrive:       #type proc "c" (Sound_Overdrive),
    set_gain:             #type proc "c" (Sound_Overdrive, f32),
    set_limit:            #type proc "c" (Sound_Overdrive, f32),
    set_limit_modulator:  #type proc "c" (Sound_Overdrive, Sound_Synth_Signal_Value),
    get_limit_modulator:  #type proc "c" (Sound_Overdrive) -> Sound_Synth_Signal_Value,
    set_offset:           #type proc "c" (Sound_Overdrive, f32),
    set_offset_modulator: #type proc "c" (Sound_Overdrive, Sound_Synth_Signal_Value),
    get_offset_modulator: #type proc "c" (Sound_Overdrive) -> Sound_Synth_Signal_Value,
}

Api_Sound_Effect_Procs :: struct {
    new_effect:        #type proc "c" (Sound_Effect_Proc, rawptr) -> Sound_Effect,
    free_effect:       #type proc "c" (Sound_Effect),
    set_mix:           #type proc "c" (Sound_Effect, f32),
    set_mix_modulator: #type proc "c" (Sound_Effect, Sound_Synth_Signal_Value),
    get_mix_modulator: #type proc "c" (Sound_Effect) -> Sound_Synth_Signal_Value,
    set_user_data:     #type proc "c" (Sound_Effect, rawptr),
    get_user_data:     #type proc "c" (Sound_Effect) -> rawptr,
    
    two_pole_filter: ^Api_Sound_Effect_Two_Pole_Filter_Procs,
    one_pole_filter: ^Api_Sound_Effect_One_Pole_Filter_Procs,
    bit_crusher:     ^Api_Sound_Effect_Bit_Crusher_Procs,
    ring_modulator:  ^Api_Sound_Effect_Ring_Modulator_Procs,
    delay_line:      ^Api_Sound_Effect_Delay_Line_Procs,
    overdrive:       ^Api_Sound_Effect_Overdrive_Procs,
}

Api_Sound_Channel_Procs :: struct {
    new_channel:          #type proc "c" () -> Sound_Channel,
    free_channel:         #type proc "c" (Sound_Channel),
    add_source:           #type proc "c" (Sound_Channel, Sound_Source) -> i32,
    remove_source:        #type proc "c" (Sound_Channel, Sound_Source) -> i32,
    add_callback_source:  #type proc "c" (Sound_Channel, Sound_Audio_Source_Proc, rawptr, i32) -> Sound_Source,
    add_effect:           #type proc "c" (Sound_Channel, Sound_Effect),
    remove_effect:        #type proc "c" (Sound_Channel, Sound_Effect),
    set_volume:           #type proc "c" (Sound_Channel, f32),
    get_volume:           #type proc "c" (Sound_Channel) -> f32,
    set_volume_modulator: #type proc "c" (Sound_Channel, Sound_Synth_Signal_Value),
    get_volume_modulator: #type proc "c" (Sound_Channel) -> Sound_Synth_Signal_Value,
    set_pan:              #type proc "c" (Sound_Channel, f32),
    set_pan_modulator:    #type proc "c" (Sound_Channel, Sound_Synth_Signal_Value),
    get_pan_modulator:    #type proc "c" (Sound_Channel) -> Sound_Synth_Signal_Value,
    get_dry_level_signal: #type proc "c" (Sound_Channel) -> Sound_Synth_Signal_Value,
    get_wet_level_signal: #type proc "c" (Sound_Channel) -> Sound_Synth_Signal_Value,
}
