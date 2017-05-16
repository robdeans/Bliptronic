//
//  ViewController.swift
//  Bliptronic5000
//
//  Created by Robert Deans on 12/23/16.
//  Copyright © 2016 Robert Deans. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var mainScreenView: MainScreenView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        
        mainScreenView = MainScreenView()
        
        view.addSubview(mainScreenView)
        mainScreenView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

