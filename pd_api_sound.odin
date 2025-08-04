//
//  pdext_sound.h
//  Playdate Simulator
//
//  Created by Dave Hayden on 10/6/17.
//  Copyright © 2017 Panic, Inc. All rights reserved.
//
package playdate

import "core:c"

_ :: c



AUDIO_FRAMES_PER_CYCLE :: 512

SoundFormat :: enum c.int {
	_8bitMono   = 0,
	_8bitStereo = 1,
	_16bitMono  = 2,
	_16bitStereo = 3,
	ADPCMMono   = 4,
	ADPCMStereo = 5,
}

NOTE_C4 :: 60

MIDINote :: f32

sndCallbackProc :: proc "c" (^SoundSource, rawptr)

// SoundSource is the parent class for FilePlayer, SamplePlayer, PDSynth, and DelayLineTap. You can safely cast those objects to a SoundSource* and use these functions:
playdate_sound_source :: struct {
	setVolume:         proc "c" (^SoundSource, f32, f32),
	getVolume:         proc "c" (^SoundSource, ^f32, ^f32),
	isPlaying:         proc "c" (^SoundSource) -> c.int,
	setFinishCallback: proc "c" (^SoundSource, sndCallbackProc, rawptr),
}

SetMP3StreamSourceCallback :: #type proc "c" (data: [^]u8, bytes: c.int, userdata: rawptr) -> c.int

playdate_sound_fileplayer :: struct {
	newPlayer:          proc "c" (void) -> ^FilePlayer,
	freePlayer:         proc "c" (^FilePlayer),
	loadIntoPlayer:     proc "c" (^FilePlayer, cstring) -> c.int,
	setBufferLength:    proc "c" (^FilePlayer, f32),
	play:               proc "c" (^FilePlayer, c.int) -> c.int,
	isPlaying:          proc "c" (^FilePlayer) -> c.int,
	pause:              proc "c" (^FilePlayer),
	stop:               proc "c" (^FilePlayer),
	setVolume:          proc "c" (^FilePlayer, f32, f32),
	getVolume:          proc "c" (^FilePlayer, ^f32, ^f32),
	getLength:          proc "c" (^FilePlayer) -> f32,
	setOffset:          proc "c" (^FilePlayer, f32),
	setRate:            proc "c" (^FilePlayer, f32),
	setLoopRange:       proc "c" (^FilePlayer, f32, f32),
	didUnderrun:        proc "c" (^FilePlayer) -> c.int,
	setFinishCallback:  proc "c" (^FilePlayer, sndCallbackProc, rawptr),
	setLoopCallback:    proc "c" (^FilePlayer, sndCallbackProc, rawptr),
	getOffset:          proc "c" (^FilePlayer) -> f32,
	getRate:            proc "c" (^FilePlayer) -> f32,
	setStopOnUnderrun:  proc "c" (^FilePlayer, c.int),
	fadeVolume:         proc "c" (^FilePlayer, f32, f32, i32, sndCallbackProc, rawptr),
	setMP3StreamSource: proc "c" (player: ^FilePlayer, callback: SetMP3StreamSourceCallback, userdata: rawptr, bufferLen: f32) -> c.int,
}

playdate_sound_sample :: struct {
	newSampleBuffer:   proc "c" (c.int) -> ^AudioSample,
	loadIntoSample:    proc "c" (^AudioSample, cstring) -> c.int,
	load:              proc "c" (cstring) -> ^AudioSample,
	newSampleFromData: proc "c" (^u8, SoundFormat, u32, c.int, c.int) -> ^AudioSample,
	getData:           proc "c" (^AudioSample, ^^u8, ^SoundFormat, ^u32, ^u32),
	freeSample:        proc "c" (^AudioSample),
	getLength:         proc "c" (^AudioSample) -> f32,

	// 2.4
	decompress: proc "c" (^AudioSample) -> c.int,
}

