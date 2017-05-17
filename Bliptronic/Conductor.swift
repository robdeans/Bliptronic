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
        
        generateNote(for: nil)
        sequence.enableLooping()
        sequence.setTempo(100)
        sequence.play()
        
    }
    
    func generateNote(for blip: Blip?) {
        let position = AKDuration(beats: 1)
        let duration = AKDuration(seconds: 0.4)
        
        sequence.tracks[0].add(noteNumber: 60, velocity: 100, position: position, duration: duration)
    }
}
