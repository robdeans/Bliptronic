//
//  ShimmerOrgan.swift
//  Bliptronic
//
//  Created by Robert Deans on 10/9/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import AudioKit


//TODO: Move inside of InstrumentRack and make it a local enum
enum InstrumentRackEnum: Int {
    case fmOscillator = 0, morphingOscillator, phaseDistortionOscillator, pwmOscillator
    
}

final class InstrumentRack {
    
    var fmOscillator: AKFMOscillatorBank!
    var phaseDistortionOscillator: AKPhaseDistortionOscillatorBank!
    var morphingOscillator: AKMorphingOscillatorBank!
    var pwmOscillator: AKPWMOscillatorBank!
    
    init() {
        fmOscillator = AKFMOscillatorBank()
        fmOscillator.modulatingMultiplier = 3
        fmOscillator.modulationIndex = 0.3
        
        morphingOscillator = AKMorphingOscillatorBank()
        morphingOscillator.index = 3
        morphingOscillator.attackDuration = 0.1
        morphingOscillator.releaseDuration = 0.5
        morphingOscillator.detuningOffset = 875.0
        morphingOscillator.detuningMultiplier = 2.5
        
        phaseDistortionOscillator = AKPhaseDistortionOscillatorBank()
        phaseDistortionOscillator.detuningOffset = 853
        phaseDistortionOscillator.detuningMultiplier = 1.6
        
        pwmOscillator = AKPWMOscillatorBank()

    }
    
}

/*
 
 Conforms to AKPolyphonicNode:
 
 AKMorphingOscillatorBank,
 AKOscillatorBank,
 AKPWMOscillatorBank,
 AKPhaseDistortionOscillatorBank,
 AKMIDIInstrument:
 AKSynthKick,
 AKSynthSnare
 
 */
