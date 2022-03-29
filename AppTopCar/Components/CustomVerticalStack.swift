//
//  CustomVerticalStack.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 28/03/22.
//

import UIKit

class CustomVerticalStack: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configStack()
    }
    
    private func configStack() {
        translatesAutoresizingMaskIntoConstraints = false
        distribution = .equalSpacing
        spacing = 10
        axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
