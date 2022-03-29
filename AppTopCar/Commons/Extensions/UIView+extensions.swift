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
}
