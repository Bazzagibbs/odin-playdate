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
    control_signal: ^Control_Signal_VTable,
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
    new_sample_buffer:    #type proc "c" (i32) -> Audio_Sample,
    load_into_sample:     #type proc "c" (Audio_Sample, cstring) -> i32,
    load:                 #type proc "c" (cstring) -> Audio_Sample,
    new_sample_from_data: #type proc "c" ([^]u8, Format, u32, i32) -> Audio_Sample,
    get_data:             #type proc "c" (Audio_Sample, ^[^]u8, Format, ^u32, ^u32),
    free_sample:          #type proc "c" (Audio_Sample),
    get_length:           #type proc "c" (Audio_Sample) -> f32,
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
    new_envelope:             #type proc "c" (f32, f32, f32, f32) -> Synth_Envelope,
    free_envelope:            #type proc "c" (Synth_Envelope),
    set_attack:               #type proc "c" (Synth_Envelope, f32),
    set_decay:                #type proc "c" (Synth_Envelope, f32),
    set_sustain:              #type proc "c" (Synth_Envelope, f32),
    set_release:              #type proc "c" (Synth_Envelope, f32),
    set_legato:               #type proc "c" (Synth_Envelope, i32), 
    set_retrigger:            #type proc "c" (Synth_Envelope, i32),
    get_value:                #type proc "c" (Synth_Envelope) -> f32,
    set_curvature:            #type proc "c" (Synth_Envelope, f32),
    set_velocity_sensitivity: #type proc "c" (Synth_Envelope, f32),
    set_rate_scaling:         #type proc "c" (Synth_Envelope, f32, MIDI_Note, MIDI_Note),
}

Synth_VTable :: struct {
    new_synth:                #type proc "c" () -> Synth,
    free_synth:               #type proc "c" (Synth),
    set_waveform:             #type proc "c" (Synth, Waveform),
    set_generator:            #type proc "c" (Synth, i32, Synth_Render_Proc, Synth_Note_On_Proc, Synth_Release_Proc, Synth_Set_Parameter_Proc, Synth_Dealloc_Proc, rawptr),
    set_sample:               #type proc "c" (Synth, Audio_Sample, u32, u32),
    set_attack_time:          #type proc "c" (Synth, f32),
    set_decay_time:           #type proc "c" (Synth, f32),
    set_sustain_level:        #type proc "c" (Synth, f32), 
    set_release_time:         #type proc "c" (Synth, f32), 
    set_transpose:            #type proc "c" (Synth, f32),
    set_frequency_modulator:  #type proc "c" (Synth, Synth_Signal_Value),
    get_frequrency_modulator: #type proc "c" (Synth) -> Synth_Signal_Value,
    set_amplitude_modulator:  #type proc "c" (Synth, Synth_Signal_Value), 
    get_amplitude_modulator:  #type proc "c" (Synth) -> Synth_Signal_Value,
    get_parameter_count:      #type proc "c" (Synth) -> i32,
    set_parameter:            #type proc "c" (Synth, i32, f32) -> i32,
    set_parameter_modulator:  #type proc "c" (Synth, i32, Synth_Signal_Value),
    get_parameter_modulator:  #type proc "c" (Synth, i32) -> Synth_Signal_Value,
    play_note:                #type proc "c" (Synth, f32, f32, f32, u32),
    play_midi_note:           #type proc "c" (Synth, MIDI_Note, f32, f32, u32),
    note_off:                 #type proc "c" (Synth, u32),
    stop:                     #type proc "c" (Synth),
    set_volume:               #type proc "c" (Synth, f32, f32),
    get_volume:               #type proc "c" (Synth, ^f32, ^f32),
    is_playing:               #type proc "c" (Synth) -> i32,
    get_envelope:             #type proc "c" (Synth) -> Synth_Envelope,
}

Control_Signal_VTable :: struct {
    new_signal:                 #type proc "c" () -> Control_Signal,
    free_signal:                #type proc "c" (Control_Signal),
    clear_events:               #type proc "c" (Control_Signal),
    add_event:                  #type proc "c" (Control_Signal, i32, f32, i32),
    remove_event:               #type proc "c" (Control_Signal, i32),
    get_midi_controller_number: #type proc "c" (Control_Signal) -> i32,
}

Instrument_VTable :: struct {
    new_instrument:       #type proc "c" () -> Synth_Instrument,
    free_instrument:      #type proc "c" (Synth_Instrument),
    add_voice:            #type proc "c" (Synth_Instrument, Synth, MIDI_Note, MIDI_Note, f32) -> i32,
    play_note:            #type proc "c" (Synth_Instrument, f32, f32, f32, u32) -> Synth,
    play_midi_note:       #type proc "c" (Synth_Instrument, MIDI_Note, f32, f32, u32) -> Synth,
    set_pitch_bend:       #type proc "c" (Synth_Instrument, f32),
    set_pitch_bend_range: #type proc "c" (Synth_Instrument, f32),
    set_transpose:        #type proc "c" (Synth_Instrument, f32),
    note_off:             #type proc "c" (Synth_Instrument, MIDI_Note, u32),
    all_notes_off:        #type proc "c" (Synth_Instrument, u32),
    set_volume:           #type proc "c" (Synth_Instrument, f32, f32),
    get_volume:           #type proc "c" (Synth_Instrument, ^f32, ^f32),
    active_voice_count:   #type proc "c" (Synth_Instrument) -> i32,
}

