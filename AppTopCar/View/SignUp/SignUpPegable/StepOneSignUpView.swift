//
//  SignUpView.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 29/03/22.
//

import UIKit
import TransitionButton

class StepOneSignUpView: UIView {
    
    private var safeArea: UILayoutGuide!
    
    lazy var titleCardLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "Crie uma conta gratuíta"
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    lazy private var subTitleCadLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "Preencha as informações para criar uma conta e clique em continuar"
        label.numberOfLines = 2
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    lazy private var infoCadLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "01. Quem é você?"
        label.numberOfLines = 2
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.90)
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    lazy private var containerStack: CustomVerticalStack = {
        let stack = CustomVerticalStack()
        return stack
    }()
    
    lazy private var fullNameTextField: CustomTexField = {
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
    
    lazy private var phoneTextField: UITextField = {
        let email = CustomTexField()
        email.keyboardType = .emailAddress
        email.addTarget(self, action: #selector(handlePhoneTextChange), for: .editingChanged)
        email.placeholder = "Celular"
        email.keyboardType = .phonePad
        return email
    }()
    
    lazy var errorPhoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.text = "Digite um celular válido"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .red
        return label
    }()
    
    lazy var signUpButton: TransitionButton = {
        let button = TransactionCustomButton()
        button.setTitle("Continue", for: .normal)
        //button.addTarget(self, action: #selector(handlerCreateUser), for: .touchUpInside)
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
    
    @objc private func handlePhoneTextChange() {
        guard let text = phoneTextField.text else { return }
        if text.isValid(.phone) {
            phoneTextField.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
            errorPhoneLabel.isHidden = true
        } else {
            phoneTextField.backgroundColor = UIColor(red: 0.72, green: 0.00, blue: 0.00, alpha: 0.2)
            errorPhoneLabel.isHidden = false
            signUpButton.isEnabled = shouldEnabledButton()
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
        let fullname = fullNameTextField.text!
        let phone = phoneTextField.text!
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
        guard let fullname = fullNameTextField.text, let phone = phoneTextField.text else {
            return false
        }
        return fullname.isEmpty || phone.isEmpty ? false : true
    }

    
    private func delegates() {
        fullNameTextField.delegate = self
        phoneTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension StepOneSignUpView: CodeView {
    func buildViewHierarchy() {
        self.addSubviews(titleCardLabel, subTitleCadLabel, infoCadLabel, containerStack, signUpButton)
        containerStack.addArrangedSubviews(fullNameTextField, errorFullNameLabel, phoneTextField, errorPhoneLabel)
    }
    
    func setupConstraints() {
        //Title
        NSLayoutConstraint.activate([
            titleCardLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50),
            titleCardLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            titleCardLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            subTitleCadLabel.topAnchor.constraint(equalTo: titleCardLabel.bottomAnchor, constant: 16),
            subTitleCadLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            subTitleCadLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20)
        ])
        
        //Title
        NSLayoutConstraint.activate([
            infoCadLabel.topAnchor.constraint(equalTo: subTitleCadLabel.bottomAnchor, constant: 50),
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
        self.backgroundColor = .systemBackground
    }
}

extension StepOneSignUpView: UITextViewDelegate, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}

