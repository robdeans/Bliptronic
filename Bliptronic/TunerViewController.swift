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
        tracker = AKFrequencyTracker(microphone, hopSize: 60, peakCount: 560)
        silence = AKBooster(tracker!, gain: 0)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(detectFrequency), userInfo: nil, repeats: true)
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
        case 81.91...82.91:
            print("E")
        case 109.5...110.5:
            print("A")
        case 146.33...147.33:
            print("D")
        case 195.5...196.5:
            print("G")
        case 246.44...247.44:
            print("B")
        case 329.13...330.13:
            print("e")
        default:
            print("not in tune \(tracker.frequency)")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
