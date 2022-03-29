//
//  SignUpView.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 29/03/22.
//

import UIKit

class SignUpView: UIView {
    
    private var safeArea: UILayoutGuide!
    
    lazy private var logoImage: UIImageView = {
        let image = CustomLogoImageView(frame: .zero)
        image.image = UIImage(named: "logo_wash")
        return image
    }()
    
    lazy private var infoCadLabel: UILabel = {
        let label = CustomLabel()
        label.text = "Preencha as informações para criar uma conta e clique em continuar"
        label.numberOfLines = 2
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.50)
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    lazy private var containerStack: UIStackView = {
        let stack = CustomVerticalStack()
        return stack
    }()
    
    lazy private var fullNameTextField: UITextField = {
        let text = CustomTexField()
        text.autocapitalizationType = .words
        text.placeholder = "Seu nome completo"
        text.autocorrectionType = .no
        return text
    }()
    
    lazy private var emailTextField: UITextField = {
        let email = CustomTexField()
        email.autocapitalizationType = .none
        email.autocorrectionType = .no
        email.keyboardType = .emailAddress
        email.placeholder = "E-mail"
        return email
    }()
    
    lazy private var passwordTextField: UITextField = {
        let input = CustomTexField()
        input.placeholder = "Senha"
        input.autocapitalizationType = .none
        //input.isSecureTextEntry = true
        input.autocorrectionType = .no
        input.addTarget(self, action: #selector(hiddenLogo), for: .editingDidBegin)
        return input
    }()
    
    @objc func hiddenLogo() {
        logoImage.isHidden = true
    }
    
    lazy var signUpButton: UIButton = {
        let button = ConfirmButton()
        button.setTitle("Continue", for: .normal)
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        safeArea = layoutMarginsGuide
        setupView()
        delegates()
        self.setupKeyboardHiding()
    }
    
    private func delegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SignUpView: CodeView {
    func buildViewHierarchy() {
        self.addSubviews(logoImage, infoCadLabel, containerStack, signUpButton)
        containerStack.addArrangedSubviews(fullNameTextField, emailTextField, passwordTextField)
    }
    
    func setupConstraints() {
        //Image logo
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: safeArea.topAnchor),
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        //Title
        NSLayoutConstraint.activate([
            infoCadLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor),
            infoCadLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            infoCadLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        //StackView
        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: infoCadLabel.bottomAnchor, constant: 20),
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
        
    }
}

extension SignUpView: UITextViewDelegate, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        logoImage.isHidden = false
        self.endEditing(true)
    }
}

