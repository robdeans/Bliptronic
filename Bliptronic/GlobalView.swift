//
//  GlobalView.swift
//  Bliptronic
//
//  Created by Robert Deans on 10/18/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import AudioKit

class GlobalView: UIView {
    
    let conductor = Conductor.sharedInstance
    
    var tempoUp: UIButton!
    var tempoDown: UIButton!
    var tempoTextView = UITextView()
    var currentTempo: Double = 220
    
    var playButton: UIButton!
    
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
        
        tempoUp = UIButton()
        tempoUp.setImage(#imageLiteral(resourceName: "arrowUp"), for: .normal)
        tempoUp.addTarget(self, action: #selector(tempoButtonTapped(_:)), for: .touchUpInside)
        
        tempoDown = UIButton()
        tempoDown.setImage(#imageLiteral(resourceName: "arrowDown"), for: .normal)
        tempoDown.addTarget(self, action: #selector(tempoButtonTapped(_:)), for: .touchUpInside)
        
        currentTempo = conductor.currentTempo
        
        tempoTextView.text = "\(currentTempo / 2)"
        tempoTextView.font = UIFont(name: "Futura-Medium", size: 20)
        tempoTextView.textColor = UIColor.white
        tempoTextView.isEditable = false
        tempoTextView.textAlignment = .center
        tempoTextView.backgroundColor = UIColor.clear
        
        // Add buttons and functionality
        playButton = UIButton()
        playButton.setImage(#imageLiteral(resourceName: "pauseButton"), for: .normal)
        playButton.addTarget(self, action: #selector(playOrPause), for: .touchUpInside)

        
        
    }
    
    func constrain() {
        
        addSubview(tempoUp)
        tempoUp.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
        }
        
        addSubview(tempoTextView)
        tempoTextView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(6)
            $0.width.equalTo(tempoUp.snp.width)
            $0.top.equalTo(tempoUp.snp.bottom)
        }
        
        addSubview(tempoDown)
        tempoDown.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(tempoTextView.snp.bottom)
        }
        
        addSubview(playButton)
        playButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-8)
        }
        
    }
    
    func tempoButtonTapped(_ sender: UIButton) {
        if sender.imageView?.image == #imageLiteral(resourceName: "arrowUp") {
            currentTempo += 5
            conductor.currentTempo = currentTempo
            tempoTextView.text = "\(currentTempo / 2)"
            
        } else {
            currentTempo -= 5
            conductor.currentTempo = currentTempo
            tempoTextView.text = "\(currentTempo / 2)"
            
        }
        
        
    }
    
    func playOrPause() {
        if conductor.isPlaying {
            playButton.setImage(#imageLiteral(resourceName: "playButton"), for: .normal)
        } else {
            playButton.setImage(#imageLiteral(resourceName: "pauseButton"), for: .normal)
        }
        conductor.isPlaying = !conductor.isPlaying
    }
    
}
