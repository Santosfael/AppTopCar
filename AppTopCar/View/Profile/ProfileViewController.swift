//
//  ProfileViewController.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 08/04/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    lazy var logoutButton: ConfirmButton = {
        let button = ConfirmButton()
        button.setTitle("Sair", for: .normal)
        button.isEnabled = true
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        button.alpha = 1
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubviews(logoutButton)
        
        NSLayoutConstraint.activate([
            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @objc func logout() {
        UserService.shared.logout()
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }

}
