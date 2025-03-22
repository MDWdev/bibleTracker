//
//  UIColor+Extended.swift
//  BibleTracker
//
//  Created by Melissa Webster on 3/22/25.
//

//
//  UIColor+Extended.swift
//  titw
//
//  Created by jacappsios on 7/19/19.
//  Copyright © 2019 Moody. All rights reserved.
//

import UIKit

extension UIColor {
    /**
     Create UIColor object from a HEX string
     
     - Parameter hex: The string value, starting with or without `#`
     
     */
    convenience init(hex: String) {
        let hexIn = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hexIn)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    /**
     Holds colors used throughout the app
     */
    struct AppColors {
        static let darkBlue = UIColor(red:46.0/255.0, green:45.0/255.0, blue:77.0/255.0, alpha:1) // 2E2D4D
        static let pearl = UIColor(red:234.0/255.0, green:224.0/255.0, blue:204.0/255.0, alpha:1) // EAE0CC
        static let pink = UIColor(red:166.0/255.0, green:127.0/255.0, blue:142.0/255.0, alpha:1) // A67F8E
        static let darkGreen = UIColor(red:2.0/255.0, green:54.0/255.0, blue:24.0/255.0, alpha:1) // 023618
        static let lightGreen = UIColor(red:100.0/255.0, green:135.0/255.0, blue:103.0/255.0, alpha:1)  // 648767
    }
    
    /**
     Is this color considered "light"
     */
    func isLight() -> Bool {
        // algorithm from: http://www.w3.org/WAI/ER/WD-AERT/#color-contrast
        if let components = self.cgColor.components {
            let brightness = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000
            
            if brightness < 0.5
            {
                return false
            }
            else
            {
                return true
            }
        }
        return false
    }
    
    func darkEnough() -> Bool {
        if let components = self.cgColor.components {
            let brightness = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000
            
            if brightness < 0.13
            {
                return true
            }
            else
            {
                return false
            }
        }
        return false
    }
    
    func reallyLight() -> Bool {
        if let components = self.cgColor.components {
            let brightness = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000
            
            if brightness > 0.8
            {
                return true
            }
            else
            {
                return false
            }
        }
        return false
    }
}
