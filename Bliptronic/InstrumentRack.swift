//
//  ShimmerOrgan.swift
//  Bliptronic
//
//  Created by Robert Deans on 10/9/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import AudioKit


protocol SelectedInstrumentDelegate {
    
    func configure(for instrument: InstrumentRackEnum)
    
}

//TODO: Move inside of InstrumentRack and make it a local enum
enum InstrumentRackEnum: Int {
    case fmOscillator = 0, morphingOscillator, phaseDistortionOscillator, pwmOscillator
    
}


final class InstrumentRack {
    
    var fmOscillator: AKFMOscillatorBank!
    var phaseDistortionOscillator: AKPhaseDistortionOscillatorBank!
    var morphingOscillator: AKMorphingOscillatorBank!
    var pwmOscillator: AKPWMOscillatorBank!
    
    var selectedInstrument: AKPolyphonicNode?
    
    init() {
        fmOscillator = AKFMOscillatorBank()
        fmOscillator.modulatingMultiplier = 3
        fmOscillator.modulationIndex = 0.3
        
        morphingOscillator = AKMorphingOscillatorBank()
        morphingOscillator.index = 3
        morphingOscillator.detuningOffset = 1.0
        morphingOscillator.detuningMultiplier = 1.0
        
        phaseDistortionOscillator = AKPhaseDistortionOscillatorBank()
        phaseDistortionOscillator.detuningOffset = 1.0
        phaseDistortionOscillator.detuningMultiplier = 1.0
        phaseDistortionOscillator.phaseDistortion = 0.5
        
        pwmOscillator = AKPWMOscillatorBank()
        pwmOscillator.pulseWidth = 0.7
        pwmOscillator.detuningOffset = 0.1
        pwmOscillator.detuningMultiplier = 1.0
        

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
