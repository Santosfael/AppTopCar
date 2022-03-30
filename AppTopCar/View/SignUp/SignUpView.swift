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
        text.addTarget(self, action: #selector(handleFullNameTextChange), for: .editingChanged)
        return text
    }()
    
    lazy var errorFullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.text = "Digite seu nome completo"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .red
        return label
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
        //input.addTarget(self, action: #selector(hiddenLogo), for: .editingDidBegin)
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
    
    @objc func hiddenLogo() {
        logoImage.isHidden = true
    }
    
    lazy var signUpButton: UIButton = {
        let button = ConfirmButton()
        button.setTitle("Continue", for: .normal)
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
    
    @objc private func handleFullNameTextChange() {
        guard let text = fullNameTextField.text else { return }
        if text.isValid(.fullName) {
            
            fullNameTextField.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
            errorFullNameLabel.isHidden = true
        } else {
            fullNameTextField.backgroundColor = UIColor(red: 0.72, green: 0.00, blue: 0.00, alpha: 0.2)
            errorFullNameLabel.isHidden = false
            signUpButton.isEnabled = shouldEnabledButton()
        }
        
        if signUpButton.isEnabled {
            signUpButton.alpha = 1
        } else {
            signUpButton.alpha = 0.5
        }
        
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        safeArea = layoutMarginsGuide
        setupView()
        delegates()
        self.setupKeyboardHiding()
    }
    
    private func shouldEnabledButton() -> Bool {
        guard let fullname = fullNameTextField.text, let email = emailTextField.text, let password = passwordTextField.text else {
            return false
        }
        return fullname.isEmpty || email.isEmpty || password.isEmpty ? false : true
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
        containerStack.addArrangedSubviews(fullNameTextField, errorFullNameLabel, emailTextField, errorEmailLabel, passwordTextField, errorPasswordLabel)
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

