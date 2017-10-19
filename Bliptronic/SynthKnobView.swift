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

protocol SelectedInstrumentDelegate {
    
    func configure(for instrument: InstrumentRackEnum)
    
}

class SynthKnobView: UIView {
    
    let conductor = Conductor.sharedInstance
    
    //TODO: Tempo Slider
    //      Waveform scrolling stackview
    //      Cutoff / Resonance / Attack Knobs
    
    var attackKnob: KnobSmall!
    var releaseKnob: KnobSmall!
    var indexKnob: KnobSmall!
    var multiplierKnob: KnobSmall!
    var xFactorKnob: KnobSmall!
    
    var attackLabel: UILabel!
    var releaseLabel: UILabel!
    var indexLabel: UILabel!
    var multiplierLabel: UILabel!
    var xFactorLabel: UILabel!
    
    var knobStackView: UIStackView!
    
    
    
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
        
        xFactorLabel = UILabel()
        xFactorLabel.text = "????"
        
        let labelArray = [attackLabel, releaseLabel, indexLabel, multiplierLabel, xFactorLabel]
        
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
        xFactorKnob = KnobSmall()
        
        let knobArray = [attackKnob, releaseKnob, xFactorKnob]
        
        for (index, knob) in knobArray.enumerated() {
            knob?.tag = index
            knob?.backgroundColor = UIColor.clear
            knob?.delegate = self
        }
        
        // If knob is a logarithmic measurement, use 0-1.0 range and calculate
        // If linear use measurement's min and max values
        
        attackKnob.minimum = 0.001
        attackKnob.maximum = 2.0
        attackKnob.value = 0.1
        
        releaseKnob.minimum = 0.01
        releaseKnob.maximum = 2.00
        releaseKnob.value = 0.1
        
        xFactorKnob.minimum = 0.0
        xFactorKnob.maximum = 2.0
        xFactorKnob.value = 1.0
        
        /*
         indexKnob.minimum = 0.0
         indexKnob.maximum = 1.0
         indexKnob.value = 0.5
         
         multiplierKnob.minimum = 0.0001
         multiplierKnob.maximum = 1.0
         multiplierKnob.value = 0.5
         */
        
        //Knob class inherits from UIView so this should work
        knobStackView = UIStackView(arrangedSubviews: knobArray as! [UIView])
        knobStackView.alignment = .center
        knobStackView.distribution = .equalSpacing
        knobStackView.spacing = 5
        knobStackView.axis = .horizontal
        
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
        
        addSubview(xFactorKnob)
        xFactorKnob.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(releaseKnob.snp.trailing).offset(5)
            $0.width.height.equalTo(65)
        }
        
        addSubview(xFactorLabel)
        xFactorLabel.snp.makeConstraints {
            $0.top.equalTo(xFactorKnob.snp.bottom)
            $0.centerX.equalTo(xFactorKnob.snp.centerX).offset(3)
            $0.width.equalTo(attackKnob.snp.width).multipliedBy(1.2)
        }
         /*
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
         */
    }
    
}

extension SynthKnobView: SelectedInstrumentDelegate {
    
    func configure(for instrument: InstrumentRackEnum) {
        
        switch instrument.rawValue {
        case 0:
            xFactorKnob.minimum = 0.0
            xFactorKnob.maximum = 2.0
            xFactorLabel.text = "CARRIER"
        case 1:
            xFactorKnob.minimum = 0.0
            xFactorKnob.maximum = 3.0
            xFactorLabel.text = "INDEX"
        case 2:
            xFactorKnob.minimum = 0.0
            xFactorKnob.maximum = 1.0
            xFactorLabel.text = "PHASE"
        case 3:
            xFactorKnob.minimum = 0.0
            xFactorKnob.maximum = 1.0
            xFactorLabel.text = "PULSE"
        default:
            break
        }
        
    }
    
}

extension SynthKnobView: KnobSmallDelegate {
    
    func updateKnobValue(_ value: Double, tag: Int) {
        
        //TODO: This is ridiculous
        switch conductor.selectedInstrument.rawValue {
        case 0:
            switch tag {
            case 0:
                conductor.instrumentRack.fmOscillator.attackDuration = value
            case 1:
                conductor.instrumentRack.fmOscillator.releaseDuration = value
            case 2:
                conductor.instrumentRack.fmOscillator.carrierMultiplier = value
            case 3:
                print("multiplier")
            case 4:
                print("index")
            default:
                break
            }
            
        case 1:
            switch tag {
            case 0:
                conductor.instrumentRack.morphingOscillator.attackDuration = value
            case 1:
                conductor.instrumentRack.morphingOscillator.releaseDuration = value
            case 2:
                conductor.instrumentRack.morphingOscillator.index = value
            case 3:
                print("multiplier")
            case 4:
                print("index")
            default:
                break
            }
            
        case 2:
            switch tag {
            case 0:
                conductor.instrumentRack.phaseDistortionOscillator.attackDuration = value
            case 1:
                conductor.instrumentRack.phaseDistortionOscillator.releaseDuration = value
            case 2:
                conductor.instrumentRack.phaseDistortionOscillator.phaseDistortion = value
            case 3:
                print("multiplier")
            case 4:
                print("index")
            default:
                break
            }
            
        case 3:
        
            switch tag {
            case 0:
                conductor.instrumentRack.pwmOscillator.attackDuration = value
            case 1:
                conductor.instrumentRack.pwmOscillator.releaseDuration = value
            case 2:
                conductor.instrumentRack.pwmOscillator.pulseWidth = value
            case 3:
                print("multiplier")
            case 4:
                print("index")
            default:
                break
            }
            
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

