//
//  SettingsService.swift
//  BibleTracker
//
//  Created by Melissa Webster on 3/22/25.
//

import UIKit

enum AppTextSize: Int {
    case phoneSmall = 14
    case phoneMedium = 19
    case phoneLarge = 24
    case tabletSmall = 18
    case tabletMedium = 22
    case tabletLarge = 30
}

class SettingsService: NSObject {
    static let shared = SettingsService()
    
    let chosenTextSize: Dynamic<AppTextSize?>
    let nightModeOn: Dynamic<Bool>
    
    private override init() {
        print("Settings Service initialized")
        chosenTextSize = Dynamic(nil)
        nightModeOn = Dynamic(false)
        super.init()
        
        setTextSize(with: nil)
        setNightMode(onOff: nil)
    }
}

extension SettingsService {
    func setNightMode(onOff: Bool?) {
        if let onOff = onOff {
            nightModeOn.value = onOff
            UserDefaults.standard.set("\(onOff)", forKey: "nightModeOn")
            UserDefaults.standard.synchronize()
            return
        }
        
        if let nmStat = UserDefaults.standard.value(forKey: "nightModeOn") as? String {
            if nmStat == "true" {
                nightModeOn.value = true
            } else {
                nightModeOn.value = false
            }
        }
    }
    
    func isNightModeOn() -> Bool {
        return nightModeOn.value
    }
    
    func setTextSize(with size: AppTextSize?) {
        if let size = size {
            chosenTextSize.value = size
            switch size {
            case .phoneSmall, .tabletSmall:
                UserDefaults.standard.set("small", forKey: "textSize")
            case .phoneLarge, .tabletLarge:
                UserDefaults.standard.set("large", forKey: "textSize")
            default:
                UserDefaults.standard.set("medium", forKey: "textSize")
            }
            
            UserDefaults.standard.synchronize()
            
            return
        }
        
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            if let txtSz = UserDefaults.standard.value(forKey: "textSize") as? String {
                switch txtSz {
                case "small":
                    chosenTextSize.value = .tabletSmall
                case "large":
                    chosenTextSize.value = .tabletLarge
                default:
                    chosenTextSize.value = .tabletMedium
                }
            } else {
                chosenTextSize.value = .tabletMedium
            }
        } else {
            if let txtSz = UserDefaults.standard.value(forKey: "textSize") as? String {
                switch txtSz {
                case "small":
                    chosenTextSize.value = .phoneSmall
                case "large":
                    chosenTextSize.value = .phoneLarge
                default:
                    chosenTextSize.value = .phoneMedium
                }
            } else {
                chosenTextSize.value = .phoneMedium
            }
        }
    }
}