playdate_sound_sampleplayer :: struct {
	newPlayer:         proc "c" (void) -> ^SamplePlayer,
	freePlayer:        proc "c" (^SamplePlayer),
	setSample:         proc "c" (^SamplePlayer, ^AudioSample),
	play:              proc "c" (^SamplePlayer, c.int, f32) -> c.int,
	isPlaying:         proc "c" (^SamplePlayer) -> c.int,
	stop:              proc "c" (^SamplePlayer),
	setVolume:         proc "c" (^SamplePlayer, f32, f32),
	getVolume:         proc "c" (^SamplePlayer, ^f32, ^f32),
	getLength:         proc "c" (^SamplePlayer) -> f32,
	setOffset:         proc "c" (^SamplePlayer, f32),
	setRate:           proc "c" (^SamplePlayer, f32),
	setPlayRange:      proc "c" (^SamplePlayer, c.int, c.int),
	setFinishCallback: proc "c" (^SamplePlayer, sndCallbackProc, rawptr),
	setLoopCallback:   proc "c" (^SamplePlayer, sndCallbackProc, rawptr),
	getOffset:         proc "c" (^SamplePlayer) -> f32,
	getRate:           proc "c" (^SamplePlayer) -> f32,
	setPaused:         proc "c" (^SamplePlayer, c.int),
}

signalStepFunc :: proc "c" (rawptr, ^c.int, ^f32) -> f32

signalNoteOnFunc :: proc "c" (rawptr, MIDINote, f32, f32) // len = -1 for indefinite

signalNoteOffFunc :: proc "c" (rawptr, c.int, c.int) // stopped = 0 on note release, = 1 when note actually stops playing; offset is # of frames into the current cycle

signalDeallocFunc :: proc "c" (rawptr)

playdate_sound_signal :: struct {
	newSignal:      proc "c" (signalStepFunc, signalNoteOnFunc, signalNoteOffFunc, signalDeallocFunc, rawptr) -> ^PDSynthSignal,
	freeSignal:     proc "c" (^PDSynthSignal),
	getValue:       proc "c" (^PDSynthSignal) -> f32,
	setValueScale:  proc "c" (^PDSynthSignal, f32),
	setValueOffset: proc "c" (^PDSynthSignal, f32),

	// 2.6
	newSignalForValue: proc "c" (^PDSynthSignalValue) -> ^PDSynthSignal,
}

LFOType :: enum c.int {
	Square,
	Triangle,
	Sine,
	SampleAndHold,
	SawtoothUp,
	SawtoothDown,
	Arpeggiator,
	Function,
}

SynthLFOFunc :: #type proc "c" (lfo: ^PDSynthLFO, userdata: rawptr) -> f32

playdate_sound_lfo :: struct {
	newLFO:          proc "c" (LFOType) -> ^PDSynthLFO,
	freeLFO:         proc "c" (^PDSynthLFO),
	setType:         proc "c" (^PDSynthLFO, LFOType),
	setRate:         proc "c" (^PDSynthLFO, f32),
	setPhase:        proc "c" (^PDSynthLFO, f32),
	setCenter:       proc "c" (^PDSynthLFO, f32),
	setDepth:        proc "c" (^PDSynthLFO, f32),
	setArpeggiation: proc "c" (^PDSynthLFO, c.int, ^f32),
	setFunction:     proc "c" (lfo: ^PDSynthLFO, lfoFunc: synthLFOFunc, userdata: rawptr, interpolate: c.int),
	setDelay:        proc "c" (^PDSynthLFO, f32, f32),
	setRetrigger:    proc "c" (^PDSynthLFO, c.int),
	getValue:        proc "c" (^PDSynthLFO) -> f32,

	// 1.10
	setGlobal: proc "c" (^PDSynthLFO, c.int),

	// 2.2
	setStartPhase: proc "c" (^PDSynthLFO, f32),
}

