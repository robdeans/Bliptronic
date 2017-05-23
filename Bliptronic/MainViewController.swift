//
//  ViewController.swift
//  Bliptronic5000
//
//  Created by Robert Deans on 12/23/16.
//  Copyright © 2016 Robert Deans. All rights reserved.
//

import UIKit
import AudioKit
import Pastel

class MainViewController: UIViewController {
    
    var mainScreenView: MainScreenView!
    
    var playButton: UIButton!
    var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainScreenView = MainScreenView()
        
        view.addSubview(mainScreenView)
        mainScreenView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        
        playButton = UIButton()
        playButton.setTitle("▶️", for: .normal)
        playButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        
        stopButton = UIButton()
        stopButton.setTitle("⏹", for: .normal)
        stopButton.addTarget(self, action: #selector(stop), for: .touchUpInside)
        
        view.addSubview(playButton)
        playButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
        }
        
        view.addSubview(stopButton)
        stopButton.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
        }
        
        let pastelView = PastelView(frame: view.bounds)
        
        // Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        
        // Custom Duration
        pastelView.animationDuration = 3.0
        
        // Custom Color
        pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                              UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
                              UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                              UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])
        
        pastelView.startAnimation()
        view.insertSubview(pastelView, at: 0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func play() {
        mainScreenView.synthView.conductor.sequence.play()
    }
    
    func stop() {
        mainScreenView.synthView.conductor.sequence.stop()
    }
    
}

