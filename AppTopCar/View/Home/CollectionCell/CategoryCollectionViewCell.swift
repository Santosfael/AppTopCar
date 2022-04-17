//
//  CategoryCollectionViewCell.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 14/04/22.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryCollectionViewCell"
    
    lazy private var serviceImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setupView()
        contentView.addSubview(serviceImage)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //serviceImage.frame = CGRect(x: 5, y: 5, width: contentView.frame.size.width - 10, height: contentView.frame.size.height - 5 - 50)
        constraint()
    }
    
    private func constraint() {
        NSLayoutConstraint.activate([
            serviceImage.topAnchor.constraint(equalTo: topAnchor),
            serviceImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            serviceImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            serviceImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func configure(with model: Service) {
        serviceImage.image = UIImage(named: model.thumbnail)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
