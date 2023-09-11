package playdate_sound

// If someone is bored enough, feel free to fill out the parameter names :)

vtable: ^VTable

VTable :: struct {
    channel:        ^Channel_VTable,
    file_player:    ^File_Player_VTable,
    sample:         ^Sample_VTable,
    sample_player:  ^Sample_Player_VTable,
    synth:          ^Synth_VTable,
    sequence:       ^Sequence_VTable,
    effect:         ^Effect_VTable,
    lfo:            ^LFO_VTable,
    envelope:       ^Envelope_VTable,
    source:         ^Source_VTable,
    control_signal: ^Control_Signal,
    track:          ^Track_VTable,
    instrument:     ^Instrument_VTable,

    get_current_time:    #type proc "c" () -> u32,
    add_source:          #type proc "c" (Audio_Source_Proc, rawptr, i32) -> Source,
    get_default_channel: #type proc "c" () -> Channel,
    add_channel:         #type proc "c" (Channel) -> i32,
    remove_channel:      #type proc "c" (Channel) -> i32,
    set_mic_callback:    #type proc "c" (Record_Callback, rawptr, i32),
    get_headphone_state: #type proc "c" (^i32, ^i32, Change_Callback),
    set_outputs_active:  #type proc "c" (i32, i32),

    remove_source: #type proc "c" (Source) -> i32,

    signal: ^Signal_VTable,
}

Source_VTable :: struct {
    set_volume:          #type proc "c" (Source, f32, f32),
    get_volume:          #type proc "c" (Source, ^f32, ^f32),
    is_playing:          #type proc "c" (Source) -> i32,
    set_finish_callback: #type proc "c" (Source, Callback_Proc),
}

File_Player_VTable :: struct {
    new_player:            #type proc "c" () -> File_Player,
    free_player:           #type proc "c" (File_Player),
    load_into_player:      #type proc "c" (File_Player, cstring) -> i32,
    set_buffer_length:     #type proc "c" (File_Player, f32),
    play:                  #type proc "c" (File_Player, f32) -> i32,
    is_playing:            #type proc "c" (File_Player) -> i32,
    pause:                 #type proc "c" (File_Player),
    stop:                  #type proc "c" (File_Player),
    set_volume:            #type proc "c" (File_Player, f32, f32),
    get_volume:            #type proc "c" (File_Player, ^f32, ^f32),
    get_length:            #type proc "c" (File_Player) -> f32,
    set_offset:            #type proc "c" (File_Player, f32),
    set_rate:              #type proc "c" (File_Player, f32),
    set_loop_range:        #type proc "c" (File_Player, f32, f32),
    did_underrun:          #type proc "c" (File_Player) -> i32,
    set_finish_callback:   #type proc "c" (File_Player, Callback_Proc),
    set_loop_callback:     #type proc "c" (File_Player, Callback_Proc),
    get_offset:            #type proc "c" (File_Player) -> f32,
    get_rate:              #type proc "c" (File_Player) -> f32,
    set_stop_on_underrun:  #type proc "c" (File_Player, i32),
    fade_volume:           #type proc "c" (File_Player, f32, f32, i32, Callback_Proc),
    set_mp3_stream_source: #type proc "c" (File_Player, Data_Source_Proc, rawptr, f32),
}

Sample_VTable :: struct {
    new_sample_buffer:    #type proc "c" (i32) -> Sample,
    load_into_sample:     #type proc "c" (Sample, cstring) -> i32,
    load:                 #type proc "c" (cstring) -> Sample,
    new_sample_from_data: #type proc "c" ([^]u8, Format, u32, i32) -> Sample,
    get_data:             #type proc "c" (Sample, ^[^]u8, Format, ^u32, ^u32),
    free_sample:          #type proc "c" (Sample),
    get_length:           #type proc "c" (Sample) -> f32,
}

Sample_Player_VTable :: struct { // Extends SoundSource
    new_player:          #type proc "c" () -> Sample_Player,
    free_player:         #type proc "c" (Sample_Player),
    set_sample:          #type proc "c" (Sample_Player, Audio_Sample),
    play:                #type proc "c" (Sample_Player, i32, f32) -> i32,
    is_playing:          #type proc "c" (Sample_Player) -> i32,
    stop:                #type proc "c" (Sample_Player),
    set_volume:          #type proc "c" (Sample_Player, f32, f32),
    get_volume:          #type proc "c" (Sample_Player, ^f32, ^f32),
    get_length:          #type proc "c" (Sample_Player) -> f32,
    set_offset:          #type proc "c" (Sample_Player, f32),
    set_rate:            #type proc "c" (Sample_Player, f32),
    set_play_range:      #type proc "c" (Sample_Player, i32, i32),
    set_finish_callback: #type proc "c" (Sample_Player, Callback_Proc),
    set_loop_callback:   #type proc "c" (Sample_Player, Callback_Proc),
    get_offset:          #type proc "c" (Sample_Player) -> f32,
    get_rate:            #type proc "c" (Sample_Player) -> f32,
    set_paused:          #type proc "c" (Sample_Player, i32),
}

