//
//  BlipView.swift
//  Bliptronic5000
//
//  Created by Robert Deans on 3/25/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import SnapKit


class BlipButton: UIButton {
    
    var blip: Blip!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(column: Int, row: Int) {
        self.init(frame: CGRect.zero)
        
        blip = Blip(column: column, row: row)
        
        if blip.isActive {
            backgroundColor = UIColor.blipActive
        } else {
            backgroundColor = UIColor.blipInactive
        }
        
        layer.cornerRadius = 5
        layer.borderWidth = 2
        layer.borderColor = UIColor.cyan.cgColor
        
    }
    
    
}