playdate_sound_envelope :: struct {
	newEnvelope:            proc "c" (f32, f32, f32, f32) -> ^PDSynthEnvelope,
	freeEnvelope:           proc "c" (^PDSynthEnvelope),
	setAttack:              proc "c" (^PDSynthEnvelope, f32),
	setDecay:               proc "c" (^PDSynthEnvelope, f32),
	setSustain:             proc "c" (^PDSynthEnvelope, f32),
	setRelease:             proc "c" (^PDSynthEnvelope, f32),
	setLegato:              proc "c" (^PDSynthEnvelope, c.int),
	setRetrigger:           proc "c" (^PDSynthEnvelope, c.int),
	getValue:               proc "c" (^PDSynthEnvelope) -> f32,

	// 1.13
	setCurvature: proc "c" (^PDSynthEnvelope, f32),
	setVelocitySensitivity: proc "c" (^PDSynthEnvelope, f32),
	setRateScaling:         proc "c" (^PDSynthEnvelope, f32, MIDINote, MIDINote),
}

SoundWaveform :: enum c.int {
	Square,
	Triangle,
	Sine,
	Noise,
	Sawtooth,
	POPhase,
	PODigital,
	POVosim,
}

// generator render callback
// samples are in Q8.24 format. left is either the left channel or the single mono channel,
// right is non-NULL only if the stereo flag was set in the setGenerator() call.
// nsamples is at most 256 but may be shorter
// rate is Q0.32 per-frame phase step, drate is per-frame rate step (i.e., do rate += drate every frame)
// return value is the number of sample frames rendered
synthRenderFunc :: proc "c" (rawptr, ^i32, ^i32, c.int, u32, i32) -> c.int

// generator event callbacks
synthNoteOnFunc :: proc "c" (rawptr, MIDINote, f32, f32) // len == -1 if indefinite

synthReleaseFunc :: proc "c" (rawptr, c.int)

synthSetParameterFunc :: proc "c" (rawptr, c.int, f32) -> c.int

synthDeallocFunc :: proc "c" (rawptr)

synthCopyUserdata :: proc "c" (rawptr) -> rawptr

playdate_sound_synth :: struct {
	newSynth:                proc "c" (void) -> ^PDSynth,
	freeSynth:               proc "c" (^PDSynth),
	setWaveform:             proc "c" (^PDSynth, SoundWaveform),
	setGenerator_deprecated: proc "c" (^PDSynth, c.int, synthRenderFunc, synthNoteOnFunc, synthReleaseFunc, synthSetParameterFunc, synthDeallocFunc, rawptr),
	setSample:               proc "c" (^PDSynth, ^AudioSample, u32, u32),
	setAttackTime:           proc "c" (^PDSynth, f32),
	setDecayTime:            proc "c" (^PDSynth, f32),
	setSustainLevel:         proc "c" (^PDSynth, f32),
	setReleaseTime:          proc "c" (^PDSynth, f32),
	setTranspose:            proc "c" (^PDSynth, f32),
	setFrequencyModulator:   proc "c" (^PDSynth, ^PDSynthSignalValue),
	getFrequencyModulator:   proc "c" (^PDSynth) -> ^PDSynthSignalValue,
	setAmplitudeModulator:   proc "c" (^PDSynth, ^PDSynthSignalValue),
	getAmplitudeModulator:   proc "c" (^PDSynth) -> ^PDSynthSignalValue,
	getParameterCount:       proc "c" (^PDSynth) -> c.int,
	setParameter:            proc "c" (^PDSynth, c.int, f32) -> c.int,
	setParameterModulator:   proc "c" (^PDSynth, c.int, ^PDSynthSignalValue),
	getParameterModulator:   proc "c" (^PDSynth, c.int) -> ^PDSynthSignalValue,
	playNote:                proc "c" (^PDSynth, f32, f32, f32, u32),      // len == -1 for indefinite
	playMIDINote:            proc "c" (^PDSynth, MIDINote, f32, f32, u32), // len == -1 for indefinite
	noteOff:                 proc "c" (^PDSynth, u32),                     // move to release part of envelope
	stop:                    proc "c" (^PDSynth),                          // stop immediately
	setVolume:               proc "c" (^PDSynth, f32, f32),
	getVolume:               proc "c" (^PDSynth, ^f32, ^f32),
	isPlaying:               proc "c" (^PDSynth) -> c.int,
	getEnvelope:             proc "c" (^PDSynth) -> ^PDSynthEnvelope,      // synth keeps ownership--don't free this!

	// 2.2
	setWavetable: proc "c" (^PDSynth, ^AudioSample, c.int, c.int, c.int) -> c.int,

	// 2.4
	setGenerator: proc "c" (^PDSynth, c.int, synthRenderFunc, synthNoteOnFunc, synthReleaseFunc, synthSetParameterFunc, synthDeallocFunc, synthCopyUserdata, rawptr),
	copy:                    proc "c" (^PDSynth) -> ^PDSynth,

	// 2.6
	clearEnvelope: proc "c" (^PDSynth),
}