Signal_VTable :: struct {
    new_signal:       #type proc "c" (Signal_Step_Proc, Signal_Note_On_Proc, Signal_Note_Off_Proc, Signal_Dealloc_Proc, rawptr) -> Synth_Signal,
    free_signal:      #type proc "c" (Synth_Signal),
    get_value:        #type proc "c" (Synth_Signal) -> f32,
    set_value_scale:  #type proc "c" (Synth_Signal, f32),
    set_value_offset: #type proc "c" (Synth_Signal, f32),
}

LFO_VTable :: struct {
    new_lfo:          #type proc "c" (LFO_Type) -> Synth_LFO,
    free_lfo:         #type proc "c" (Synth_LFO),
    set_type:         #type proc "c" (Synth_LFO, LFO_Type),
    set_rate:         #type proc "c" (Synth_LFO, f32),
    set_phase:        #type proc "c" (Synth_LFO, f32),
    set_center:       #type proc "c" (Synth_LFO, f32),
    set_depth:        #type proc "c" (Synth_LFO, f32),
    set_arpeggiation: #type proc "c" (Synth_LFO, i32, [^]f32),
    set_function:     #type proc "c" (Synth_LFO, LFO_Func, rawptr, i32),
    set_delay:        #type proc "c" (Synth_LFO, f32, f32),
    set_retrigger:    #type proc "c" (Synth_LFO, i32),
    get_value:        #type proc "c" (Synth_LFO) -> f32,
    set_global:       #type proc "c" (Synth_LFO, i32),
}

Envelope_VTable :: struct {
    new_envelope:             #type proc "c" (
    free_envelope:            #type proc "c" (
    set_attack:               #type proc "c" (
    set_decay:                #type proc "c" (
    set_sustain:              #type proc "c" (
    set_release:              #type proc "c" (
    set_legato:               #type proc "c" (
    set_retrigger:            #type proc "c" (
    get_value:                #type proc "c" (
    set_curvature:            #type proc "c" (
    set_velocity_sensitivity: #type proc "c" (
    set_rate_scaling:         #type proc "c" (
}

Synth_VTable :: struct {
    new_synth:                #type proc "c" (
    free_synth:               #type proc "c" (
    set_waveform:             #type proc "c" (
    set_generator:            #type proc "c" (
    set_sample:               #type proc "c" (
    set_attack_time:          #type proc "c" (
    set_decay_time:           #type proc "c" (
    set_sustain_level:        #type proc "c" (
    set_release_time:         #type proc "c" (
    set_transpose:            #type proc "c" (
    set_frequency_modulator:  #type proc "c" (
    get_frequrency_modulator: #type proc "c" (
    set_amplitude_modulator:  #type proc "c" (
    get_amplitude_modulator:  #type proc "c" (
    get_parameter_count:      #type proc "c" (
    set_parameter:            #type proc "c" (
    set_parameter_modulator:  #type proc "c" (
    get_parameter_modulator:  #type proc "c" (
    play_note:                #type proc "c" (
    play_midi_note:           #type proc "c" (
    note_off:                 #type proc "c" (
    stop:                     #type proc "c" (
    set_volume:               #type proc "c" (
    get_volume:               #type proc "c" (
    is_playing:               #type proc "c" (
    get_envelope:             #type proc "c" (
}

Control_Signal_VTable :: struct {
    new_signal:                 #type proc "c" (
    free_signal:                #type proc "c" (
    clear_events:               #type proc "c" (
    add_event:                  #type proc "c" (
    remove_event:               #type proc "c" (
    get_midi_controller_number: #type proc "c" (
}

Instrument_VTable :: struct {
    new_instrument:       #type proc "c" (
    free_instrument:      #type proc "c" (
    add_voice:            #type proc "c" (
    play_note:            #type proc "c" (
    play_midi_note:       #type proc "c" (
    set_pitch_bend:       #type proc "c" (
    set_pitch_bend_range: #type proc "c" (
    set_transpose:        #type proc "c" (
    note_off:             #type proc "c" (
    all_notes_off:        #type proc "c" (
    set_volume:           #type proc "c" (
    get_volume:           #type proc "c" (
    active_voice_count:   #type proc "c" (
}

Track_VTable :: struct {
    new_track:                 #type proc "c" (
    free_track:                #type proc "c" (
    set_instrument:            #type proc "c" (
    get_instrument:            #type proc "c" (
    add_note_event:            #type proc "c" (
    remove_note_event:         #type proc "c" (
    clear_notes:               #type proc "c" (
    get_control_signal_count:  #type proc "c" (
    get_control_signal:        #type proc "c" (
    clear_control_events:      #type proc "c" (
    get_polyphony:             #type proc "c" (
    active_voice_count:        #type proc "c" (
    set_muted:                 #type proc "c" (
    get_length:                #type proc "c" (
    get_index_for_step:        #type proc "c" (
    get_note_at_index:         #type proc "c" (
    get_signal_for_controller: #type proc "c" (
}

