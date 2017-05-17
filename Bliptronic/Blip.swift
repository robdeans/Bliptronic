//
//  Blip.swift
//  Bliptronic5000
//
//  Created by Robert Deans on 3/25/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import AudioKit

struct Blip {
    
    var isActive: Bool
    var column: Int
    var row: Int
    
    let sawtooth = AKTable(.sawtooth, count: 4096)
    let square = AKTable(.square, count: 16)
    
    var oscillator: AKOscillator!
    
    var currentMIDINote = 0
    var currentAmplitude = 0.2
    var currentRampTime = 0.05
    
    init(column: Int, row: Int) {
        isActive = false
        self.row = row
        self.column = column
        
        if row == 1 && column == 1 {
            oscillator = AKOscillator()
//            AudioKit.output = oscillator
//            AudioKit.start()
        }
    }
    
    
    
    
    mutating func makeOscillator() {
        
        
        oscillator = AKOscillator(waveform: sawtooth)
        
        AudioKit.output = oscillator
        AudioKit.start()
        
        
        oscillator.rampTime = currentRampTime
        oscillator.amplitude = currentAmplitude
        
    }
    
    func noteOn() {
        oscillator.rampTime = currentRampTime
        oscillator.amplitude = currentAmplitude
        oscillator.play()
    }
    
    func noteOff() {
        oscillator.amplitude = 0
        oscillator.stop()
    }
    
}

