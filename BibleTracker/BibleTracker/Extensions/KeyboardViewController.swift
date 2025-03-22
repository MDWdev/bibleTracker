//
//  KeyboardViewController.swift
//  BibleTracker
//
//  Created by Melissa Webster on 3/22/25.
//

import UIKit

class KeyboardViewController: UIViewController {
    
    var activeField: UITextField?
    var activeTextView: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeShown), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func clearKeyboard() {
        if activeField != nil {
            activeField!.resignFirstResponder()
            activeField = nil
        }
        if activeTextView != nil {
            activeTextView!.resignFirstResponder()
            activeTextView = nil
        }
    }
    
    @objc func keyboardWillBeShown(sender: NSNotification) {
        let info: NSDictionary = sender.userInfo! as NSDictionary
        let value: NSValue = info.value(forKey: UIResponder.keyboardFrameBeginUserInfoKey) as! NSValue
        let keyboardSize: CGSize = value.cgRectValue.size
        let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        if activeField != nil && activeField!.superview!.isKind(of: UIScrollView.self) {
            (activeField?.superview as? UIScrollView)?.contentInset = contentInsets
            (activeField?.superview as? UIScrollView)?.scrollIndicatorInsets = contentInsets
        } else if activeField != nil && activeField!.superview!.superview!.isKind(of: UIScrollView.self) {
            (activeField?.superview?.superview as? UIScrollView)?.contentInset = contentInsets
            (activeField?.superview?.superview as? UIScrollView)?.scrollIndicatorInsets = contentInsets
        } else if activeTextView != nil {
            activeTextView!.contentInset = contentInsets
            activeTextView!.scrollIndicatorInsets = contentInsets
        }
        // If active text field is hidden by keyboard, scroll it so it's visible
        // Your app might not need or want this behavior.
        var aRect: CGRect = self.view.frame
        aRect.size.height -= keyboardSize.height
        if activeField != nil {
            let activeTextFieldRect: CGRect? = activeField?.frame
            var activeTextFieldOrigin: CGPoint? = activeTextFieldRect?.origin
            activeTextFieldOrigin!.y += activeTextFieldRect!.height
            if (!aRect.contains(activeTextFieldOrigin!)) {
                if activeField!.superview!.isKind(of: UIScrollView.self) {
                    (activeField?.superview as? UIScrollView)?.scrollRectToVisible(activeTextFieldRect!, animated:true)
                } else if activeField!.superview!.superview!.isKind(of: UIScrollView.self) {
                    (activeField?.superview?.superview as? UIScrollView)?.scrollRectToVisible(activeTextFieldRect!, animated:true)
                }
            }
        }
    }
    
    // Called when the UIKeyboardWillHideNotification is sent
    @objc func keyboardWillBeHidden(sender: NSNotification) {
        let contentInsets: UIEdgeInsets = UIEdgeInsets.zero
        if activeField != nil {
            (activeField?.superview as? UIScrollView)?.contentInset = contentInsets
            (activeField?.superview as? UIScrollView)?.scrollIndicatorInsets = contentInsets
            (activeField?.superview?.superview as? UIScrollView)?.contentInset = contentInsets
            (activeField?.superview?.superview as? UIScrollView)?.scrollIndicatorInsets = contentInsets
        } else if activeTextView != nil {
            activeTextView!.contentInset = contentInsets
            activeTextView!.scrollIndicatorInsets = contentInsets
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if activeField != nil {
            activeField!.resignFirstResponder()
            activeField = nil
        } else if activeTextView != nil {
            activeTextView!.resignFirstResponder()
            activeTextView = nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension KeyboardViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
}

class PassThroughScroll: UIScrollView {
    @IBOutlet weak var sub: UIViewController!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sub.touchesBegan(touches, with: event)
    }
}

class PassThroughTable: UITableView {
    @IBOutlet weak var sub: UIViewController!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sub.touchesBegan(touches, with: event)
    }
}
