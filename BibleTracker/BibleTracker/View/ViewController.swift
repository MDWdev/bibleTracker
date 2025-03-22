//
//  ViewController.swift
//  BibleTracker
//
//  Created by Melissa Webster on 3/22/25.
//

import UIKit

var baseController: UIViewController?

class ViewController: UIViewController {
    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var nightModeOverlay: UIView!
    
    var authTimer: Timer?
    var statusBarStyle = UIStatusBarStyle.default
    
    let network: NetworkManager = NetworkManager.sharedInstance
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    var viewModel: MainViewModel? {
        didSet {
            guard let vm = viewModel else { return }
            
            vm.mainUser.bindAndFire { (user) in
                DispatchQueue.main.async {
                    print("User:", user ?? "none")
                    
                    if let _ = vm.getCurrentUser() {
                        if self.authTimer == nil {
                            // fires every 15 minutes
                            self.authTimer = Timer.init(timeInterval: 60*15, target: vm, selector: #selector(vm.checkUserAuth), userInfo: nil, repeats: true)
                            RunLoop.main.add(self.authTimer!, forMode: RunLoop.Mode.common)
                        }
                    }
                    
//                    if let baseController = baseController as? MainTabletContainer, let tvm = baseController.viewModel {
//                        tvm.update(user: user)
//                    } else if let baseController = baseController as? MainPhoneContainer, let pvm = baseController.viewModel {
//                        pvm.update(user: user)
//                    }
                }
            }
            
            vm.nightModeOn.bindAndFire { (isOn) in
                DispatchQueue.main.async {
                    self.updateNightMode(onOff: isOn)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            self.statusBarStyle = .lightContent
        }
        
        setNeedsStatusBarAppearanceUpdate()
        
        if viewModel == nil {
            viewModel = MainViewModel()
        }
        
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
//            showTablet()
        } else {
//            showPhone()
        }
    }
    
    func toBackground() {
        // if we have the auth refresh timer running, stop it while in background mode
        if authTimer != nil && authTimer!.isValid {
            authTimer!.invalidate()
        }
        authTimer = nil
    }
    
    func toForegroundCheck() {
        if let viewModel = viewModel {
            viewModel.refreshUser()
        
            if viewModel.getCurrentUser() != nil {
                if authTimer == nil {
                    // fires every 15 minutes
                    authTimer = Timer.init(timeInterval: 60*15, target: viewModel, selector: #selector(viewModel.checkUserAuth), userInfo: nil, repeats: true)
                    RunLoop.main.add(authTimer!, forMode: RunLoop.Mode.common)
                }
            }
        }
    }
    
    func showPhone() {
        guard let vm = viewModel else { return }
        for sub in self.mainContainer.subviews { sub.removeFromSuperview() }
        
        let phoneView = MainPhoneContainer(nibName: "MainPhoneContainer", bundle: nil)
        phoneView.viewModel = ContainersViewModel(withUser: vm.mainUser.value)
        phoneView.view.matchSize(mainContainer)
        self.addChild(phoneView)
        phoneView.mainViewController = self
        mainContainer.addSubview(phoneView.view)
    }
    
    func showTablet() {
        guard let vm = viewModel else { return }
        for sub in self.mainContainer.subviews { sub.removeFromSuperview() }
        
        let tabletView = MainTabletContainer(nibName: "MainTabletContainer", bundle: nil)
        tabletView.viewModel = ContainersViewModel(withUser: vm.mainUser.value)
        tabletView.view.matchSize(mainContainer)
        self.addChild(tabletView)
        mainContainer.addSubview(tabletView.view)
    }
    
    func updateNightMode(onOff: Bool) {
        if onOff == true {
            self.showNightMode()
        } else {
            self.hideNightMode()
        }
    }
    
    func showNightMode() {
        nightModeOverlay.isHidden = false
        
        let list = self.allViewControllers(nil)
        for topMost in list {
            if topMost != self {
                topMost.view.addRemoveLightFilter(true)
            }
        }
    }
    
    func hideNightMode() {
        nightModeOverlay.isHidden = true
        
        let list = self.allViewControllers(nil)
        for topMost in list {
            if topMost != self {
                topMost.view.addRemoveLightFilter(false)
            }
        }
    }
}

