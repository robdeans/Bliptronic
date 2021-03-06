//
//  Colors.swift
//  Bliptronic5000
//
//  Created by Robert Deans on 3/25/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    // soft purple
    public static let blipActive = UIColor(red: 91/255, green: 54/255, blue: 150/255, alpha: 1)
    
    // eggshell white/blue
    public static let blipInactive = UIColor(red: 168/255, green: 227/255, blue: 255/255, alpha: 1)
    
    public static let pastelMagenta = UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1)
    public static let pastelPink = UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1)
    public static let pastelBlue = UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1)
    public static let pastelLightBlue = UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0)
    public static let pastelTeal = UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)
    
    public static func generateRandomColor() -> UIColor {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        
        return color
    }
}


// MARK: Gradients
extension CAGradientLayer {
    convenience init(_ colors: [UIColor]) {
        self.init()
        
        self.colors = colors.map { $0.cgColor }
    }
}

extension CALayer {
    
    public static func makeGradient(firstColor: UIColor, secondColor: UIColor) -> CAGradientLayer {
        let backgroundGradient = CAGradientLayer()
        
        backgroundGradient.colors = [firstColor.cgColor, secondColor.cgColor]
        backgroundGradient.locations = [0, 1]
        backgroundGradient.startPoint = CGPoint(x: 0, y: 0)
        backgroundGradient.endPoint = CGPoint(x: 0, y: 1)
        
        return backgroundGradient
    }
}
