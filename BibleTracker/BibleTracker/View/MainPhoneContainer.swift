//
//  MainPhoneContainer.swift
//  BibleTracker
//
//  Created by Melissa Webster on 3/22/25.
//

import UIKit
import AnimatedCollectionViewLayout

class MainPhoneContainer: UIViewController {
    @IBOutlet weak var backgroundFillerTop: UIView!
    
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var primaryContentView: UIView!
    @IBOutlet weak var secondaryContentView: UIView! // hides header
    
    @IBOutlet weak var tabBar: UIView!
    @IBOutlet weak var homeTabBtn: UIButton!
    @IBOutlet weak var bibleTabBtn: UIButton!
    @IBOutlet weak var notesTabBtn: UIButton!
    
    @IBOutlet weak var tabBarShadow: UIView!
    
    @IBOutlet weak var tabBarOffset: NSLayoutConstraint!
    
    var mainViewController = ViewController()
    
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
        secondaryContentView.isHidden = true
        
    }
    
    @IBAction func showMenu(_ sender: UIButton) {
    }
    
    @IBAction func tabBtnPressed(_ sender: UIButton) {
    }
}
