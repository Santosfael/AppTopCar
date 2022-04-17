//
//  HomeViewController.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 22/03/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {

    private let serviceTableView = ServicesTableView()
    
    override func loadView() {
        super.loadView()
        self.view = serviceTableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        serviceTableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(true)
       // Hide the Navigation Bar
       self.navigationController?.setNavigationBarHidden(true, animated: true)
   }
}
