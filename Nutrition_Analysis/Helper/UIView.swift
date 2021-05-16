//
//  UIView + IBDesignable.swift
//  Nutrition_Analysis
//
//  Created by Michael Maher on 5/4/21.
//

import UIKit

extension UIView {
    
    func addFadeShadow() {
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.6
        self.layer.masksToBounds = false
    }
    
    func addCornersAndBorders(radius: CGFloat, borderColor: UIColor? = nil, borderWidth: CGFloat? = nil) {
        if let borderWidth = borderWidth {
            self.layer.borderWidth = borderWidth
        }
        if let borderColor = borderColor {
            self.layer.borderColor = borderColor.cgColor
        }
        self.layer.cornerRadius = radius

        self.clipsToBounds = true
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {

            layer.shadowRadius = newValue
        }
    }
    @IBInspectable
    var shadowOffset : CGSize{

        get{
            return layer.shadowOffset
        }set{

            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor : UIColor{
        get{
            return UIColor.init(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    @IBInspectable
    var shadowOpacity : Float {

        get{
            return layer.shadowOpacity
        }
        set {

            layer.shadowOpacity = newValue

        }
    }
}
