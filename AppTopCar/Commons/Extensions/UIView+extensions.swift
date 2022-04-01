//
//  UIView+extensions.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 28/03/22.
//

import UIKit

extension UIView {
    public func addSubviews(_ subView: UIView...) {
        subView.forEach(addSubview)
    }
    
    public func alertInfo(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.window?.rootViewController?.present(alert, animated: true)
    }
}
