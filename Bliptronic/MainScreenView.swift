//
//  BlipPadView.swift
//  Bliptronic5000
//
//  Created by Robert Deans on 12/23/16.
//  Copyright © 2016 Robert Deans. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MainScreenView: UIView {
    
    var instrumentScrollView: InstrumentScrollView!
    var synthView: SynthView!
    var globalView: GlobalView!
    var effectsKnobView: EffectsKnobView!
    var synthKnobView: SynthKnobView!
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        configure()
        constrain()
    }

    func configure() {
        synthView = SynthView()
        instrumentScrollView = InstrumentScrollView()
        globalView = GlobalView()
        effectsKnobView = EffectsKnobView()
        synthKnobView = SynthKnobView()
    }
    
    func constrain() {
        addSubview(instrumentScrollView)
        instrumentScrollView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIApplication.shared.statusBarFrame.height)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(14)
        }
        
        addSubview(synthView)
        synthView.snp.makeConstraints {
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(synthView.snp.width)
            $0.top.equalTo(instrumentScrollView.snp.bottom)
        }
        
        addSubview(globalView)
        globalView.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
            $0.top.equalTo(synthView.snp.bottom)
//            $0.width.equalTo(globalView.tempoUp.snp.width)
            $0.width.equalToSuperview().dividedBy(6)
        }
        
        addSubview(effectsKnobView)
        effectsKnobView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(synthView.snp.bottom)
            $0.trailing.equalTo(globalView.snp.leading)
            $0.height.equalTo(globalView.snp.height).dividedBy(2)
        }
        
        addSubview(synthKnobView)
        synthKnobView.snp.makeConstraints {
            $0.top.equalTo(effectsKnobView.snp.bottom)
            $0.leading.bottom.equalToSuperview()
            $0.trailing.equalTo(globalView.snp.leading)
            $0.height.equalTo(globalView.snp.height).dividedBy(2)
        }
        
    }
    
}
