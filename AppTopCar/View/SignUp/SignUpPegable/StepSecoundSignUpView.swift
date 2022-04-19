//
//  StepSecoundSignUpView.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 18/04/22.
//

import UIKit

import UIKit
import TransitionButton

class StepSecoundSignUpView: UIView {
    
    private var safeArea: UILayoutGuide!
    
    lazy private var infoCadLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "02. E-mail e Senha"
        label.numberOfLines = 2
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.90)
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    lazy private var containerStack: CustomVerticalStack = {
        let stack = CustomVerticalStack()
        return stack
    }()
    
    lazy private var emailTextField: UITextField = {
        let email = CustomTexField()
        email.keyboardType = .emailAddress
        email.addTarget(self, action: #selector(handleEmailTextChange), for: .editingChanged)
        email.placeholder = "E-mail"
        return email
    }()
    
    lazy var errorEmailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.text = "Digite um e-mail válido"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .red
        return label
    }()
    
    lazy private var passwordTextField: UITextField = {
        let input = CustomTexField()
        input.placeholder = "Senha"
        input.isSecureTextEntry = true
        input.addTarget(self, action: #selector(handlePasswordChange), for: .editingChanged)
        return input
    }()
    
    lazy var errorPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .red
        return label
    }()
    
    lazy var signUpButton: TransitionButton = {
        let button = TransactionCustomButton()
        button.setTitle("Continue", for: .normal)
        button.addTarget(self, action: #selector(handlerCreateUser), for: .touchUpInside)
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.frame.origin.y = keyboardShow.shared.keyboardWillShow(sender: sender)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.frame.origin.y = keyboardShow.shared.keyboardWillHide(notification: notification)
    }
    
    @objc private func handleEmailTextChange() {
        signUpButton.isEnabled = shouldEnabledButton()
        guard let text = emailTextField.text else { return }
        if text.isValid(.email) {
            
            emailTextField.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
            errorEmailLabel.isHidden = true
        } else {
            emailTextField.backgroundColor = UIColor(red: 0.72, green: 0.00, blue: 0.00, alpha: 0.2)
            errorEmailLabel.isHidden = false
            signUpButton.isEnabled = shouldEnabledButton()
            signUpButton.alpha = 0.5
        }
        
        if signUpButton.isEnabled {
            signUpButton.alpha = 1
        } else {
            signUpButton.alpha = 0.5
        }
        
    }
    
    @objc private func handlePasswordChange() {
        signUpButton.isEnabled = shouldEnabledButton()
        guard let text = passwordTextField.text else { return }
        if text.isValid(.password) {
            
            passwordTextField.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
            errorPasswordLabel.isHidden = true
        } else {
            passwordTextField.backgroundColor = UIColor(red: 0.72, green: 0.00, blue: 0.00, alpha: 0.2)
            errorPasswordLabel.isHidden = false
            signUpButton.isEnabled = false
            
            if text.count < 8 {
                errorPasswordLabel.text = "A senha tem que ter no minimo 8 Caracteres"
            } else {
                errorPasswordLabel.text = "A senha tem que ter letra maiuscula, minuscula e números"
            }
        }
        
        if signUpButton.isEnabled {
            signUpButton.alpha = 1
        } else {
            signUpButton.alpha = 0.5
        }
        
    }
    
    var handlerSignUpButton: (() -> Void)?
    
    @objc func handlerCreateUser() {
        signUpButton.startAnimation()
        let email = emailTextField.text!
        let password = passwordTextField.text!
        //let user = User(id: "", fullname: fullname, email: email, password: password)
        
//        UserService.shared.signUp(user: user) { result in
//            switch result {
//            case .success(let user):
//                UserDefaults.standard.set(user.email, forKey: "keyUserEmail")
//                UserDefaults.standard.set(user.fullname, forKey: "keyUserName")
//
//                DispatchQueue.main.async {
//                    self.signUpButton.stopAnimation()
//                    self.handlerSignUpButton?()
//                }
//
//            case .failure(_):
//                DispatchQueue.main.async {
//                    self.signUpButton.stopAnimation(animationStyle: .normal, revertAfterDelay: 2) {
//                        self.alertInfo(title: "Cadastrar", message: "Você não está conectado a internet")
//                        self.signUpButton.cornerRadius = 8
//                    }
//                }
//            }
//        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        safeArea = layoutMarginsGuide
        setupView()
        delegates()
        self.setupKeyboardHiding()
    }
    
    private func shouldEnabledButton() -> Bool {
        guard  let email = emailTextField.text, let password = passwordTextField.text else {
            return false
        }
        return email.isEmpty || password.isEmpty ? false : true
    }

    
    private func delegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension StepSecoundSignUpView: CodeView {
    func buildViewHierarchy() {
        self.addSubviews(infoCadLabel, containerStack, signUpButton)
        containerStack.addArrangedSubviews(emailTextField, errorEmailLabel, passwordTextField, errorPasswordLabel)
    }
    
    func setupConstraints() {
        
        //Title
        NSLayoutConstraint.activate([
            infoCadLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 70),
            infoCadLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            infoCadLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        //StackView
        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: infoCadLabel.bottomAnchor, constant: 30),
            containerStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        //Button Sign Up
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: containerStack.bottomAnchor, constant: 50),
            signUpButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            signUpButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .systemBackground
    }
}

extension StepSecoundSignUpView: UITextViewDelegate, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}
