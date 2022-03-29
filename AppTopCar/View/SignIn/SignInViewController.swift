//
//  ViewController.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 22/03/22.
//

import UIKit

class SignInViewController: UIViewController {
    
    lazy var signInView = SignInView()
    
    override func loadView() {
        self.view = signInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handlerScreensSignIn()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
    }
    
    private func handlerScreensSignIn() {
        signInView.handlerHomeButton = {
            let homeController = HomeViewController()
            self.navigationController?.pushViewController(homeController, animated: true)
        }
        
        signInView.handlerForgotButton = {
            let forgotController = ForgotViewController()
            self.navigationController?.pushViewController(forgotController, animated: true)
        }
        
        signInView.handlerSignUpButton = {
            let signUpController = SignUpViewController()
            self.navigationController?.pushViewController(signUpController, animated: true)
        }
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

