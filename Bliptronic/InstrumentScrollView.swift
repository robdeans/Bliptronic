//
//  InstrumentscrollView.swift
//  Bliptronic
//
//  Created by Robert Deans on 5/23/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit
import AudioKit

final class Synthesizer: AKPolyphonicNode {
    
}

class InstrumentScrollView: UIView {
    
    let conductor = Conductor.sharedInstance
    
    var scrollView: UIScrollView!
    var buttonStackView: UIStackView!
    
    var instrument1 = UIButton()
    var instrument2 = UIButton()
    var instrument3 = UIButton()
    var instrument4 = UIButton()

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        constrain()
    }
    
    func configure() {
        scrollView = UIScrollView()
//        scrollView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        scrollView.layer.cornerRadius = 5

        
        let buttonArray = [instrument1, instrument2, instrument3, instrument4]
        
        instrument1.setTitle("FM Oscillator", for: .normal)
        instrument2.setTitle("Morphing Oscillator", for: .normal)
        instrument3.setTitle("Phase Distortion Oscillator", for: .normal)
        instrument4.setTitle("PWM Oscillator", for: .normal)

        for (index, button) in buttonArray.enumerated() {
            // TODO: Temporary
            button.tag = index
            
            button.titleLabel?.font = UIFont(name: "Futura-Medium", size: 25)
            button.titleLabel?.shadowOffset = CGSize(width: 20, height: 20)
            
            button.titleLabel?.shadowColor = UIColor.black
            button.backgroundColor = UIColor.white.withAlphaComponent(0.3)
            button.layer.cornerRadius = 20
            button.addTarget(self, action: #selector(selectInstrument(_:)), for: .touchUpInside)
        }
        
        buttonStackView = UIStackView(arrangedSubviews: buttonArray)
        buttonStackView.alignment = .center
        buttonStackView.distribution = .equalSpacing
        buttonStackView.spacing = 10
        buttonStackView.axis = .horizontal

        
    }
    
    func constrain() {
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(3)
            $0.trailing.equalToSuperview().offset(-3)
            
        }
    }
    
    func selectInstrument(_ sender: UIButton) {
        //TODO: make this safer, aka make sure stackViewSubviews == InstrumentRackEnum cases
        conductor.selectedInstrument = InstrumentRackEnum(rawValue: sender.tag)!
    }
    
}