playdate_control_signal :: struct {
	newSignal:               proc "c" (void) -> ^ControlSignal,
	freeSignal:              proc "c" (^ControlSignal),
	clearEvents:             proc "c" (^ControlSignal),
	addEvent:                proc "c" (^ControlSignal, c.int, f32, c.int),
	removeEvent:             proc "c" (^ControlSignal, c.int),
	getMIDIControllerNumber: proc "c" (^ControlSignal) -> c.int,
}

playdate_sound_instrument :: struct {
	newInstrument:     proc "c" (void) -> ^PDSynthInstrument,
	freeInstrument:    proc "c" (^PDSynthInstrument),
	addVoice:          proc "c" (^PDSynthInstrument, ^PDSynth, MIDINote, MIDINote, f32) -> c.int,
	playNote:          proc "c" (^PDSynthInstrument, f32, f32, f32, u32) -> ^PDSynth,
	playMIDINote:      proc "c" (^PDSynthInstrument, MIDINote, f32, f32, u32) -> ^PDSynth,
	setPitchBend:      proc "c" (^PDSynthInstrument, f32),
	setPitchBendRange: proc "c" (^PDSynthInstrument, f32),
	setTranspose:      proc "c" (^PDSynthInstrument, f32),
	noteOff:           proc "c" (^PDSynthInstrument, MIDINote, u32),
	allNotesOff:       proc "c" (^PDSynthInstrument, u32),
	setVolume:         proc "c" (^PDSynthInstrument, f32, f32),
	getVolume:         proc "c" (^PDSynthInstrument, ^f32, ^f32),
	activeVoiceCount:  proc "c" (^PDSynthInstrument) -> c.int,
}

playdate_sound_track :: struct {
	newTrack:              proc "c" (void) -> ^SequenceTrack,
	freeTrack:             proc "c" (^SequenceTrack),
	setInstrument:         proc "c" (^SequenceTrack, ^PDSynthInstrument),
	getInstrument:         proc "c" (^SequenceTrack) -> ^PDSynthInstrument,
	addNoteEvent:          proc "c" (^SequenceTrack, u32, u32, MIDINote, f32),
	removeNoteEvent:       proc "c" (^SequenceTrack, u32, MIDINote),
	clearNotes:            proc "c" (^SequenceTrack),
	getControlSignalCount: proc "c" (^SequenceTrack) -> c.int,
	getControlSignal:      proc "c" (^SequenceTrack, c.int) -> ^ControlSignal,
	clearControlEvents:    proc "c" (^SequenceTrack),
	getPolyphony:          proc "c" (^SequenceTrack) -> c.int,
	activeVoiceCount:      proc "c" (^SequenceTrack) -> c.int,
	setMuted:              proc "c" (^SequenceTrack, c.int),
	getLength:             proc "c" (^SequenceTrack) -> u32, // in steps, includes full last note
	getIndexForStep:       proc "c" (^SequenceTrack, u32) -> c.int,
	getNoteAtIndex:        proc "c" (^SequenceTrack, c.int, ^u32, ^u32, ^MIDINote, ^f32) -> c.int,

	// 1.10
	getSignalForController: proc "c" (^SequenceTrack, c.int, c.int) -> ^ControlSignal,
}

