//
//  CustomButton.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 28/03/22.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configButton()
    }
    
    private func configButton() {
        translatesAutoresizingMaskIntoConstraints = false
        frame = .zero
        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
