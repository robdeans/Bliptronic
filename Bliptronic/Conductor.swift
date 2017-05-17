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
    
    let midi = AKMIDI()
    
    var synthesizer = AKOscillatorBank()
    var midiNode: AKMIDINode!
    
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
        let _ = sequence.newTrack()
        sequence.setLength(sequenceLength)
        
        sequence.tracks[0].setMIDIOutput(midiNode.midiIn)
        
        
        sequence.enableLooping()
        sequence.setTempo(110)
        sequence.play()
        
    }
    
    func generateNote(for blip: Blip) {
        let position = AKDuration(beats: Double(blip.column))
        let duration = AKDuration(seconds: 0.4)
        let note = blip.row + 60
        sequence.tracks[0].add(noteNumber: MIDINoteNumber(note), velocity: 120, position: position, duration: duration)
    }
    
    func removeNote(for blip: Blip) {
        let position = AKDuration(beats: Double(blip.column))

        let note = blip.row + 60
        sequence.tracks[0].clearNote(MIDINoteNumber(note))
    }
}