SequenceFinishedCallback :: proc "c" (^SoundSequence, rawptr)

playdate_sound_sequence :: struct {
	newSequence:         proc "c" (void) -> ^SoundSequence,
	freeSequence:        proc "c" (^SoundSequence),
	loadMIDIFile:        proc "c" (^SoundSequence, cstring) -> c.int,
	getTime:             proc "c" (^SoundSequence) -> u32,
	setTime:             proc "c" (^SoundSequence, u32),
	setLoops:            proc "c" (^SoundSequence, c.int, c.int, c.int),
	getTempo_deprecated: proc "c" (^SoundSequence) -> c.int,
	setTempo:            proc "c" (^SoundSequence, f32),
	getTrackCount:       proc "c" (^SoundSequence) -> c.int,
	addTrack:            proc "c" (^SoundSequence) -> ^SequenceTrack,
	getTrackAtIndex:     proc "c" (^SoundSequence, c.uint) -> ^SequenceTrack,
	setTrackAtIndex:     proc "c" (^SoundSequence, ^SequenceTrack, c.uint),
	allNotesOff:         proc "c" (^SoundSequence),

	// 1.1
	isPlaying: proc "c" (^SoundSequence) -> c.int,
	getLength:           proc "c" (^SoundSequence) -> u32, // in steps, includes full last note
	play:                proc "c" (^SoundSequence, SequenceFinishedCallback, rawptr),
	stop:                proc "c" (^SoundSequence),
	getCurrentStep:      proc "c" (^SoundSequence, ^c.int) -> c.int,
	setCurrentStep:      proc "c" (^SoundSequence, c.int, c.int, c.int),

	// 2.5
	getTempo: proc "c" (^SoundSequence) -> f32,
}

TwoPoleFilterType :: enum c.int {
	LowPass,
	HighPass,
	BandPass,
	Notch,
	PEQ,
	LowShelf,
	HighShelf,
}

playdate_sound_effect_twopolefilter :: struct {
	newFilter:             proc "c" (void) -> ^TwoPoleFilter,
	freeFilter:            proc "c" (^TwoPoleFilter),
	setType:               proc "c" (^TwoPoleFilter, TwoPoleFilterType),
	setFrequency:          proc "c" (^TwoPoleFilter, f32),
	setFrequencyModulator: proc "c" (^TwoPoleFilter, ^PDSynthSignalValue),
	getFrequencyModulator: proc "c" (^TwoPoleFilter) -> ^PDSynthSignalValue,
	setGain:               proc "c" (^TwoPoleFilter, f32),
	setResonance:          proc "c" (^TwoPoleFilter, f32),
	setResonanceModulator: proc "c" (^TwoPoleFilter, ^PDSynthSignalValue),
	getResonanceModulator: proc "c" (^TwoPoleFilter) -> ^PDSynthSignalValue,
}

playdate_sound_effect_onepolefilter :: struct {
	newFilter:             proc "c" (void) -> ^OnePoleFilter,
	freeFilter:            proc "c" (^OnePoleFilter),
	setParameter:          proc "c" (^OnePoleFilter, f32),
	setParameterModulator: proc "c" (^OnePoleFilter, ^PDSynthSignalValue),
	getParameterModulator: proc "c" (^OnePoleFilter) -> ^PDSynthSignalValue,
}

