//
//  HomeTableView.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 08/04/22.
//

import UIKit

class ServicesTableView: UIView {

    lazy var servicesTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private var models = [Model]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        delegates()
        register()
    }
    
    private func delegates() {
        servicesTableView.delegate = self
        servicesTableView.dataSource = self
    }
    private func register() {
        servicesTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ServicesTableView: CodeView {
    func buildViewHierarchy() {
        self.addSubviews(servicesTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            servicesTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            servicesTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            servicesTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            servicesTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func setupAdditionalConfiguration() {
        
    }
}

extension ServicesTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

struct Model {
    let text: String
    let imageName: String
    
    init(text: String, imageName: String) {
        self.text = text
        self.imageName = imageName
    }
}
