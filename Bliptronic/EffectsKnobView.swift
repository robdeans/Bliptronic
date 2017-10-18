//
//  SynthKnobsView.swift
//  Bliptronic
//
//  Created by Robert Deans on 5/17/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import AudioKit

class EffectsKnobView: UIView {
    
    let conductor = Conductor.sharedInstance
    
    //TODO: Tempo Slider
    //      Waveform scrolling stackview
    //      Cutoff / Resonance / Attack Knobs
    
    var cutoffKnob: KnobSmall!
    var resonanceKnob: KnobSmall!
    var reverbDryWet: KnobSmall!
    var reverbDelay: KnobSmall!
    
    var cutoffLabel: UILabel!
    var resonanceLabel: UILabel!
    var reverbDryWetLabel: UILabel!
    var reverbDelayLabel: UILabel!
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        constrain()
    }
    
    func configure() {
        
        cutoffLabel = UILabel()
        cutoffLabel.text = "CUTOFF"
        
        resonanceLabel = UILabel()
        resonanceLabel.text = "RESONANCE"
        
        reverbDryWetLabel = UILabel()
        reverbDryWetLabel.text = "DRY/WET"
        
        reverbDelayLabel = UILabel()
        reverbDelayLabel.text = "DECAY TIME"
        
        let labelArray = [cutoffLabel, resonanceLabel, reverbDryWetLabel, reverbDelayLabel]

        for label in labelArray {
                label?.font = UIFont(name: "Futura-Medium", size: 12)
            label?.textColor = UIColor.white
            label?.textAlignment = .center
            label?.numberOfLines = 0
//            label?.lineBreakMode = .byWordWrapping
            
        }
        
        cutoffKnob = KnobSmall()
        resonanceKnob = KnobSmall()
        reverbDryWet = KnobSmall()
        reverbDelay = KnobSmall()

        let knobArray = [cutoffKnob, resonanceKnob, reverbDryWet, reverbDelay]
        
        for (index, knob) in knobArray.enumerated() {
            knob?.tag = index
            knob?.backgroundColor = UIColor.clear
            knob?.delegate = self
        }

        // If knob is a logarithmic measurement, use 0-1.0 range and calculate
        cutoffKnob.maximum = 1.0
        cutoffKnob.minimum = 0
        cutoffKnob.value = 0.5
        
        // If linear use measurement's min and max values
        resonanceKnob.minimum = 0.01
        resonanceKnob.maximum = 1.99
        resonanceKnob.value = 1.0
        
        reverbDryWet.minimum = 0.0
        reverbDryWet.maximum = 1.0
        reverbDryWet.value = 0.5
        
        reverbDelay.minimum = 0.0001
        reverbDelay.maximum = 1.0
        reverbDelay.value = 0.5
        
        
    }
    
    func constrain() {
        addSubview(cutoffKnob)
        cutoffKnob.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(5)
            $0.width.height.equalTo(65)
        }
        
        addSubview(cutoffLabel)
        cutoffLabel.snp.makeConstraints {
            $0.top.equalTo(cutoffKnob.snp.bottom)
            $0.centerX.equalTo(cutoffKnob.snp.centerX).offset(3)
            $0.width.equalTo(cutoffKnob.snp.width).multipliedBy(1.2)
        }
        
        addSubview(resonanceKnob)
        resonanceKnob.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(cutoffKnob.snp.trailing).offset(5)
            $0.width.height.equalTo(65)
        }
        
        addSubview(resonanceLabel)
        resonanceLabel.snp.makeConstraints {
            $0.top.equalTo(resonanceKnob.snp.bottom)
            $0.centerX.equalTo(resonanceKnob.snp.centerX).offset(3)
            $0.width.equalTo(cutoffKnob.snp.width).multipliedBy(1.2)
        }
        
        addSubview(reverbDryWet)
        reverbDryWet.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(resonanceKnob.snp.trailing).offset(5)
            $0.width.height.equalTo(65)
        }
        
        addSubview(reverbDryWetLabel)
        reverbDryWetLabel.snp.makeConstraints {
            $0.top.equalTo(reverbDryWet.snp.bottom)
            $0.centerX.equalTo(reverbDryWet.snp.centerX).offset(3)
            $0.width.equalTo(cutoffKnob.snp.width).multipliedBy(1.2)
        }
        
        addSubview(reverbDelay)
        reverbDelay.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(reverbDryWet.snp.trailing).offset(5)
            $0.width.height.equalTo(65)
        }
        
        addSubview(reverbDelayLabel)
        reverbDelayLabel.snp.makeConstraints {
            $0.top.equalTo(reverbDelay.snp.bottom)
            $0.centerX.equalTo(reverbDelay.snp.centerX).offset(3)
            $0.width.equalTo(cutoffKnob.snp.width).multipliedBy(1.2)
        }
        
    }
    
}

extension EffectsKnobView: KnobSmallDelegate {
    
    func updateKnobValue(_ value: Double, tag: Int) {

        switch tag {
        case 0:
            conductor.filter.cutoffFrequency = logarithmicFreqForValue(value)
        case 1:
            conductor.filter.resonance = value
        case 2:
            conductor.reverb.dryWetMix = value
        case 3:
            conductor.reverb.maxDelayTime = value
        default:
            break
        }
     }
    
    func logarithmicFreqForValue(_ value: Double) -> Double {
        // Logarithmic scale: knobvalue to frequency
        let scaledValue = Double.scaleRangeLog(value, rangeMin: 30, rangeMax: 7_000)
        return scaledValue * 4
    }
    
    
}

extension Double {
    
    // Logarithmically scale 0.0 to 1.0 to any range
    public static func scaleRangeLog(_ value: Double, rangeMin: Double, rangeMax: Double) -> Double {
        let scale = (log(rangeMax) - log(rangeMin))
        return exp(log(rangeMin) + (scale * value))
    }
}