playdate_sound_effect_bitcrusher :: struct {
	newBitCrusher:           proc "c" (void) -> ^BitCrusher,
	freeBitCrusher:          proc "c" (^BitCrusher),
	setAmount:               proc "c" (^BitCrusher, f32),
	setAmountModulator:      proc "c" (^BitCrusher, ^PDSynthSignalValue),
	getAmountModulator:      proc "c" (^BitCrusher) -> ^PDSynthSignalValue,
	setUndersampling:        proc "c" (^BitCrusher, f32),
	setUndersampleModulator: proc "c" (^BitCrusher, ^PDSynthSignalValue),
	getUndersampleModulator: proc "c" (^BitCrusher) -> ^PDSynthSignalValue,
}

playdate_sound_effect_ringmodulator :: struct {
	newRingmod:            proc "c" (void) -> ^RingModulator,
	freeRingmod:           proc "c" (^RingModulator),
	setFrequency:          proc "c" (^RingModulator, f32),
	setFrequencyModulator: proc "c" (^RingModulator, ^PDSynthSignalValue),
	getFrequencyModulator: proc "c" (^RingModulator) -> ^PDSynthSignalValue,
}

playdate_sound_effect_delayline :: struct {
	newDelayLine:          proc "c" (c.int, c.int) -> ^DelayLine,
	freeDelayLine:         proc "c" (^DelayLine),
	setLength:             proc "c" (^DelayLine, c.int),
	setFeedback:           proc "c" (^DelayLine, f32),
	addTap:                proc "c" (^DelayLine, c.int) -> ^DelayLineTap,

	// note that DelayLineTap is a SoundSource, not a SoundEffect
	freeTap: proc "c" (^DelayLineTap),
	setTapDelay:           proc "c" (^DelayLineTap, c.int),
	setTapDelayModulator:  proc "c" (^DelayLineTap, ^PDSynthSignalValue),
	getTapDelayModulator:  proc "c" (^DelayLineTap) -> ^PDSynthSignalValue,
	setTapChannelsFlipped: proc "c" (^DelayLineTap, c.int),
}

playdate_sound_effect_overdrive :: struct {
	newOverdrive:       proc "c" (void) -> ^Overdrive,
	freeOverdrive:      proc "c" (^Overdrive),
	setGain:            proc "c" (^Overdrive, f32),
	setLimit:           proc "c" (^Overdrive, f32),
	setLimitModulator:  proc "c" (^Overdrive, ^PDSynthSignalValue),
	getLimitModulator:  proc "c" (^Overdrive) -> ^PDSynthSignalValue,
	setOffset:          proc "c" (^Overdrive, f32),
	setOffsetModulator: proc "c" (^Overdrive, ^PDSynthSignalValue),
	getOffsetModulator: proc "c" (^Overdrive) -> ^PDSynthSignalValue,
}

effectProc :: proc "c" (^SoundEffect, ^i32, ^i32, c.int, c.int) -> c.int // samples are in signed q8.24 format

playdate_sound_effect :: struct {
	newEffect:       proc "c" (effectProc, rawptr) -> ^SoundEffect,
	freeEffect:      proc "c" (^SoundEffect),
	setMix:          proc "c" (^SoundEffect, f32),
	setMixModulator: proc "c" (^SoundEffect, ^PDSynthSignalValue),
	getMixModulator: proc "c" (^SoundEffect) -> ^PDSynthSignalValue,
	setUserdata:     proc "c" (^SoundEffect, rawptr),
	getUserdata:     proc "c" (^SoundEffect) -> rawptr,
	twopolefilter:   ^playdate_sound_effect_twopolefilter,
	onepolefilter:   ^playdate_sound_effect_onepolefilter,
	bitcrusher:      ^playdate_sound_effect_bitcrusher,
	ringmodulator:   ^playdate_sound_effect_ringmodulator,
	delayline:       ^playdate_sound_effect_delayline,
	overdrive:       ^playdate_sound_effect_overdrive,
}

