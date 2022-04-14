//
//  CategoryCollectionViewCell.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 14/04/22.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryCollectionViewCell"
    
    lazy private var inforServiceStack: CustomVerticalStack = {
        let stack = CustomVerticalStack()
        stack.contentMode = .top
        return stack
    }()
    
    lazy private var serviceImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "house")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy private var titleLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "Rafael"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CategoryCollectionViewCell: CodeView {
    func buildViewHierarchy() {
        addSubviews(inforServiceStack)
        inforServiceStack.addArrangedSubviews(serviceImage, titleLabel)
    }
    
    func setupConstraints() {
        
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
