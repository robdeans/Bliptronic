//
//  SynthKnobView.swift
//  Bliptronic
//
//  Created by Robert Deans on 10/18/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import AudioKit

class SynthKnobView: UIView {
    
    let conductor = Conductor.sharedInstance
    
    //TODO: Tempo Slider
    //      Waveform scrolling stackview
    //      Cutoff / Resonance / Attack Knobs
    
    var attackKnob: KnobSmall!
    var releaseKnob: KnobSmall!
    var indexKnob: KnobSmall!
    var multiplierKnob: KnobSmall!
    var carrierKnob: KnobSmall!
    
    var attackLabel: UILabel!
    var releaseLabel: UILabel!
    var indexLabel: UILabel!
    var multiplierLabel: UILabel!
    var carrierLabel: UILabel!

    
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
        
        attackLabel = UILabel()
        attackLabel.text = "ATTACK"
        
        releaseLabel = UILabel()
        releaseLabel.text = "RELEASE"
        
        indexLabel = UILabel()
        indexLabel.text = "INDEX"
        
        multiplierLabel = UILabel()
        multiplierLabel.text = "MULTIPLIER"
        
        carrierLabel = UILabel()
        carrierLabel.text = "CARRIER"
        
        let labelArray = [attackLabel, releaseLabel, indexLabel, multiplierLabel]
        
        for label in labelArray {
            label?.font = UIFont(name: "Futura-Medium", size: 12)
            label?.textColor = UIColor.white
            label?.textAlignment = .center
            label?.numberOfLines = 0
            //            label?.lineBreakMode = .byWordWrapping
            
        }
        
        attackKnob = KnobSmall()
        releaseKnob = KnobSmall()
        indexKnob = KnobSmall()
        multiplierKnob = KnobSmall()
        
        let knobArray = [attackKnob, releaseKnob, indexKnob, multiplierKnob]
        
        for (index, knob) in knobArray.enumerated() {
            knob?.tag = index
            knob?.backgroundColor = UIColor.clear
            knob?.delegate = self
        }
        
        // If knob is a logarithmic measurement, use 0-1.0 range and calculate
        attackKnob.maximum = 1.0
        attackKnob.minimum = 0
        attackKnob.value = 0.5
        
        // If linear use measurement's min and max values
        releaseKnob.minimum = 0.01
        releaseKnob.maximum = 1.99
        releaseKnob.value = 1.0
        
        indexKnob.minimum = 0.0
        indexKnob.maximum = 1.0
        indexKnob.value = 0.5
        
        multiplierKnob.minimum = 0.0001
        multiplierKnob.maximum = 1.0
        multiplierKnob.value = 0.5
        
        
    }
    
    func constrain() {
        addSubview(attackKnob)
        attackKnob.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(5)
            $0.width.height.equalTo(65)
        }
        
        addSubview(attackLabel)
        attackLabel.snp.makeConstraints {
            $0.top.equalTo(attackKnob.snp.bottom)
            $0.centerX.equalTo(attackKnob.snp.centerX).offset(3)
            $0.width.equalTo(attackKnob.snp.width).multipliedBy(1.2)
        }
        
        addSubview(releaseKnob)
        releaseKnob.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(attackKnob.snp.trailing).offset(5)
            $0.width.height.equalTo(65)
        }
        
        addSubview(releaseLabel)
        releaseLabel.snp.makeConstraints {
            $0.top.equalTo(releaseKnob.snp.bottom)
            $0.centerX.equalTo(releaseKnob.snp.centerX).offset(3)
            $0.width.equalTo(attackKnob.snp.width).multipliedBy(1.2)
        }
        
        addSubview(indexKnob)
        indexKnob.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(releaseKnob.snp.trailing).offset(5)
            $0.width.height.equalTo(65)
        }
        
        addSubview(indexLabel)
        indexLabel.snp.makeConstraints {
            $0.top.equalTo(indexKnob.snp.bottom)
            $0.centerX.equalTo(indexKnob.snp.centerX).offset(3)
            $0.width.equalTo(attackKnob.snp.width).multipliedBy(1.2)
        }
        
        addSubview(multiplierKnob)
        multiplierKnob.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(indexKnob.snp.trailing).offset(5)
            $0.width.height.equalTo(65)
        }
        
        addSubview(multiplierLabel)
        multiplierLabel.snp.makeConstraints {
            $0.top.equalTo(multiplierKnob.snp.bottom)
            $0.centerX.equalTo(multiplierKnob.snp.centerX).offset(3)
            $0.width.equalTo(attackKnob.snp.width).multipliedBy(1.2)
        }
    }
    
}

extension SynthKnobView: KnobSmallDelegate {
    
    func updateKnobValue(_ value: Double, tag: Int) {
        
        switch tag {
        case 0:
            print("")
        case 1:
            conductor.filter.resonance = value
        case 2:
            conductor.reverb.dryWetMix = value
        case 3:
            conductor.reverb.maxDelayTime = value
        case 4:
            print("")
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

