//
//  MainTabletContainer.swift
//  BibleTracker
//
//  Created by Melissa Webster on 3/22/25.
//

import UIKit
import AnimatedCollectionViewLayout

class MainTabletContainer: UIViewController {
    @IBOutlet weak var header: UIView!
    
    @IBOutlet weak var primaryContentArea: UIView!
    @IBOutlet weak var secondaryContentArea: UIView! // hides header
    @IBOutlet weak var sideBarContentArea: UIView!
    @IBOutlet weak var sideBarContentLeading: NSLayoutConstraint!
    @IBOutlet weak var secondaryContentLeading: NSLayoutConstraint!
    @IBOutlet weak var secondaryContentWidth: NSLayoutConstraint!
    
    @IBOutlet weak var tabBar: UIView!
    @IBOutlet weak var tabBarShadow: UIView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    
    @IBOutlet weak var homeTabBtn: UIButton!
    @IBOutlet weak var bibleTabBtn: UIButton!
    @IBOutlet weak var notesTabBtn: UIButton!
    
    @IBOutlet weak var menuOverlay: UIView!
    
    var viewModel: ContainersViewModel? {
        didSet {
            guard let vm = viewModel else { return }
            
            vm.mainUser.bindAndFire { (user) in
                DispatchQueue.main.async {
                    
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseController = self
        
    }
    
    @IBAction func showMenu(_ sender: UIButton) {
    }
    
    @IBAction func showSearch(_ sender: UIButton) {
    }
    
    @IBAction func tabBtnPressed(_ sender: UIButton) {
    }
    
    
}

// open close secondary views
extension MainTabletContainer {
    
}
