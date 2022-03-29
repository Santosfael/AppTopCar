//
//  HomeViewController.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 22/03/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    lazy var homeLabel: UILabel = {
        let label = CustomLabel()
        label.text = "Bem vindo"
        return label
    }()
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(homeLabel)
        
        NSLayoutConstraint.activate([
            homeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
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

