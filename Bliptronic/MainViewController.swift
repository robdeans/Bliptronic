//
//  ViewController.swift
//  Bliptronic5000
//
//  Created by Robert Deans on 12/23/16.
//  Copyright © 2016 Robert Deans. All rights reserved.
//

import UIKit
import AudioKit

class MainViewController: UIViewController {
    
    var mainScreenView: MainScreenView!
    
    var playButton: UIButton!
    var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
                
        mainScreenView = MainScreenView()
        
        playButton = UIButton()
        playButton.setTitle("▶️", for: .normal)
        playButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        
        stopButton = UIButton()
        stopButton.setTitle("⏹", for: .normal)
        stopButton.addTarget(self, action: #selector(stop), for: .touchUpInside)

        view.addSubview(mainScreenView)
        mainScreenView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(playButton)
        playButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
        }
        
        view.addSubview(stopButton)
        stopButton.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func play() {
//        conductor.sequencer.play()
    }
    
    func stop() {
//        conductor.sequencer.stop()
    }
    
}

