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
    
    var mixer = AKMixer()
    var compressor: AKCompressor!
    
    init() {
        
        compressor = AKCompressor(mixer)
        compressor.headRoom = 0.10
        compressor.threshold = -15
        compressor.masterGain = 10
        compressor.attackTime = 0.01
        compressor.releaseTime = 0.3
        
        AudioKit.output = compressor
        AudioKit.start()
    }
    
    
}
