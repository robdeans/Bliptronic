 //
//  Conductor.swift
//  Bliptronic
//
//  Created by Robert Deans on 5/17/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import AudioKit

class Conductor {
    
    static let sharedInstance = Conductor()
    
    let midi = AKMIDI()
    
    var synthesizer = AKOscillatorBank()
    var midiNode: AKMIDINode!
    
    var filter: AKMoogLadder!
    
    var mixer = AKMixer()
    var compressor: AKCompressor!
    
    var sequence = AKSequencer()
    let sequenceLength = AKDuration(beats: 8.0)
    
    var currentTempo = 110.0 {
        didSet {
            sequence.setTempo(currentTempo)
        }
    }
    
    init() {
        midiNode = AKMIDINode(node: synthesizer)
        midiNode.enableMIDI(midi.client, name: "synth midi in")
        
        filter = AKMoogLadder(midiNode)
        
        mixer.connect(synthesizer)
        
        compressor = AKCompressor(mixer)
        compressor.headRoom = 0.10
        compressor.threshold = -15
        compressor.masterGain = 10
        compressor.attackTime = 0.01
        compressor.releaseTime = 0.3
        
        setupTrack()
        
        AudioKit.output = compressor
    }
    
    func setupTrack() {
        for number in 0...7 {
            let _ = sequence.newTrack()
            sequence.setLength(sequenceLength)
            sequence.tracks[number].setMIDIOutput(midiNode.midiIn)
        }
        
        sequence.enableLooping()
        sequence.setTempo(110)
        sequence.play()
    }
    
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
        // TODO: Adjust this for multiple instruments/tracks
        sequence.tracks[0].add(noteNumber: MIDINoteNumber(note), velocity: 120, position: position, duration: duration)
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
        
        sequence.tracks[blip.column].clearNote(MIDINoteNumber(note))
    }
}
