//
//  HomeTableView.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 08/04/22.
//

import UIKit

class ServicesTableView: UIView {

    lazy var servicesTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private var categoryService = [CategoryService]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        categoryService = [CategoryService(id: "1", title: "Lavagens"),
                           CategoryService(id: "2", title: "Details"),
                           CategoryService(id: "3", title: "Higienização"),
                           CategoryService(id: "4", title: "Polimento")]
        register()
        delegates()
        setupView()
        
    }
    
    override func layoutSubviews() {
        servicesTableView.frame = self.bounds
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
            servicesTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            servicesTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            servicesTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func setupAdditionalConfiguration() {
        
    }
}

extension ServicesTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryService.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = servicesTableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        cell.configure(with: categoryService[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
}
