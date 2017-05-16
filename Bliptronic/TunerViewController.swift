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

    var freqTracker: AKFrequencyTracker!
    let microphone = AKMicrophone()
    var timer: Timer!
    var silence: AKBooster?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AKSettings.audioInputEnabled = true 
        freqTracker = AKFrequencyTracker(microphone, hopSize: 60, peakCount: 560)
        silence = AKBooster(freqTracker!, gain: 0)


    }
    
    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(measureFrequency), userInfo: nil, repeats: true)
        AudioKit.output = silence

        AudioKit.start()
        microphone.start()
        freqTracker.start()
    }
    
    func measureFrequency() {
        print("timer fired")
        print("microphone is on: \(microphone.isStarted)")
        
        if let frequency = freqTracker?.frequency {
            print("frequency = \(frequency)")
        } else {
            print("frequency error")
        }
        
        if let amplitude = freqTracker?.amplitude {
            print("amplitute = \(amplitude)")
        } else {
            print("amplitute error")
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
