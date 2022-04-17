//
//  CustomTableViewCell.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 08/04/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    private var categoryService = [CategoryService]()
    private var services = [Service]()
    
    lazy private var serviceByCategoryCollectionView: UICollectionView = {
        let layout = collectionLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.isScrollEnabled = true
        return collection
    }()
    
    lazy var titleCategoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupService()
        setupView()
        register()
        delegates()
    }
    
    private func delegates() {
        serviceByCategoryCollectionView.delegate = self
        serviceByCategoryCollectionView.dataSource = self
    }
    
    private func register() {
        serviceByCategoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
    
    private func setupService() {
        services = [
            Service(id: "1", name: "Detail", thumbnail: "image_01"),
            Service(id: "2", name: "Polimento", thumbnail: "image_02"),
            Service(id: "3", name: "Cristalização", thumbnail: "image_03"),
            Service(id: "4", name: "Lavagem", thumbnail: "image_04"),
            Service(id: "5", name: "Detail", thumbnail: "image_01"),
            Service(id: "6", name: "Polimento", thumbnail: "image_02"),
            Service(id: "7", name: "Cristalização", thumbnail: "image_03"),
            Service(id: "8", name: "Lavagem", thumbnail: "image_04"),
        ]
    }
    
    public func configure(with models: CategoryService) {
        titleCategoryLabel.text = models.title
        serviceByCategoryCollectionView.reloadData()
    }
    
    private func collectionLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
        return layout
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CustomTableViewCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubviews(titleCategoryLabel, serviceByCategoryCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleCategoryLabel.topAnchor.constraint(equalTo: topAnchor),
            titleCategoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleCategoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            serviceByCategoryCollectionView.topAnchor.constraint(equalTo: titleCategoryLabel.bottomAnchor),
            serviceByCategoryCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            serviceByCategoryCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            serviceByCategoryCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
       
    }
    
    
}

extension CustomTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return services.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = services[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.safeAreaLayoutGuide.layoutFrame.width), height: (self.safeAreaLayoutGuide.layoutFrame.height - 50))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("Cliquei")
    }
    
    
}
