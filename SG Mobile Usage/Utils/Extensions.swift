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
    
}
