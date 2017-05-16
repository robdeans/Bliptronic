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
    
    var synthView: SynthView!
    
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
        backgroundColor = UIColor.cyan
    }
    
    func constrain() {
        addSubview(synthView)
        synthView.snp.makeConstraints {
            $0.width.centerX.centerY.equalToSuperview()
            $0.height.equalTo(synthView.snp.width)
        }
    }
    
}
