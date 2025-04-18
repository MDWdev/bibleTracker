//
//  MenuUVC.swift
//  BibleTracker
//
//  Created by Melissa Webster on 4/18/25.
//

import UIKit
import NVActivityIndicatorView

class MenuUVC: UIViewController, NVActivityIndicatorViewable {
    @IBOutlet weak var xBtn: UIButton! // hide when on tablet
    @IBOutlet weak var topSepView: UIView! // hide when on tablet
    @IBOutlet weak var signInBtn: FittedImageButton!
    @IBOutlet weak var myNotesBtn: FittedImageButton!
    @IBOutlet weak var notesBtnHeight: NSLayoutConstraint! // 0 when no user, 58 when user
    @IBOutlet weak var notesBtnSepView: UIView! // hide til signed in
    @IBOutlet weak var settingsBtn: FittedImageButton!
    @IBOutlet weak var shareBtn: FittedImageButton!
    @IBOutlet weak var copyrightLbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContent: UIView!
    
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    
    @IBOutlet weak var rateBtn: FittedImageButton!
    @IBOutlet weak var rateLine: UIView!
    @IBOutlet weak var rateHeight: NSLayoutConstraint!
    
    var phoneParent: MainPhoneContainer?
//    var profilePAGE: ProfileUVC?
    var signInPAGE: SignInUVC?
}
