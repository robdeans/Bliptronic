//
//  ShimmerOrgan.swift
//  Bliptronic
//
//  Created by Robert Deans on 10/9/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import AudioKit

enum InstrumentRackEnum: Int {
    case fmOscillator = 0, morphingOscillator, pwmOscillator, phaseDistortionOscillator
    
    //    var selectedInstrument: Int {
    //        get {
    //            switch self {
    //                case .fmOscillator
    //            }
    //        }
    //    }
}

final class InstrumentRack {
    
    var fmOscillator: AKFMOscillatorBank!
    var phaseDistortionOscillator: AKPhaseDistortionOscillatorBank!
    //    var morphingOscillator: AKMorphingOscillator!
    //    var pwmOscillator: AKPWMOscillatorBank!
    
    init() {
        fmOscillator = AKFMOscillatorBank()
        fmOscillator.modulatingMultiplier = 3
        fmOscillator.modulationIndex = 0.3
        /*
         morphingOscillator = AKMorphingOscillator(waveformArray: [AKTable(.sine), AKTable(.triangle), AKTable(.sawtooth), AKTable(.square)])
         morphingOscillator.frequency = 400
         morphingOscillator.amplitude = 0.1
         morphingOscillator.index = 0.8
         */
        
        phaseDistortionOscillator = AKPhaseDistortionOscillatorBank()
        phaseDistortionOscillator.phaseDistortion = 0.0
        
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
