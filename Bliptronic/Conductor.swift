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
    
    let midi = AKMIDI()
    
    var midiNode: AKMIDINode!
    var instrumentRack = InstrumentRack()
    var selectedInstrument: InstrumentRackEnum! {
        didSet {
            print("did set")
            setUpMidiNode(with: selectedInstrument)
        }
    }
    
    var reverb: AKReverb2!
    var filter: AKMoogLadder!
    var mixer = AKMixer()
    var compressor: AKCompressor!
    
    var sequence = AKSequencer()
    var currentTempo = 220.0 {
        didSet {
            sequence.setTempo(currentTempo)
        }
    }
    
    init() {
        selectedInstrument = InstrumentRackEnum(rawValue: 0)
        setUpMidiNode(with: selectedInstrument)
        /*
        midiNode = AKMIDINode(node: instrumentRack.fmOscillator)
        
        midiNode.enableMIDI(midi.client, name: "synth midi in")
        
        reverb = AKReverb2(midiNode)
        reverb.dryWetMix = 0.5
        reverb.decayTimeAt0Hz = 7
        reverb.decayTimeAtNyquist = 11
        reverb.randomizeReflections = 600
        reverb.gain = 1
        
        filter = AKMoogLadder(reverb)
        filter.resonance = 0.6
        filter.cutoffFrequency = 300
        
        mixer.connect(filter)
        
        compressor = AKCompressor(mixer)
        compressor.headRoom = 0.10
        compressor.threshold = -15
        compressor.masterGain = 10
        compressor.attackTime = 0.01
        compressor.releaseTime = 0.3
        
        AudioKit.output = compressor
        AudioKit.start()

        
        setupTrack()
        */
    }

    func setUpMidiNode(with instrument: InstrumentRackEnum) {
        
        switch selectedInstrument.rawValue {
        case 0:
            print("DID SET 0")
            
            midiNode = AKMIDINode(node: instrumentRack.fmOscillator)
            midiNode.enableMIDI(midi.client, name: "synth midi in")
            addStandardEffects(for: midiNode)
            
            print("AudioKit.output = \(String(describing: AudioKit.output))")
//                        AudioKit.output = nil
//            AudioKit.output?.addConnectionPoint(compressor)
                        AudioKit.output = mixer
            
            print("AudioKit.output = \(String(describing: AudioKit.output))")

            AudioKit.start()
            setupTrack()

        case 1:
            print("DID SET 1")

            midiNode = AKMIDINode(node: instrumentRack.phaseDistortionOscillator)
            midiNode.enableMIDI(midi.client, name: "synth midi in")

            addStandardEffects(for: midiNode)
            
            print("AudioKit.output = \(String(describing: AudioKit.output))")
//            AudioKit.output = nil
//            AudioKit.output?.addConnectionPoint(compressor)
            AudioKit.output = mixer

            print("AudioKit.output = \(String(describing: AudioKit.output))")
            AudioKit.output = mixer
//            AudioKit.start()
            setupTrack()
        case 2:
            midiNode = AKMIDINode(node: instrumentRack.fmOscillator)
            midiNode.enableMIDI(midi.client, name: "synth midi in")
            reverb = AKReverb2(midiNode)
            print("DID SET 2")
        case 3:
            midiNode = AKMIDINode(node: instrumentRack.phaseDistortionOscillator)
            midiNode.enableMIDI(midi.client, name: "synth midi in")
            reverb = AKReverb2(midiNode)
            print("DID SET 3")
        default:
            break
        }
    }
    
    func addStandardEffects(for midiNode: AKMIDINode) {
        
        reverb = AKReverb2(midiNode)
        reverb.dryWetMix = 0.5
        reverb.decayTimeAt0Hz = 7
        reverb.decayTimeAtNyquist = 11
        reverb.randomizeReflections = 600
        reverb.gain = 1
        
        filter = AKMoogLadder(reverb)
        filter.resonance = 0.6
        filter.cutoffFrequency = 300
        
        mixer.connect(filter)
        
//        compressor = AKCompressor(mixer)
//        compressor.headRoom = 0.10
//        compressor.threshold = -15
//        compressor.masterGain = 10
//        compressor.attackTime = 0.01
//        compressor.releaseTime = 0.3
        
    }
    
    func setupTrack() {
        let sequenceLength = AKDuration(beats: 8.0)

        for number in 0...7 {
            let _ = sequence.newTrack()
            sequence.setLength(sequenceLength)
            sequence.tracks[number].setMIDIOutput(midiNode.midiIn)
        }
        
        sequence.enableLooping()
        sequence.setTempo(220)
        sequence.play()
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
        
        // sequence.tracks [for this instrument]. add(this note at this velocity, position (column/part of the measure), and duraction)
        // TODO: understand this...
        sequence.tracks[blip.column].add(noteNumber: MIDINoteNumber(note), velocity: 120, position: position, duration: duration)
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
        
        //TODO: Understand this...
        sequence.tracks[blip.column].clearNote(MIDINoteNumber(note))
    }
 }