AudioSourceFunction :: proc "c" (rawptr, ^i16, ^i16, c.int) -> c.int // len is # of samples in each buffer, function should return 1 if it produced output

playdate_sound_channel :: struct {
	newChannel:         proc "c" (void) -> ^SoundChannel,
	freeChannel:        proc "c" (^SoundChannel),
	addSource:          proc "c" (^SoundChannel, ^SoundSource) -> c.int,
	removeSource:       proc "c" (^SoundChannel, ^SoundSource) -> c.int,
	addCallbackSource:  proc "c" (^SoundChannel, AudioSourceFunction, rawptr, c.int) -> ^SoundSource,
	addEffect:          proc "c" (^SoundChannel, ^SoundEffect) -> c.int,
	removeEffect:       proc "c" (^SoundChannel, ^SoundEffect) -> c.int,
	setVolume:          proc "c" (^SoundChannel, f32),
	getVolume:          proc "c" (^SoundChannel) -> f32,
	setVolumeModulator: proc "c" (^SoundChannel, ^PDSynthSignalValue),
	getVolumeModulator: proc "c" (^SoundChannel) -> ^PDSynthSignalValue,
	setPan:             proc "c" (^SoundChannel, f32),
	setPanModulator:    proc "c" (^SoundChannel, ^PDSynthSignalValue),
	getPanModulator:    proc "c" (^SoundChannel) -> ^PDSynthSignalValue,
	getDryLevelSignal:  proc "c" (^SoundChannel) -> ^PDSynthSignalValue,
	getWetLevelSignal:  proc "c" (^SoundChannel) -> ^PDSynthSignalValue,
}

RecordCallback :: proc "c" (rawptr, ^i16, c.int) -> c.int // data is mono

MicSource :: enum c.int {
	Autodetect = 0,
	Internal   = 1,
	Headset    = 2,
}

PDHeadphoneStateChangeCallback :: #type proc "c" (headphone: c.int, mic: c.int)

playdate_sound :: struct {
	channel:           ^playdate_sound_channel,
	fileplayer:        ^playdate_sound_fileplayer,
	sample:            ^playdate_sound_sample,
	sampleplayer:      ^playdate_sound_sampleplayer,
	synth:             ^playdate_sound_synth,
	sequence:          ^playdate_sound_sequence,
	effect:            ^playdate_sound_effect,
	lfo:               ^playdate_sound_lfo,
	envelope:          ^playdate_sound_envelope,
	source:            ^playdate_sound_source,
	controlsignal:     ^playdate_control_signal,
	track:             ^playdate_sound_track,
	instrument:        ^playdate_sound_instrument,
	getCurrentTime:    proc "c" (void) -> u32,
	addSource:         proc "c" (AudioSourceFunction, rawptr, c.int) -> ^SoundSource,
	getDefaultChannel: proc "c" (void) -> ^SoundChannel,
	addChannel:        proc "c" (^SoundChannel) -> c.int,
	removeChannel:     proc "c" (^SoundChannel) -> c.int,
	setMicCallback:    proc "c" (RecordCallback, rawptr, MicSource) -> c.int,
	getHeadphoneState: proc "c" (headphone: ^c.int, headsetmic: ^c.int, changeCallback: HeadphoneStateChangeCallback),
	setOutputsActive:  proc "c" (c.int, c.int),

	// 1.5
	removeSource: proc "c" (^SoundSource) -> c.int,

	// 1.12
	signal: ^playdate_sound_signal,

	// 2.2
	getError: proc "c" (void) -> cstring,
}

@(default_calling_convention="c", link_prefix="")
foreign lib {
	SoundFormat_bytesPerFrame :: proc(fmt: SoundFormat) -> u32 ---
	pd_noteToFrequency        :: proc(n: MIDINote) -> f32 ---
	pd_frequencyToNote        :: proc(f: f32) -> MIDINote ---
}
