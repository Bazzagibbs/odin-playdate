package playdate_sound
import "core:math"
sound_format_is_stereo :: #force_inline proc "contextless" (format: Sound_Format) -> bool {
    return (i32(format) & 1) != 0
}

sound_format_is_16_bit :: #force_inline proc "contextless" (format: Sound_Format) -> bool {
    return format >= .mono_16_bit
}

sound_format_bytes_per_frame :: #force_inline proc "contextless" (format: Sound_Format) -> u32 {
    return (2 if sound_format_is_stereo(format) else 1) * (2 if sound_format_is_16_bit(format) else 1)
}

note_to_frequency :: #force_inline proc "contextless"  (note: MIDI_Note) -> f32 {
    return 440 * math.pow_f32(2, (f32(note-69)) / 12)
}

frequency_to_note :: #force_inline proc "contextless" (freq: f32) -> MIDI_Note {
    return MIDI_Note(12 * math.log2_f32(freq) - 36.376316562)
}



