//
//  BlipView.swift
//  Bliptronic5000
//
//  Created by Robert Deans on 3/25/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class BlipView: UIButton {
    
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
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(isTapped))
        
        self.addGestureRecognizer(gesture)
        
        if blip.isActive {
            backgroundColor = UIColor.blipActive
        } else {
            backgroundColor = UIColor.blipInactive
        }
    }
    
    
}

extension BlipView {
    
    func isTapped() {
        blip.isActive = !blip.isActive
        
        if blip.isActive {
            backgroundColor = UIColor.blipActive
            blip.noteOn()
        } else {
            backgroundColor = UIColor.blipInactive
            blip.noteOff()
        }
        
    }
    
}
