//
//  CustomLogoImageView.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 28/03/22.
//

import UIKit

class CustomLogoImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configLogo()
    }
    
    private func configLogo() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 200),
            heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
