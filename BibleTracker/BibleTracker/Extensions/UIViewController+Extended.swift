//
//  UIViewController+Extended.swift
//  BibleTracker
//
//  Created by Melissa Webster on 3/22/25.
//

import UIKit

extension UIViewController {
    func presentDetailFromLeft(_ viewControllerToPresent: UIViewController, callAfter: (() -> Void)? = nil) {
        self.presentDetailType(CATransitionSubtype.fromLeft, viewControllerToPresent: viewControllerToPresent, callAfter: callAfter)
    }
    
    func presentDetailFromRight(_ viewControllerToPresent: UIViewController, callAfter: (() -> Void)? = nil) {
        self.presentDetailType(CATransitionSubtype.fromRight, viewControllerToPresent: viewControllerToPresent, callAfter: callAfter)
    }
    
    func dismissDetailToLeft(_ callAfter: (() -> Void)? = nil) {
        self.dismissDetailType(CATransitionSubtype.fromRight, callAfter: callAfter)
    }
    
    func dismissDetailToRight(_ callAfter: (() -> Void)? = nil) {
        self.dismissDetailType(CATransitionSubtype.fromLeft, callAfter: callAfter)
    }
    
    private func presentDetailType(_ type:CATransitionSubtype, viewControllerToPresent: UIViewController, callAfter: (() -> Void)? = nil) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.moveIn
        transition.subtype = type
        if self.view.window != nil {
            self.view.window!.layer.add(transition, forKey: kCATransition)
        }
        if !viewControllerToPresent.isBeingPresented {
            present(viewControllerToPresent, animated: false) {
                if callAfter != nil {
                    callAfter!()
                }
            }
        }
    }
    
    private func dismissDetailType(_ type:CATransitionSubtype, callAfter: (() -> Void)?) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.moveIn
        transition.subtype = type
        if self.view.window != nil {
            self.view.window!.layer.add(transition, forKey: kCATransition)
        }
        
        if self.isBeingDismissed { return }
        dismiss(animated: false) {
            if callAfter != nil {
                callAfter!()
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "modalIsDimissed"), object: nil)
        }
    }
    
    func presentFadeAlpha(viewControllerToPresent: UIViewController, callAfter: (() -> Void)? = nil) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.fade
        if self.view.window != nil {
            self.view.window!.layer.add(transition, forKey: kCATransition)
        }
        if !viewControllerToPresent.isBeingPresented {
            present(viewControllerToPresent, animated: false) {
                if callAfter != nil {
                    callAfter!()
                }
            }
        }
    }
    
    func dismissFadeAlpha(callAfter: (() -> Void)? = nil) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.fade
        if self.view.window != nil {
            self.view.window!.layer.add(transition, forKey: kCATransition)
        }
        
        if self.isBeingDismissed { return }
        dismiss(animated: false) {
            if callAfter != nil {
                callAfter!()
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "modalIsDimissed"), object: nil)
        }
    }
}

extension UIViewController {
    func topMostViewController() -> UIViewController {
        if self.presentedViewController == nil {
            return self
        }
        if let navigation = self.presentedViewController as? UINavigationController {
            if let visibleController = navigation.visibleViewController {
                return visibleController.topMostViewController()
            }
        }
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        return self.presentedViewController!.topMostViewController()
    }
    
    func allViewControllers(_ listIn: [UIViewController]?) -> [UIViewController] {
        var list: [UIViewController]? = listIn
        if self.presentedViewController == nil {
            if list == nil {
                return [self]
            } else {
                list!.append(self)
                return list!
            }
        }
        
        if list == nil {
            list = [self]
        } else {
            list!.append(self)
        }
        return self.presentedViewController!.allViewControllers(list)
    }
}
