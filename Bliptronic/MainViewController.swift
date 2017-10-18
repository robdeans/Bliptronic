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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    
    func setupUI() {
        // Add Mainscreen
        mainScreenView = MainScreenView()
        view.addSubview(mainScreenView)
        mainScreenView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // Add Background
        let pastelView = PastelView(frame: view.bounds)
        
        // Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        
        // Custom Duration
        pastelView.animationDuration = 3.0
        
        // Custom Color
        pastelView.setColors([//UIColor.pastelMagenta,
                              //UIColor.pastelPink,
                              UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
                              UIColor.pastelBlue,
                              UIColor.pastelLightBlue,
                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                              UIColor.pastelTeal])
        
        pastelView.startAnimation()
        view.insertSubview(pastelView, at: 0)
    }
}

