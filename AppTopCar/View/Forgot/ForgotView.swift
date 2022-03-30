//
//  ForgotView.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 28/03/22.
//

import UIKit

class ForgotView: UIView {
    
    private var safeArea: UILayoutGuide!
    
    lazy private var logoImage: UIImageView = {
        let image = CustomLogoImageView(frame: .zero)
        image.image = UIImage(named: "logo_wash")
        return image
    }()
    
    lazy var inforForgotLabel: UILabel = {
        let label = CustomLabel()
        label.text = "Para recuperar sua senha, digite o seu e-mail abaixo e clique em recuperar"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 2
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.50)
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let email = CustomTexField()
        email.placeholder = "E-mail"
        email.keyboardType = .emailAddress
        email.addTarget(self, action: #selector(handleEmailTextChange), for: .editingChanged)
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
    
    lazy var forgotButton: UIButton = {
        let button = ConfirmButton()
        button.setTitle("Recuperar", for: .normal)
        return button
    }()
    
    @objc private func handleEmailTextChange() {
        forgotButton.isEnabled = shouldEnabledButton()
        guard let text = emailTextField.text else { return }
        if text.isValid(.email) {
            
            emailTextField.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
            errorEmailLabel.isHidden = true
        } else {
            emailTextField.backgroundColor = UIColor(red: 0.72, green: 0.00, blue: 0.00, alpha: 0.2)
            errorEmailLabel.isHidden = false
            forgotButton.isEnabled = false
        }
        
        if forgotButton.isEnabled {
            forgotButton.alpha = 1
        } else {
            forgotButton.alpha = 0.5
        }
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        safeArea = layoutMarginsGuide
        setupView()
        delegates()
    }
    
    private func shouldEnabledButton() -> Bool {
        guard let email = emailTextField.text else {
            return false
        }
        return email.isEmpty ? false : true
    }
    
    private func delegates() {
        emailTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ForgotView: CodeView {
    func buildViewHierarchy() {
        self.addSubviews(logoImage, inforForgotLabel, emailTextField, errorEmailLabel, forgotButton)
    }
    
    func setupConstraints() {
        //Image Logo
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: safeArea.topAnchor),
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        //Label Infor
        NSLayoutConstraint.activate([
            inforForgotLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor),
            inforForgotLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            inforForgotLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        //E-mail TextField
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: inforForgotLabel.bottomAnchor, constant: 30),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            errorEmailLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 5),
            errorEmailLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16)
        ])
        
        //Forgot Button
        NSLayoutConstraint.activate([
            forgotButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            forgotButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            forgotButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
    }
    
    func setupAdditionalConfiguration() {
        
    }
}

extension ForgotView: UITextViewDelegate, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}