Track_VTable :: struct {
    new_track:                 #type proc "c" () -> Sequence_Track,
    free_track:                #type proc "c" (Sequence_Track),
    set_instrument:            #type proc "c" (Sequence_Track, Synth_Instrument),
    get_instrument:            #type proc "c" (Sequence_Track) -> Synth_Instrument,
    add_note_event:            #type proc "c" (Sequence_Track, u32, u32, MIDI_Note, f32),
    remove_note_event:         #type proc "c" (Sequence_Track, u32, MIDI_Note),
    clear_notes:               #type proc "c" (Sequence_Track),
    get_control_signal_count:  #type proc "c" (Sequence_Track) -> i32,
    get_control_signal:        #type proc "c" (Sequence_Track, i32) -> Control_Signal,
    clear_control_events:      #type proc "c" (Sequence_Track),
    get_polyphony:             #type proc "c" (Sequence_Track) -> i32,
    active_voice_count:        #type proc "c" (Sequence_Track) -> i32,
    set_muted:                 #type proc "c" (Sequence_Track, i32),
    get_length:                #type proc "c" (Sequence_Track) -> u32,
    get_index_for_step:        #type proc "c" (Sequence_Track, u32) -> i32,
    get_note_at_index:         #type proc "c" (Sequence_Track, i32, ^u32, ^u32, ^MIDI_Note, ^f32) -> i32,
    get_signal_for_controller: #type proc "c" (Sequence_Track, i32, i32) -> Control_Signal,
}

Sequence_VTable :: struct {
    new_sequence:       #type proc "c" () -> Sequence,
    free_sequence:      #type proc "c" (Sequence),
    load_midi_file:     #type proc "c" (Sequence, cstring) -> i32,
    get_time:           #type proc "c" (Sequence) -> u32,
    set_time:           #type proc "c" (Sequence, u32),
    set_loops:          #type proc "c" (Sequence, i32, i32, i32),
    get_tempo:          #type proc "c" (Sequence) -> i32,
    set_tempo:          #type proc "c" (Sequence, i32),
    get_track_count:    #type proc "c" (Sequence) -> i32,
    add_track:          #type proc "c" (Sequence) -> Sequence_Track,
    get_track_at_index: #type proc "c" (Sequence, u32) -> Sequence_Track,
    set_track_at_index: #type proc "c" (Sequence, Sequence_Track, u32),
    all_notes_off:      #type proc "c" (Sequence),
    is_playing:         #type proc "c" (Sequence) -> i32,
    get_length:         #type proc "c" (Sequence) -> u32,
    play:               #type proc "c" (Sequence, Sequence_Finished_Callback, rawptr),
    stop:               #type proc "c" (Sequence),
    get_current_step:   #type proc "c" (Sequence, ^i32) -> i32,
    set_current_step:   #type proc "c" (Sequence, i32, i32, i32),
}

Effect_Two_Pole_Filter_VTable :: struct {
    new_filter:               #type proc "c" () -> Two_Pole_Filter,
    free_filter:              #type proc "c" (Two_Pole_Filter),
    set_type:                 #type proc "c" (Two_Pole_Filter, Two_Pole_Filter_Type),
    set_frequency:            #type proc "c" (Two_Pole_Filter, f32),
    set_frequency_modulator:  #type proc "c" (Two_Pole_Filter, Synth_Signal_Value),
    get_frequrency_modulator: #type proc "c" (Two_Pole_Filter) -> Synth_Signal_Value,
    set_gain:                 #type proc "c" (Two_Pole_Filter, f32),
    set_resonance:            #type proc "c" (Two_Pole_Filter, f32),
    set_resonance_modulator:  #type proc "c" (Two_Pole_Filter, Synth_Signal_Value),
    get_resonance_modulator:  #type proc "c" (Two_Pole_Filter) -> Synth_Signal_Value,
}

Effect_One_Pole_Filter_VTable :: struct {
    new_filter:              #type proc "c" () -> One_Pole_Filter,
    free_filter:             #type proc "c" (One_Pole_Filter),
    set_parameter:           #type proc "c" (One_Pole_Filter, f32),
    set_parameter_modulator: #type proc "c" (One_Pole_Filter, Synth_Signal_Value),
    get_parameter_modulator: #type proc "c" (One_Pole_Filter) -> Synth_Signal_Value,
}

