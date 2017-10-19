//
//  EnvelopeView.swift
//  Bliptronic
//
//  Created by Robert Deans on 10/18/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import AudioKit

class EnvelopeView: UIView {
    
    let conductor = Conductor.sharedInstance
    
    var attackKnob: KnobSmall!
    var decayKnob: KnobSmall!
    var releaseKnob: KnobSmall!
    var sustainKnob: KnobSmall!
    
    var attackLabel: UILabel!
    var decayLabel: UILabel!
    var releaseLabel: UILabel!
    var sustainLabel: UILabel!
    
    //    var knobStackView: UIStackView!
    
    
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
        
        decayLabel = UILabel()
        decayLabel.text = "DECAY"
        
        releaseLabel = UILabel()
        releaseLabel.text = "RELEASE"
        
        sustainLabel = UILabel()
        sustainLabel.text = "SUSTAIN"
        
        let labelArray = [attackLabel, releaseLabel, decayLabel, sustainLabel]
        
        for label in labelArray {
            label?.font = UIFont(name: "Futura-Medium", size: 12)
            label?.textColor = UIColor.white
            label?.textAlignment = .center
            label?.numberOfLines = 0
        }
        
        attackKnob = KnobSmall()
        decayKnob = KnobSmall()
        releaseKnob = KnobSmall()
        sustainKnob = KnobSmall()
        
        
        // This array order is CRITICAL for assigning tags
        let knobArray = [attackKnob, decayKnob, sustainKnob, releaseKnob]
        
        for (index, knob) in knobArray.enumerated() {
            knob?.tag = index
            knob?.backgroundColor = UIColor.clear
            knob?.delegate = self
        }
        
        attackKnob.minimum = 0.001
        attackKnob.maximum = 1.0
        attackKnob.value = 0.2
        
        decayKnob.minimum = 0.01
        decayKnob.maximum = 1.00
        decayKnob.value = 0.1
        
        sustainKnob.minimum = 0.0
        sustainKnob.maximum = 1.0
        sustainKnob.value = 1.0
        
        releaseKnob.minimum = 0.01
        releaseKnob.maximum = 1.0
        releaseKnob.value = 0.5
        
        
        //Knob class inherits from UIView so this should work
        //        knobStackView = UIStackView(arrangedSubviews: knobArray as! [UIView])
        //        knobStackView.alignment = .center
        //        knobStackView.distribution = .equalSpacing
        //        knobStackView.spacing = 5
        //        knobStackView.axis = .horizontal
        
    }
    
    //TODO: Add a stackview
    func constrain() {
        
        //        addSubview(knobStackView)
        //        knobStackView.snp.makeConstraints {
        //            $0.edges.equalToSuperview()
        //        }
        
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
        
        addSubview(decayKnob)
        decayKnob.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(attackKnob.snp.trailing).offset(5)
            $0.width.height.equalTo(65)
        }
        
        addSubview(decayLabel)
        decayLabel.snp.makeConstraints {
            $0.top.equalTo(decayKnob.snp.bottom)
            $0.centerX.equalTo(decayKnob.snp.centerX).offset(3)
            $0.width.equalTo(attackKnob.snp.width).multipliedBy(1.2)
        }
        
        addSubview(sustainKnob)
        sustainKnob.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(decayKnob.snp.trailing).offset(5)
            $0.width.height.equalTo(65)
        }
        
        addSubview(sustainLabel)
        sustainLabel.snp.makeConstraints {
            $0.top.equalTo(sustainKnob.snp.bottom)
            $0.centerX.equalTo(sustainKnob.snp.centerX).offset(3)
            $0.width.equalTo(attackKnob.snp.width).multipliedBy(1.2)
        }
        
        addSubview(releaseKnob)
        releaseKnob.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(sustainKnob.snp.trailing)
            $0.width.height.equalTo(65)
        }
        
        addSubview(releaseLabel)
        releaseLabel.snp.makeConstraints {
            $0.top.equalTo(releaseKnob.snp.bottom)
            $0.centerX.equalTo(releaseKnob.snp.centerX).offset(3)
            $0.width.equalTo(attackKnob.snp.width).multipliedBy(1.2)
        }
    }
    
}

extension EnvelopeView: KnobSmallDelegate {
    
    func updateKnobValue(_ value: Double, tag: Int) {
        print(value)
        switch tag {
        case 0:
            conductor.instrumentRack.fmOscillator.attackDuration = value
            conductor.instrumentRack.morphingOscillator.attackDuration = value
            conductor.instrumentRack.phaseDistortionOscillator.attackDuration = value
            conductor.instrumentRack.pwmOscillator.attackDuration = value
            
        case 1:
            conductor.instrumentRack.fmOscillator.decayDuration = value
            conductor.instrumentRack.morphingOscillator.decayDuration = value
            conductor.instrumentRack.phaseDistortionOscillator.decayDuration = value
            conductor.instrumentRack.pwmOscillator.decayDuration = value
            
        case 2:
            conductor.instrumentRack.fmOscillator.sustainLevel = value
            conductor.instrumentRack.morphingOscillator.sustainLevel = value
            conductor.instrumentRack.phaseDistortionOscillator.sustainLevel = value
            conductor.instrumentRack.pwmOscillator.sustainLevel = value
            
        case 3:
            conductor.instrumentRack.fmOscillator.releaseDuration = value
            conductor.instrumentRack.morphingOscillator.releaseDuration = value
            conductor.instrumentRack.phaseDistortionOscillator.releaseDuration = value
            conductor.instrumentRack.pwmOscillator.releaseDuration = value
            
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

