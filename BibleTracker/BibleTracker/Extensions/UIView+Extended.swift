//
//  UIView+Extended.swift
//  BibleTracker
//
//  Created by Melissa Webster on 3/22/25.
//

//
//  UIView+Extended.swift
//  titw
//
//  Created by jacappsios on 7/18/19.
//  Copyright © 2019 Moody. All rights reserved.
//

import UIKit

extension UIView {
    func matchSize(_ matchView:UIView) {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: matchView.frame.width, height: matchView.frame.height)
    }
    
    func matchFrame(_ matchView:UIView) {
        self.frame = CGRect(x: matchView.frame.origin.x, y: matchView.frame.origin.y, width: matchView.frame.width, height: matchView.frame.height)
    }
    
    func bottomEdge() -> CGFloat {
        return self.frame.origin.y + self.frame.height
    }
    func rightEdge() -> CGFloat {
        return self.frame.origin.x + self.frame.width
    }
    
    func adjustFrameX(_ offset:CGFloat) {
        self.frame = CGRect(x: offset, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height)
    }
    func adjustFrameY(_ offset:CGFloat) {
        self.frame = CGRect(x: self.frame.origin.x, y: offset, width: self.frame.width, height: self.frame.height)
    }
    func adjustFrameWidth(_ newWidth:CGFloat) {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: newWidth, height: self.frame.height)
    }
    func adjustFrameHeight(_ newHeight:CGFloat) {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: newHeight)
    }
    
    func addRemoveLightFilter(_ show: Bool) {
        var found = false
        for sub in self.subviews {
            if let overlay = sub as? LightFilterOverlay {
                overlay.isHidden = !show
                found = true
            }
        }
        if !found {
            let newOverlay = LightFilterOverlay(frame: self.bounds)
            newOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            newOverlay.isHidden = !show
            self.addSubview(newOverlay)
        }
    }
}

class LightFilterOverlay: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.red.withAlphaComponent(0.2)
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.backgroundColor = UIColor.red.withAlphaComponent(0.2)
    }
}

/**
 UIView with Interface Builder accessible border width and color
 */
@IBDesignable class BorderBoxView: UIView {
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
}

/**
 UIView with Interface Builder accessible rounded corners
 */
@IBDesignable class RoundedView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
}

extension UIView{
    func roundCorners(toBounds: CGRect, topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {
        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
        let maskPath = UIBezierPath(shouldRoundRect: toBounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}

extension UIBezierPath {
    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGSize = .zero, topRightRadius: CGSize = .zero, bottomLeftRadius: CGSize = .zero, bottomRightRadius: CGSize = .zero){
        
        self.init()
        
        let path = CGMutablePath()
        
        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        
        if topLeftRadius != .zero {
            path.move(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }
        
        if topRightRadius != .zero {
            path.addLine(to: CGPoint(x: topRight.x-topRightRadius.width, y: topRight.y))
            path.addCurve(to:  CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height), control1: CGPoint(x: topRight.x, y: topRight.y), control2:CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height))
        } else {
            path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
        }
        
        if bottomRightRadius != .zero{
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y-bottomRightRadius.height))
            path.addCurve(to: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y), control1: CGPoint(x: bottomRight.x, y: bottomRight.y), control2: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y))
        } else {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y))
        }
        
        if bottomLeftRadius != .zero{
            path.addLine(to: CGPoint(x: bottomLeft.x+bottomLeftRadius.width, y: bottomLeft.y))
            path.addCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height), control1: CGPoint(x: bottomLeft.x, y: bottomLeft.y), control2: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height))
        } else {
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
        }
        
        if topLeftRadius != .zero{
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y+topLeftRadius.height))
            path.addCurve(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y) , control1: CGPoint(x: topLeft.x, y: topLeft.y) , control2: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }
        
        path.closeSubpath()
        cgPath = path
    }
}
