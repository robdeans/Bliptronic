 //
 //  Conductor.swift
 //  Bliptronic
 //
 //  Created by Robert Deans on 5/17/17.
 //  Copyright © 2017 Robert Deans. All rights reserved.
 //
 
 import AudioKit
 
 class Conductor {
    
    static let sharedInstance = Conductor()
    
    //MARK: Midi
    let midi = AKMIDI()
    var midiNode: AKMIDINode!
    
    //MARK: Sequencer
    var sequencer = AKSequencer()
    var currentTempo = 220.0 {
        didSet {
            sequencer.setTempo(currentTempo)
        }
    }
    var isPlaying = true {
        didSet {
            if isPlaying {
                sequencer.play()
            } else {
                sequencer.stop()
            }
        }
    }
    
    //MARK: Instrument rack
    var instrumentRack = InstrumentRack()
    var selectedInstrument: InstrumentRackEnum! = InstrumentRackEnum(rawValue: 0) {
        didSet {
            configure(for: selectedInstrument)
        }
    }

    //MARK: Effects
    var reverb = AKReverb2(nil)
    var filter = AKKorgLowPassFilter(nil)
    var mixer = AKMixer()


    //MARK: Init() methods
    init() {
        configure(for: selectedInstrument)
        sequencer.enableLooping()
        sequencer.setTempo(220)
        sequencer.play()
//        instrumentRack.selectedInstrument.
    }

    func configure(for instrument: InstrumentRackEnum) {
        
        switch selectedInstrument.rawValue {
        case 0:
            midiNode = AKMIDINode(node: instrumentRack.fmOscillator)
            midiNode.enableMIDI(midi.client, name: "synth midi in")
            addStandardEffects(for: midiNode)
            print("fm")
        case 1:
            midiNode = AKMIDINode(node: instrumentRack.morphingOscillator)
            midiNode.enableMIDI(midi.client, name: "synth midi in")
            addStandardEffects(for: midiNode)
            print("morphing")
        case 2:
            midiNode = AKMIDINode(node: instrumentRack.phaseDistortionOscillator)
            midiNode.enableMIDI(midi.client, name: "synth midi in")
            addStandardEffects(for: midiNode)
            print("phase")
        case 3:
            midiNode = AKMIDINode(node: instrumentRack.pwmOscillator)
            midiNode.enableMIDI(midi.client, name: "synth midi in")
            addStandardEffects(for: midiNode)
            print("pwm")
        default:
            break
        }
    }
    
    func addStandardEffects(for midiNode: AKMIDINode) {
        reverb = AKReverb2(nil)
        filter = AKKorgLowPassFilter(nil)
        sequencer.stop()

        reverb = AKReverb2(midiNode)
        reverb.dryWetMix = 0.5
        reverb.decayTimeAt0Hz = 7
        reverb.decayTimeAtNyquist = 11
        reverb.randomizeReflections = 600
        reverb.gain = 1

        filter = AKKorgLowPassFilter(reverb)
        filter.resonance = 1.0
        filter.cutoffFrequency = 2500
        
        mixer.connect(filter)
        AudioKit.output = mixer
        AudioKit.start()
        
        let sequenceLength = AKDuration(beats: 8.0)
        
        for number in 0...7 {
            let _ = sequencer.newTrack()
            sequencer.setLength(sequenceLength)
            sequencer.tracks[number].setMIDIOutput(midiNode.midiIn)
        }
        
        if isPlaying {
            sequencer.play()
        }
    }
 }
 
 // MARK: Add / Remove Notes
 extension Conductor {
 
    func generateNote(for blip: Blip) {
        let position = AKDuration(beats: Double(blip.column))
        let duration = AKDuration(seconds: 0.74)
        var note: UInt8 = 0
        
        switch blip.row {
        case 1:
            note = 60
        case 2:
            note = 62
        case 3:
            note = 64
        case 4:
            note = 65
        case 5:
            note = 67
        case 6:
            note = 69
        case 7:
            note = 71
        case 8:
            note = 72
        default:
            break
        }
        
        // TODO: how many tracks are actually needed?
        sequencer.tracks[blip.column].add(noteNumber: MIDINoteNumber(note), velocity: 120, position: position, duration: duration)
    }
    
    func removeNote(for blip: Blip) {
        var note: UInt8 = 0
        
        switch blip.row {
        case 1:
            note = 60
        case 2:
            note = 62
        case 3:
            note = 64
        case 4:
            note = 65
        case 5:
            note = 67
        case 6:
            note = 69
        case 7:
            note = 71
        case 8:
            note = 72
        default:
            break
        }
        
        //TODO: Same as above
        sequencer.tracks[blip.column].clearNote(MIDINoteNumber(note))
    }
 }