Effect_Bit_Crusher_VTable :: struct {
    new_bit_crusher:           #type proc "c" () -> Bit_Crusher,
    free_bit_crusher:          #type proc "c" (Bit_Crusher),
    set_amount:                #type proc "c" (Bit_Crusher, f32),
    set_amount_modulator:      #type proc "c" (Bit_Crusher, Synth_Signal_Value),
    get_amount_modulator:      #type proc "c" (Bit_Crusher) -> Synth_Signal_Value,
    set_undersampling:         #type proc "c" (Bit_Crusher, f32),
    set_undersample_modulator: #type proc "c" (Bit_Crusher, Synth_Signal_Value),
    get_undersample_modulator: #type proc "c" (Bit_Crusher) -> Synth_Signal_Value,
}

Effect_Ring_Modulator_VTable :: struct {
    new_ringmod:             #type proc "c" () -> Ring_Modulator,
    free_ringmod:            #type proc "c" (Ring_Modulator),
    set_frequency:           #type proc "c" (Ring_Modulator, f32),
    set_frequency_modulator: #type proc "c" (Ring_Modulator, Synth_Signal_Value),
    get_frequency_modulator: #type proc "c" (Ring_Modulator) -> Synth_Signal_Value,
}

Effect_Delay_Line_VTable :: struct {
    new_delay_line:  #type proc "c" (i32, i32) -> Delay_Line,
    free_delay_line: #type proc "c" (Delay_Line),
    set_length:      #type proc "c" (Delay_Line, i32),
    set_feedback:    #type proc "c" (Delay_Line, f32),
    add_tap:         #type proc "c" (Delay_Line, i32) -> Delay_Line_Tap,

    free_tap:                 #type proc "c" (Delay_Line_Tap),
    set_tap_delay:            #type proc "c" (Delay_Line_Tap, i32),
    set_tap_delay_modulator:  #type proc "c" (Delay_Line_Tap, Synth_Signal_Value),
    get_tap_delay_modulator:  #type proc "c" (Delay_Line_Tap) -> Synth_Signal_Value,
    set_tap_channels_flipped: #type proc "c" (Delay_Line_Tap, i32),
}

Effect_Overdrive_VTable :: struct {
    new_overdrive:        #type proc "c" () -> Overdrive,
    free_overdrive:       #type proc "c" (Overdrive),
    set_gain:             #type proc "c" (Overdrive, f32),
    set_limit:            #type proc "c" (Overdrive, f32),
    set_limit_modulator:  #type proc "c" (Overdrive, Synth_Signal_Value),
    get_limit_modulator:  #type proc "c" (Overdrive) -> Synth_Signal_Value,
    set_offset:           #type proc "c" (Overdrive, f32),
    set_offset_modulator: #type proc "c" (Overdrive, Synth_Signal_Value),
    get_offset_modulator: #type proc "c" (Overdrive) -> Synth_Signal_Value,
}

Effect_VTable :: struct {
    new_effect:        #type proc "c" (Effect_Proc, rawptr) -> Effect,
    free_effect:       #type proc "c" (Effect),
    set_mix:           #type proc "c" (Effect, f32),
    set_mix_modulator: #type proc "c" (Effect, Synth_Signal_Value),
    get_mix_modulator: #type proc "c" (Effect) -> Synth_Signal_Value,
    set_user_data:     #type proc "c" (Effect, rawptr),
    get_user_data:     #type proc "c" (Effect) -> rawptr,
    
    two_pole_filter: ^Effect_Two_Pole_Filter_VTable,
    one_pole_filter: ^Effect_One_Pole_Filter_VTable,
    bit_crusher:     ^Effect_Bit_Crusher_VTable,
    ring_modulator:  ^Effect_Ring_Modulator_VTable,
    delay_line:      ^Effect_Delay_Line_VTable,
    overdrive:       ^Effect_Overdrive_VTable,
}

Channel_VTable :: struct {
    new_channel:          #type proc "c" () -> Channel,
    free_channel:         #type proc "c" (Channel),
    add_source:           #type proc "c" (Channel, Source) -> i32,
    remove_source:        #type proc "c" (Channel, Source) -> i32,
    add_callback_source:  #type proc "c" (Channel, Audio_Source_Proc, rawptr, i32) -> Source,
    add_effect:           #type proc "c" (Channel, Effect),
    remove_effect:        #type proc "c" (Channel, Effect),
    set_volume:           #type proc "c" (Channel, f32),
    get_volume:           #type proc "c" (Channel) -> f32,
    set_volume_modulator: #type proc "c" (Channel, Synth_Signal_Value),
    get_volume_modulator: #type proc "c" (Channel) -> Synth_Signal_Value,
    set_pan:              #type proc "c" (Channel, f32),
    set_pan_modulator:    #type proc "c" (Channel, Synth_Signal_Value),
    get_pan_modulator:    #type proc "c" (Channel) -> Synth_Signal_Value,
    get_dry_level_signal: #type proc "c" (Channel) -> Synth_Signal_Value,
    get_wet_level_signal: #type proc "c" (Channel) -> Synth_Signal_Value,
}

