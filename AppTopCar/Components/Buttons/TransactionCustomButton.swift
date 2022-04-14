//
//  TransactionCustomButton.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 01/04/22.
//

import Foundation
import TransitionButton

class TransactionCustomButton: TransitionButton {
    
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
        isEnabled = false
        spinnerColor = .white
        alpha = 0.5
        backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
