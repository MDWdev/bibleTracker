//
//  UITextField+Extended.swift
//  BibleTracker
//
//  Created by Melissa Webster on 3/22/25.
//

import UIKit

@IBDesignable class rightImgField: UITextField {
    @IBInspectable var rightImg: UIImage? {
        didSet {
            self.rightView = UIImageView(image: rightImg)
            self.rightViewMode = .unlessEditing
        }
    }
}

@IBDesignable class leftImgField: UITextField {
    @IBInspectable var leftImg: UIImage? {
        didSet {
            let thisImg = UIImageView(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
            thisImg.image = leftImg
            self.leftView = thisImg
            self.leftViewMode = .unlessEditing
        }
    }
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: (bounds.size.height-22)/2.0, width: 22, height: 22)
    }
}
