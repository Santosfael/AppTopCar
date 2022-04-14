//
//  CustomTableViewCell.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 08/04/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    lazy private var serviceImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "house")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy private var inforServiceStack: CustomVerticalStack = {
        let stack = CustomVerticalStack()
        stack.contentMode = .top
        return stack
    }()
    
    lazy private var titleLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "Rafael"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    lazy private var descriptionLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "Rocha dos Santos"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CustomTableViewCell: CodeView {
    func buildViewHierarchy() {
        addSubviews(serviceImage, inforServiceStack)
        inforServiceStack.addArrangedSubviews(titleLabel, descriptionLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            serviceImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            serviceImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            serviceImage.widthAnchor.constraint(equalToConstant: 45),
            serviceImage.heightAnchor.constraint(equalToConstant: 45)
            
        ])
        
        NSLayoutConstraint.activate([
            inforServiceStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            inforServiceStack.leadingAnchor.constraint(equalTo: serviceImage.trailingAnchor, constant: 16),
            inforServiceStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            inforServiceStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func setupAdditionalConfiguration() {
        
    }
    
    
}
