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

class KnobView: UIView {
    
    let conductor = Conductor.sharedInstance
    
    //TODO: Tempo Slider
    //      Waveform scrolling stackview
    //      Cutoff / Resonance / Attack Knobs
    
    var cutoffKnob: KnobSmall!
    var resonanceKnob: KnobSmall!
    var randomKnob1: KnobSmall!
    var randomKnob2: KnobSmall!
    
    var tempoUp: UIButton!
    var tempoDown: UIButton!
    var tempoTextView = UITextView()
    //    {
    //        didSet {
    //            if let tempo = Double(tempoTextView.text) {
    //                conductor.currentTempo = tempo
    //            }
    //        }
    //    }
    var currentTempo: Double = 220
    
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
        
        
        cutoffKnob = KnobSmall()
        resonanceKnob = KnobSmall()
        randomKnob1 = KnobSmall()
        randomKnob2 = KnobSmall()

        let knobArray = [cutoffKnob, resonanceKnob, randomKnob1, randomKnob2]
        
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
        
        tempoUp = UIButton()
        tempoUp.setImage(#imageLiteral(resourceName: "arrowUp"), for: .normal)
        tempoUp.addTarget(self, action: #selector(tempoButtonTapped(_:)), for: .touchUpInside)
        
        tempoDown = UIButton()
        tempoDown.setImage(#imageLiteral(resourceName: "arrowDown"), for: .normal)
        tempoDown.addTarget(self, action: #selector(tempoButtonTapped(_:)), for: .touchUpInside)
        
        currentTempo = conductor.currentTempo
        
        tempoTextView.text = "\(currentTempo / 2)"
        tempoTextView.font = UIFont(name: "Futura-Medium", size: 20)
        tempoTextView.textColor = UIColor.white
        tempoTextView.isEditable = false
        tempoTextView.textAlignment = .right
        tempoTextView.backgroundColor = UIColor.clear
        
        
    }
    
    func constrain() {
        addSubview(cutoffKnob)
        cutoffKnob.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.height.equalTo(65)
        }
        
        addSubview(resonanceKnob)
        resonanceKnob.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(cutoffKnob.snp.trailing)
            $0.width.height.equalTo(65)
        }
        
        addSubview(randomKnob1)
        randomKnob1.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(resonanceKnob.snp.trailing)
            $0.width.height.equalTo(65)
        }
        
        addSubview(randomKnob2)
        randomKnob2.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(randomKnob1.snp.trailing)
            $0.width.height.equalTo(65)
        }
        
        addSubview(tempoUp)
        tempoUp.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        addSubview(tempoTextView)
        tempoTextView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(6)
            $0.width.equalTo(tempoTextView.snp.height).multipliedBy(1.5)
            $0.top.equalTo(tempoUp.snp.bottom)
        }
        
        addSubview(tempoDown)
        tempoDown.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalTo(tempoTextView.snp.bottom)
        }
        
        
    }
    
    func tempoButtonTapped(_ sender: UIButton) {
        if sender.imageView?.image == #imageLiteral(resourceName: "arrowUp") {
            currentTempo += 5
            conductor.currentTempo = currentTempo
            tempoTextView.text = "\(currentTempo / 2)"
            
        } else {
            currentTempo -= 5
            conductor.currentTempo = currentTempo
            tempoTextView.text = "\(currentTempo / 2)"
            
        }
        
        
    }
    
}

extension KnobView: KnobSmallDelegate {
    
    func updateKnobValue(_ value: Double, tag: Int) {
        print("tag = \(tag)")
        print("value = \(value)")
        switch tag {
        case 0:
            let cutOffFrequency = cutoffFreqFromValue(value)
            conductor.filter.cutoffFrequency = cutOffFrequency
        case 1:
            conductor.filter.resonance = value
        default:
            break
        }
     }
    
    func cutoffFreqFromValue(_ value: Double) -> Double {
        // Logarithmic scale: knobvalue to frequency
        let scaledValue = Double.scaleRangeLog(value, rangeMin: 30, rangeMax: 7_000)
        print("scaled Value = \(scaledValue)")
        return scaledValue * 4
    }
    
    func resonanceFreqFromValue(_ value: Double) -> Double {
        let scaledValue = Double.scaleRangeLog(value, rangeMin: 30, rangeMax: 7_000)
        
        print("scaled Value = \(scaledValue)")
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

