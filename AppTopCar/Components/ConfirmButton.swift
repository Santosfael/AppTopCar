//
//  ConfirmButton.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 28/03/22.
//

import UIKit

class ConfirmButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configButton()
    }
    
    private func configButton() {
        translatesAutoresizingMaskIntoConstraints = false
        frame = .zero
        layer.cornerRadius = 8
        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        heightAnchor.constraint(equalToConstant: 45).isActive = true
        backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
