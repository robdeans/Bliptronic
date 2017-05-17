//
//  Conductor.swift
//  Bliptronic
//
//  Created by Robert Deans on 5/16/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import AudioKit

class Conductor {
    
    let midi = AKMIDI()
    
    var mixer = AKMixer()
    var compressor: AKCompressor!
    
    var bassDrum = AKSynthKick()

    
    var sequencer = AKSequencer()
    var duration = AKDuration(beats: 8.0)
    
    var currentTempo = 110.0 {
        didSet {
            sequencer.setTempo(currentTempo)
        }
    }
    
    init() {
        bassDrum.enableMIDI(midi.client, name: "bassDrum midi in")

        compressor = AKCompressor(mixer)
        compressor.headRoom = 0.10
        compressor.threshold = -15
        compressor.masterGain = 10
        compressor.attackTime = 0.01
        compressor.releaseTime = 0.3
        
        mixer.connect(bassDrum)

        
//        AudioKit.output = compressor
//        AudioKit.start()
        
        setupTracks()
    }
    
    func setupTracks() {
        let _ = sequencer.newTrack()
        sequencer.setLength(duration)
        sequencer.tracks[Sequence.bassDrum.rawValue].setMIDIOutput(bassDrum.midiIn)
        generateBassDrumSequence()
        
        sequencer.enableLooping()
        sequencer.setTempo(110)
    }
    
    func generateBassDrumSequence(_ stepSize: Float = 1, clear: Bool = true) {
        if clear { sequencer.tracks[Sequence.bassDrum.rawValue].clear() }
        
        let numberOfSteps = Int(Float(duration.beats) / stepSize)
        
        for i in 0 ..< numberOfSteps {
            let step = Double(i) * stepSize

            sequencer.tracks[Sequence.bassDrum.rawValue].add(noteNumber: 60, velocity: 100, position: AKDuration(beats: step), duration: AKDuration(beats: 1))
        }
    }
    
}
