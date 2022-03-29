//
//  UIStackView+extensions.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 28/03/22.
//

import UIKit

extension UIStackView {
    public func addArrangedSubviews(_ subView: UIView...) {
        subView.forEach(addArrangedSubview)
    }
}