Sequence_VTable :: struct {
    new_sequence:       #type proc "c" (
    free_sequence:      #type proc "c" (
    load_midi_file:     #type proc "c" (
    get_time:           #type proc "c" (
    set_time:           #type proc "c" (
    set_loops:          #type proc "c" (
    get_tempo:          #type proc "c" (
    set_tempo:          #type proc "c" (
    get_track_count:    #type proc "c" (
    add_track:          #type proc "c" (
    get_track_at_index: #type proc "c" (
    set_track_at_index: #type proc "c" (
    all_notes_off:      #type proc "c" (
    is_playing:         #type proc "c" (
    get_length:         #type proc "c" (
    play:               #type proc "c" (
    stop:               #type proc "c" (
    get_current_step:   #type proc "c" (
    set_current_step:   #type proc "c" (
}

Effect_Two_Pole_Filter_VTable :: struct {
    new_filter:               #type proc "c" (
    free_filter:              #type proc "c" (
    set_type:                 #type proc "c" (
    set_frequency:            #type proc "c" (
    set_frequency_modulator:  #type proc "c" (
    get_frequrency_modulator: #type proc "c" (
    set_gain:                 #type proc "c" (
    set_resonance:            #type proc "c" (
    set_resonance_modulator:  #type proc "c" (
    get_resonance_modulator:  #type proc "c" (
}

Effect_One_Pole_Filter_VTable :: struct {
    new_filter:              #type proc "c" (
    free_filter:             #type proc "c" (
    set_parameter:           #type proc "c" (
    set_parameter_modulator: #type proc "c" (
    get_parameter_modulator: #type proc "c" (
}

Effect_Bit_Crusher_VTable :: struct {
    new_bit_crusher:           #type proc "c" (
    free_bit_crusher:          #type proc "c" (
    set_amount:                #type proc "c" (
    set_amount_modulator:      #type proc "c" (
    get_amount_modulator:      #type proc "c" (
    set_undersampling:         #type proc "c" (
    set_undersample_modulator: #type proc "c" (
    get_undersample_modulator: #type proc "c" (
}

Effect_Ring_Modulator_VTable :: struct {
    new_ringmod:             #type proc "c" (
    free_ringmod:            #type proc "c" (
    set_frequency:           #type proc "c" (
    set_frequency_modulator: #type proc "c" (
    get_frequency_modulator: #type proc "c" (
}

Effect_Delay_Line_VTable :: struct {
    new_delay_line:  #type proc "c" (
    free_delay_line: #type proc "c" (
    set_length:      #type proc "c" (
    set_feedback:    #type proc "c" (
    add_tap:         #type proc "c" (

    free_tap:                 #type proc "c" (
    set_tap_delay:            #type proc "c" (
    set_tap_delay_modulator:  #type proc "c" (
    get_tap_delay_modulator:  #type proc "c" (
    set_tap_channels_flipped: #type proc "c" (
}

Effect_Overdrive_VTable :: struct {
    new_overdrive:        #type proc "c" (
    free_overdrive:       #type proc "c" (
    set_gain:             #type proc "c" (
    set_limit:            #type proc "c" (
    set_limit_modulator:  #type proc "c" (
    get_limit_modulator:  #type proc "c" (
    set_offset:           #type proc "c" (
    set_offset_modulator: #type proc "c" (
    get_offset_modulator: #type proc "c" (
}

Effect_VTable :: struct {
    new_effect:        #type proc "c" (
    free_effect:       #type proc "c" (
    set_mix:           #type proc "c" (
    set_mix_modulator: #type proc "c" (
    get_mix_modulator: #type proc "c" (
    set_user_data:     #type proc "c" (
    get_user_data:     #type proc "c" (
    
    two_pole_filter: #type proc "c" (
    one_pole_filter: #type proc "c" (
    bit_crusher:     #type proc "c" (
    ring_modulator:  #type proc "c" (
    delay_line:      #type proc "c" (
    overdrive:       #type proc "c" (
}

Channel_VTable :: struct {
    new_channel:          #type proc "c" (
    free_channel:         #type proc "c" (
    add_source:           #type proc "c" (
    remove_source:        #type proc "c" (
    add_callback_source:  #type proc "c" (
    add_effect:           #type proc "c" (
    remove_effect:        #type proc "c" (
    set_volume:           #type proc "c" (
    get_volume:           #type proc "c" (
    set_volume_modulator: #type proc "c" (
    get_volume_modulator: #type proc "c" (
    set_pan:              #type proc "c" (
    set_pan_modulator:    #type proc "c" (
    get_pan_modulator:    #type proc "c" (
    get_dry_level_signal: #type proc "c" (
    get_wet_level_signal: #type proc "c" (
}
