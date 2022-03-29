//
//  SignUpViewController.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 28/03/22.
//

import UIKit

class SignUpViewController: UIViewController {

    private let signUp = SignUpView()
    
    override func loadView() {
        super.loadView()
        title = "Cadastrar-se"
        self.view = signUp
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

}