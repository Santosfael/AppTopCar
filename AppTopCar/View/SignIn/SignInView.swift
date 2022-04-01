//
//  SigInView.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 22/03/22.
//

import Foundation
import UIKit
import TransitionButton

class SignInView: UIView {
    
    private var safeArea: UILayoutGuide!
    
    lazy private var logoImage: UIImageView = {
        let image = CustomLogoImageView(frame: .zero)
        image.image = UIImage(named: "logo_wash")
        return image
    }()
    
    lazy private var loginLabel: UILabel = {
        let label = CustomLabel()
        label.text = "Login"
        label.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        return label
    }()
    
    lazy private var infoLabel: UILabel = {
        let label = CustomLabel()
        label.text = "Entre com o seu -email e senha para acessar sua conta"
        label.numberOfLines = 2
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.50)
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    lazy private var gridContainer: UIStackView = {
        let view = CustomVerticalStack(frame: .zero)
        return view
    }()
    
    lazy private var emailTextField: UITextField = {
        let input = CustomTexField()
        input.placeholder = "E-mail"
        input.autocorrectionType = .no
        input.autocapitalizationType = .none
        input.keyboardType = .emailAddress
        input.addTarget(self, action: #selector(handleEmailTextChange), for: .editingChanged)
        return input
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
        input.autocapitalizationType = .none
        input.isSecureTextEntry = true
        input.autocapitalizationType = .none
        input.autocorrectionType = .no
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
    
    lazy private var forgotButton: UIButton = {
        let button = CustomButton()
        button.setTitle("Esqueceu a senha?", for: .normal)
        button.setTitleColor(UIColor(red: 0.00, green: 0.48, blue: 1.00, alpha: 1.00), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.addTarget(self, action: #selector(forgotHandlerButton), for: .touchUpInside)
        return button
    }()
    
    
    lazy private var signInButton: TransitionButton = {
        let button = TransactionCustomButton()
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginButton), for: .touchUpInside)
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    lazy var containerSignUpStack: UIStackView = {
        let stack = CustomHorizontalStackView(frame: .zero)
        return stack
    }()
    
    lazy private var signUpLabel: UILabel = {
        let label = CustomLabel()
        label.text = "Não tem uma conta?"
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.51)
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    lazy private var signUpButton: UIButton = {
        let button = CustomButton()
        button.setTitle("Cadastre-se", for: .normal)
        button.setTitleColor(UIColor(red: 0.00, green: 0.48, blue: 1.00, alpha: 1.00), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.addTarget(self, action: #selector(signUpHandlerButton), for: .touchUpInside)
        return button
    }()
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.frame.origin.y = keyboardShow.shared.keyboardWillShow(sender: sender)
    }
    
    @objc func hiddenLogo() {
        logoImage.isHidden = true
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.frame.origin.y = keyboardShow.shared.keyboardWillHide(notification: notification)
    }
    
    //Essa variavel é chamada na SignIn controller e recebe a navegação da pagina
    var handlerHomeButton: (() -> Void)?
    
    var handlerForgotButton: (() -> Void)?
    
    var handlerSignUpButton: (() -> Void)?
    
    @IBAction private func loginButton() {
        signInButton.startAnimation()
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let user = User(id: "", fullname: "", email: email, password: password)
        UserService.shared.signIn(user: user) { result in
            switch result {
            case .success(let user):
                UserDefaults.standard.set(user.email, forKey: "keyUserEmail")
                UserDefaults.standard.set(user.fullname, forKey: "keyUserName")
                
                DispatchQueue.main.async {
                    self.signInButton.stopAnimation()
                    self.handlerHomeButton?()
                }
                
            case .failure(_):
                DispatchQueue.main.async {
                    self.signInButton.stopAnimation(animationStyle: .normal, revertAfterDelay: 2) {
                        self.alertInfo(title: "Login", message: "E-mail não cadastrado, ou e-mail e senha incorreto")
                        self.signInButton.cornerRadius = 8
                    }
                }
                
            }
        }
    }
    
    @IBAction private func forgotHandlerButton() {
        handlerForgotButton?()
    }
    
    @IBAction private func signUpHandlerButton() {
        handlerSignUpButton?()
    }
    
    @objc private func handleEmailTextChange() {
        signInButton.isEnabled = shouldEnabledButton()
        guard let text = emailTextField.text else { return }
        if text.isValid(.email) {
            
            emailTextField.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
            errorEmailLabel.isHidden = true
        } else {
            emailTextField.backgroundColor = UIColor(red: 0.72, green: 0.00, blue: 0.00, alpha: 0.2)
            errorEmailLabel.isHidden = false
            signInButton.isEnabled = shouldEnabledButton()
            signInButton.alpha = 0.5
        }
        
        if signInButton.isEnabled {
            signInButton.alpha = 1
        } else {
            signInButton.alpha = 0.5
        }
        
    }
    
    @objc private func handlePasswordChange() {
        //signInButton.isEnabled = shouldEnabledButton()
        guard let text = passwordTextField.text else { return }
        if text.isValid(.password) {
            
            passwordTextField.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
            errorPasswordLabel.isHidden = true
            signInButton.isEnabled = shouldEnabledButton()
        } else {
            passwordTextField.backgroundColor = UIColor(red: 0.72, green: 0.00, blue: 0.00, alpha: 0.2)
            errorPasswordLabel.isHidden = false
            signInButton.isEnabled = false
            
            if text.count < 8 {
                errorPasswordLabel.text = "A senha tem que ter no minimo 8 Caracteres"
            } else {
                errorPasswordLabel.text = "A senha tem que ter letra maiuscula, minuscula e números"
            }
        }
        
        if signInButton.isEnabled {
            signInButton.alpha = 1
        } else {
            signInButton.alpha = 0.5
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        safeArea = self.layoutMarginsGuide
        self.setupKeyboardHiding()
        setupView()
        delegates()
    }
    
    private func shouldEnabledButton() -> Bool {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return false
        }
        return email.isEmpty || password.isEmpty ? false : true
    }
    
    //protocol para validação
    
    private func delegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init(coder) has not been implemented")
    }
    
}

extension SignInView: CodeView {
    func buildViewHierarchy() {
        self.addSubviews(logoImage, loginLabel, infoLabel, gridContainer, forgotButton, signInButton, containerSignUpStack)
        self.gridContainer.addArrangedSubviews(emailTextField, errorEmailLabel, passwordTextField, errorPasswordLabel)
        self.containerSignUpStack.addArrangedSubviews(signUpLabel, signUpButton)
        //self.addSubview(button)
    }
    
    func setupConstraints() {
        //ImageView
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
            logoImage.heightAnchor.constraint(equalToConstant: 200),
            logoImage.widthAnchor.constraint(equalToConstant: 200),
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        //Login Label
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 0),
            loginLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
        ])
        
        //info Label
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 10),
            infoLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        //Grid container
        NSLayoutConstraint.activate([
            gridContainer.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20),
            gridContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            gridContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
        
        //Forgot button
        NSLayoutConstraint.activate([
            forgotButton.topAnchor.constraint(equalTo: gridContainer.bottomAnchor, constant: 10),
            forgotButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
        ])
        
        //Login Button
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: forgotButton.bottomAnchor, constant: 20),
            signInButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            signInButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        // Container Sign Up
        NSLayoutConstraint.activate([
            //containerSignUpStack.topAnchor.constraint(equalTo: signInButton.bottomAnchor),
            containerSignUpStack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
            containerSignUpStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
        ])
        
        //SignUp Label
//        NSLayoutConstraint.activate([
//            signUpLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            signUpLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
//
//        ])
        
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .systemBackground
    }
}

extension SignInView: UITextViewDelegate, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        logoImage.isHidden = false
        self.endEditing(true)
    }
}
