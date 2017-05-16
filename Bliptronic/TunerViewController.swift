//
//  TunerViewController.swift
//  Bliptronic
//
//  Created by Robert Deans on 5/16/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import AudioKit
import UIKit

class TunerViewController: UIViewController {
    
    var tracker: AKFrequencyTracker!
    let microphone = AKMicrophone()
    var timer: Timer!
    var silence: AKBooster?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AKSettings.audioInputEnabled = true
        tracker = AKFrequencyTracker(microphone, hopSize: 60, peakCount: 1320)
        silence = AKBooster(tracker!, gain: 0)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(detectFrequency), userInfo: nil, repeats: true)
        AudioKit.output = silence
        
        AudioKit.start()
        microphone.start()
        tracker.start()
    }
    
    func measureFrequency() {
        print("timer fired")
        print("microphone is on: \(microphone.isStarted)")
        
        if let frequency = tracker?.frequency {
            print("frequency = \(frequency)")
        } else {
            print("frequency error")
        }
        
        if let amplitude = tracker?.amplitude {
            print("amplitute = \(amplitude)")
        } else {
            print("amplitute error")
        }
    }
    
    func detectFrequency() {
        switch tracker.frequency {
        case 80.41...84:
            print("E")
        case 108...120:
            print("A")
        case 144.83...146:
            print("D")
        case 194...198:
            print("G")
        case 244.94...248:
            print("B")
        case 327.63...331:
            print("e")
        default:
            print("not in tune")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
