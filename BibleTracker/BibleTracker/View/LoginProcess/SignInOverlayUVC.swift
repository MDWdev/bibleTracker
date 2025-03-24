//
//  SignInOverlayUVC.swift
//  BibleTracker
//
//  Created by Melissa Webster on 3/22/25.
//

import UIKit
import NVActivityIndicatorView

class SignInOverlayUVC: KeyboardViewController, NVActivityIndicatorViewable {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    var fpTextField = UITextField()
    var returnScreen = ""
    
    var registerPPAGE: RegisterPVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerForKeyboardNotifications()
    }
    
    @IBAction func closeOverlay() {
        self.dismissFadeAlpha()
    }
    
    @IBAction func signIn() {}
    
    @IBAction func forgotPassword() {}
    
    @IBAction func openRegisterPage() {}
}
