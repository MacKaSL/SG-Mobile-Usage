//
//  Helper.swift
//  SG Mobile Usage
//
//  Created by Himal Madhushan on 4/18/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import UIKit

class Helper {
    
    // MARK: - UI
    static func rootViewController() -> UIViewController? {
         return (UIApplication.shared.delegate?.window!?.rootViewController)!
    }
    
    /// To be used from non-UIViewController classes
    ///
    /// - Parameters:
    ///   - on: a UIViewController (optional)
    ///   - title: Alert title
    ///   - message: Alert message
    static func showAlert(on: UIViewController? = nil, title: String, message: String, completion: (()->())? = nil) {
        DispatchQueue.main.async(execute: {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                completion?()
            }))
            if on == nil {
                rootViewController()?.present(alert, animated: true, completion: nil)
            } else {
                on?.present(alert, animated: true, completion: nil)
            }
        })
    }
    
}
