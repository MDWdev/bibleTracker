//
//  UIButton+Extended.swift
//  BibleTracker
//
//  Created by Melissa Webster on 3/22/25.
//

import UIKit

class LargerAreaButton: UIButton {
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // if the button is hidden/disabled/transparent it can't be hit
        if self.isHidden || !self.isUserInteractionEnabled || self.alpha < 0.01 { return nil }
        
        // increase the hit frame to be at least as big as `minimumHitArea`
        let widthToAdd:CGFloat = 20
        let heightToAdd:CGFloat = 20
        let largerFrame = self.bounds.insetBy(dx: -widthToAdd / 2, dy: -heightToAdd / 2)
        
        // perform hit test on larger frame
        return (largerFrame.contains(point)) ? self : nil
    }
}

/**
 UIButton with Interface Builder accessible rounded corners
 */
@IBDesignable class RoundedButtonView: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
}

/**
 Makes the image of the UIButton be aspect fit scale
 */
@IBDesignable class FittedImageButton: UIButton {
    
    @IBInspectable var edgeSize: CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if imageView != nil {
            imageView!.contentMode = .scaleAspectFit
        }
        self.imageEdgeInsets = UIEdgeInsets(top: edgeSize, left: edgeSize, bottom: edgeSize, right: edgeSize)
        self.titleLabel?.numberOfLines = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if imageView != nil {
            imageView!.contentMode = .scaleAspectFit
        }
        self.imageEdgeInsets = UIEdgeInsets(top: edgeSize, left: edgeSize, bottom: edgeSize, right: edgeSize)
        self.titleLabel?.numberOfLines = 1
    }
    
    override func awakeFromNib() {
        if imageView != nil {
            imageView!.contentMode = .scaleAspectFit
        }
        self.imageEdgeInsets = UIEdgeInsets(top: edgeSize, left: edgeSize, bottom: edgeSize, right: edgeSize)
        self.titleLabel?.numberOfLines = 1
    }
}

extension UIButton {
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        
        self.setAttributedTitle(attributedString, for: .normal)
    }
}

extension UILabel {
    func underline() {
        guard let text = self.text else { return }
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        
        self.attributedText = attributedString
    }
}
