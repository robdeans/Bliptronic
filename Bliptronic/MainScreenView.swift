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
    var knobView: KnobView!
    
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
        knobView = KnobView()
        instrumentScrollView = InstrumentScrollView()
    }
    
    func constrain() {
        addSubview(instrumentScrollView)
        instrumentScrollView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIApplication.shared.statusBarFrame.height)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.95)
            $0.height.equalToSuperview().dividedBy(14)
        }
        
        addSubview(synthView)
        synthView.snp.makeConstraints {
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(synthView.snp.width)
            $0.top.equalTo(instrumentScrollView.snp.bottom)
        }
        
        addSubview(knobView)
        knobView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(synthView.snp.bottom)
        }
        
    }
    
}
