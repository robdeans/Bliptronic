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

    
    var sequence = AKSequencer()
    let sequenceLength = AKDuration(beats: 8.0)
    
    var currentTempo = 110.0 {
        didSet {
            sequence.setTempo(currentTempo)
        }
    }
    
    init() {
        
        compressor = AKCompressor(mixer)
        
        AudioKit.output = compressor
        AudioKit.start()
        
    }
    
    func setupTracks() {
        let _ = sequence.newTrack()
        sequence.tracks[Sequence.bassDrum.rawValue].setMIDIOutput(bassDrum.midiIn)
        generateBassDrumSequence()
    }
    
    func generateBassDrumSequence(_ stepSize: Float = 1, clear: Bool = true) {
        if clear { sequence.tracks[Sequence.bassDrum.rawValue].clear() }
        let numberOfSteps = Int(Float(sequenceLength.beats) / stepSize)
        for i in 0 ..< numberOfSteps {
            let step = Double(i) * stepSize
            
            sequence.tracks[Sequence.bassDrum.rawValue].add(noteNumber: 60,
                                                            velocity: 100,
                                                            position: AKDuration(beats: step),
                                                            duration: AKDuration(beats: 1))
        }
    }
    
}
