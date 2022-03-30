//
//  CustomTextField.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 28/03/22.
//

import UIKit

class CustomTexField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configTextField()
    }
    
    private func configTextField() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        heightAnchor.constraint(equalToConstant: 45).isActive = true
        backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
        isUserInteractionEnabled = true
        autocapitalizationType = .none
        autocorrectionType = .no
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
