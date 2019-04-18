//
//  Extensions.swift
//  SG Mobile Usage
//
//  Created by Himal Madhushan on 4/18/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import UIKit

// MARK: -
extension  UIView {
    
    @IBInspectable
    var viewCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable public var viewRounded : Bool {
        set {
            layer.cornerRadius = frame.size.height / 2
        }
        get {
            return self.viewRounded
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    // MARK: - View Shadow
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
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    func addViewShadow() {
        let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.shadowOffset = CGSize(width: 10, height: 0)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 7
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    func removeShadow() {
        self.layer.shadowColor = UIColor.clear.cgColor
        self.layer.shadowPath = nil
    }
    
    func resetTransform(duration: CGFloat) {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.transform = .identity
        }) { (completed) in
        }
    }
    
}


// MARK: -
extension UIViewController {
    
    func showAlert(title: String, message: String, actionTitle: String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .cancel, handler:nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String, actionTitle: String, completion: @escaping (()->())) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .cancel, handler: { (action) in
            completion()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title: String?, message: String, actionTitle: String, isConfirm: Bool = false, completion: @escaping (()->())) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if isConfirm {
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            }))
            alert.addAction(UIAlertAction(title: actionTitle, style: .destructive, handler: { (action) in
                completion()
            }))
        } else {
            alert.addAction(UIAlertAction(title: actionTitle, style: .cancel, handler: { (action) in
                completion()
            }))
        }
        present(alert, animated: true, completion: nil)
    }
}


// MARK: -
extension UIButton {
    
    @IBInspectable public var isBtnRounded : Bool {
        set {
            layer.cornerRadius = frame.size.height / 2
        }
        get {
            return self.isBtnRounded
        }
    }
    
    @IBInspectable public var btnCornerRadius : CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}


// MARK: -
extension UIColor {
    static let themeBlue = #colorLiteral(red: 0.2470588235, green: 0.6588235294, blue: 0.9176470588, alpha: 1)
}


// MARK: -
extension String {
    var capitalizeFirstLetter: String {
        let string = self
        return string.replacingCharacters(in: startIndex...startIndex, with: String(self[startIndex]).capitalized)
    }
}


// MARK: -
extension Array {
    func removeDuplicates(array: [String]) -> [String] {
        var encountered = Set<String>()
        var result: [String] = []
        for value in array {
            if !encountered.contains(value) {
                // Do not add a duplicate element.
                encountered.insert(value)
                result.append(value)
            }
        }
        return result
    }
}


// MARK: -
extension Dictionary {
    @discardableResult mutating func add(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
    
    func containsAndNotNil(key: Key) -> Bool {
        if self.keys.contains(key) && !(self[key] is NSNull) && self[key] != nil {
            return true
        } else {
            return false
        }
    }
}


// MARK: -
extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
}


// MARK: -
protocol JSONConvertible {}
extension JSONConvertible {
    func toDictionary() -> [String:Any] {
        var dict = [String:Any]()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                dict[key] = child.value
            }
        }
        return dict
    }
}
