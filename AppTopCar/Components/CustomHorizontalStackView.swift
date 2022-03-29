//
//  CustomHorizontalStackView.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 28/03/22.
//

import UIKit

class CustomHorizontalStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configStack()
    }
    
    private func configStack() {
        translatesAutoresizingMaskIntoConstraints = false
        distribution = .equalSpacing
        contentMode = .center
        spacing = 8
        axis = .horizontal
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
