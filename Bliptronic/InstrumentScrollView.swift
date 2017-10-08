//
//  InstrumentscrollView.swift
//  Bliptronic
//
//  Created by Robert Deans on 5/23/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit

class InstrumentScrollView: UIView {
        
    var scrollView: UIScrollView!
    var buttonStackView: UIStackView!
    
    var instrument1 = UIButton()
    var instrument2 = UIButton()
    var instrument3 = UIButton()
    var instrument4 = UIButton()
    var instrument5 = UIButton()

    
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

        
        let buttonArray = [instrument1, instrument2, instrument3, instrument4, instrument5]
        
        instrument1.setTitle("Shimmer Organ", for: .normal)
        instrument2.setTitle("Drum Rack", for: .normal)
        instrument3.setTitle("Sawtooth Bass", for: .normal)
        instrument4.setTitle("Weird Sound", for: .normal)
        instrument5.setTitle("Oscillator", for: .normal)

        for button in buttonArray {
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
        print("\(sender.titleLabel?.text ?? "nothing") selected")
    }
    
}
