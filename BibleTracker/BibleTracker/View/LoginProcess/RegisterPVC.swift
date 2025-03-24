//
//  RegisterPVC.swift
//  BibleTracker
//
//  Created by Melissa Webster on 3/22/25.
//

import UIKit
import NVActivityIndicatorView

class RegisterPVC: KeyboardViewController, NVActivityIndicatorViewable {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    var fpTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerForKeyboardNotifications()
    }
    
    @IBAction func goBack() {
        self.dismissDetailToLeft()
    }
    
    @IBAction func submit() {}
}
