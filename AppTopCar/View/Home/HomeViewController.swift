//
//  HomeViewController.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 22/03/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    private let servicesTableView = ServicesTableView()
    
    override func loadView() {
        super.loadView()
        super.view = servicesTableView
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

//   override func viewWillDisappear(_ animated: Bool) {
//       super.viewWillDisappear(true)
//       // Show the Navigation Bar
//       self.navigationController?.setNavigationBarHidden(false, animated: false)
//   }
}

