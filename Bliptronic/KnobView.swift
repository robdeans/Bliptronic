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
        cutoffKnob.maximum = 10
        cutoffKnob.value = 5
        cutoffKnob.backgroundColor = UIColor.clear
        
        resonanceKnob = KnobSmall()
        resonanceKnob.maximum = 10
        resonanceKnob.value = 5
        resonanceKnob.backgroundColor = UIColor.clear
    
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
    }
    
}

