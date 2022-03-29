//
//  ForgotViewController.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 28/03/22.
//

import UIKit

class ForgotViewController: UIViewController {
    
    lazy private var forgotView = ForgotView()
    
    override func loadView() {
        super.loadView()
        self.view = forgotView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Esqueci a senha"
        view.backgroundColor = .systemBackground
    }

}
