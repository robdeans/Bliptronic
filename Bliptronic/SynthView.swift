//
//  SynthView.swift
//  Bliptronic5000
//
//  Created by Robert Deans on 3/25/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import AudioKit

class SynthView: UIView {

    let conductor = Conductor.sharedInstance
    
    var columnStackView1 = UIStackView()
    var columnStackView2 = UIStackView()
    var columnStackView3 = UIStackView()
    var columnStackView4 = UIStackView()
    var columnStackView5 = UIStackView()
    var columnStackView6 = UIStackView()
    var columnStackView7 = UIStackView()
    var columnStackView8 = UIStackView()
    var horizontalStackView = UIStackView()
    
    let blipSpacing: CGFloat = 5
    
    
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
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.spacing = blipSpacing
        
        
        let stackviewArray = [columnStackView1, columnStackView2, columnStackView3, columnStackView4, columnStackView5, columnStackView6, columnStackView7, columnStackView8]
        
        for (column, columnStackView) in stackviewArray.enumerated() {
            columnStackView.axis = .vertical
            columnStackView.distribution = .fillEqually
            columnStackView.spacing = blipSpacing
            
            
            var rowCounter = 8
            for _ in 0...7 {
                
                let blipButton = BlipButton(column: column, row: rowCounter)
                
                blipButton.addTarget(self, action: #selector(isTapped), for: .touchUpInside)
                
                columnStackView.addArrangedSubview(blipButton)
                
                rowCounter -= 1
            }
            
            horizontalStackView.addArrangedSubview(columnStackView)
            columnStackView.snp.makeConstraints {
                $0.height.equalToSuperview()
            }
        }
        
    }
    
    func constrain() {
        
        addSubview(horizontalStackView)
        horizontalStackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalToSuperview().offset(blipSpacing * -2)
            $0.height.equalToSuperview().offset(blipSpacing * -2)
        }
        
    }
    
}

extension SynthView {
    
    func isTapped(_ sender: UIButton) {
        if let sender = sender as? BlipButton {
            sender.blip.isActive = !sender.blip.isActive
            
            if sender.blip.isActive {
                sender.backgroundColor = UIColor.blipActive
                sender.blip.noteOn()
                
                conductor.generateNote(for: sender.blip)
                
            } else {
                sender.backgroundColor = UIColor.blipInactive
                sender.blip.noteOff()
                conductor.removeNote(for: sender.blip)
            }
        }
        
    }
    
}
