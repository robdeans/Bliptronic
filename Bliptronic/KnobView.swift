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
        cutoffKnob.maximum = 1.0
        cutoffKnob.minimum = 0
        cutoffKnob.value = 0.5
        cutoffKnob.delegate = self
        cutoffKnob.backgroundColor = UIColor.clear
        
        resonanceKnob = KnobSmall()
        resonanceKnob.maximum = 10
        resonanceKnob.value = 5
        resonanceKnob.backgroundColor = UIColor.clear
        
        randomKnob1 = KnobSmall()
        randomKnob1.maximum = 10
        randomKnob1.value = 5
        randomKnob1.backgroundColor = UIColor.clear
        
        randomKnob2 = KnobSmall()
        randomKnob2.maximum = 10
        randomKnob2.value = 5
        randomKnob2.backgroundColor = UIColor.clear

        
        tempoUp = UIButton()
        tempoUp.setTitle("🔼", for: .normal)
        tempoUp.addTarget(self, action: #selector(tempoButtonTapped(_:)), for: .touchUpInside)
        
        tempoDown = UIButton()
        tempoDown.setTitle("🔽", for: .normal)
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
            $0.top.trailing.equalToSuperview()
        }
        
        addSubview(tempoTextView)
        tempoTextView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(5)
            $0.width.equalTo(tempoTextView.snp.height).multipliedBy(2)
            $0.top.equalTo(tempoUp.snp.bottom)
        }
        
        addSubview(tempoDown)
        tempoDown.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalTo(tempoTextView.snp.bottom)
        }
        
        
    }
    
    func tempoButtonTapped(_ sender: UIButton) {
        if sender.titleLabel?.text == "🔼" {
            currentTempo += 5
            conductor.currentTempo = currentTempo
            tempoTextView.text = "\(currentTempo / 2)"
            
        } else {
            currentTempo -= 5
            conductor.currentTempo = currentTempo
            tempoTextView.text = "\(currentTempo / 2)"
            
        }
        
        
    }
    
    func updateTempo(value: Double) {
        conductor.currentTempo = value
    }
    
}

extension KnobView: KnobSmallDelegate {
    
    func updateKnobValue(_ value: Double, tag: Int) {
        let cutOffFrequency = cutoffFreqFromValue(value)
        conductor.filter.cutoffFrequency = cutOffFrequency
        print("conductor filter = \(conductor.filter.cutoffFrequency)")
    }
    
    func cutoffFreqFromValue(_ value: Double) -> Double {
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

