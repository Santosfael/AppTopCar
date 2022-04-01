//
//  HomeViewController.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 22/03/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    lazy var userName: UILabel = {
        let label = CustomLabel()
        return label
    }()
    
    lazy var button: UIButton = {
        let label = ConfirmButton()
        label.setTitle("Logout", for: .normal)
        label.isEnabled = true
        label.alpha = 1
        label.addTarget(self, action: #selector(logout), for: .touchUpInside)
        return label
    }()
    
    override func loadView() {
        super.loadView()
        
        //userName.text = UserDefaults.standard.value(forKey: "userFullname") as! String
        
        view.addSubview(button)
        view.addSubview(userName)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            userName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
        ])
    }
    
    @objc func logout() {
        UserService.shared.logout()
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(true)
       // Hide the Navigation Bar
       self.navigationController?.setNavigationBarHidden(true, animated: true)
   }

   override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(true)
       // Show the Navigation Bar
       self.navigationController?.setNavigationBarHidden(false, animated: false)
   }
}

