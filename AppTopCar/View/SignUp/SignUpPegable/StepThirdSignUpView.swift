//
//  StepThirdSignUpView.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 18/04/22.
//

import UIKit
import TransitionButton

class StepThirdSignUpView: UIView {
    
    private var safeArea: UILayoutGuide!
    
    lazy private var infoCadLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "03. Endereço"
        label.numberOfLines = 2
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.90)
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    lazy private var containerStack: CustomVerticalStack = {
        let stack = CustomVerticalStack()
        return stack
    }()
    
    lazy private var streetTextField: CustomTexField = {
        let text = CustomTexField()
        text.autocapitalizationType = .words
        text.placeholder = "Rua/ Avenida"
        text.addTarget(self, action: #selector(handleStreetTextChange), for: .editingChanged)
        return text
    }()
    
    lazy var errorStreetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.text = "Digite o nome rua ou avenida"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .red
        return label
    }()
    
    lazy private var districtTextField: UITextField = {
        let text = CustomTexField()
        text.autocapitalizationType = .words
        text.addTarget(self, action: #selector(handleDistrictTextChange), for: .editingChanged)
        text.placeholder = "Bairro"
        return text
    }()
    
    lazy var errorDistrictLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.text = "Digite um bairro"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .red
        return label
    }()
    
    lazy private var cityTextField: UITextField = {
        let text = CustomTexField()
        text.autocapitalizationType = .words
        text.addTarget(self, action: #selector(handleCityTextChange), for: .editingChanged)
        text.placeholder = "Nome da cidade"
        return text
    }()
    
    lazy var errorCityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.text = "Digite o nome da cidade"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .red
        return label
    }()
    
    lazy private var complementTextField: UITextField = {
        let text = CustomTexField()
        text.autocapitalizationType = .words
        text.placeholder = "Complemento, Exemplo: Casa fundo/AP."
        return text
    }()
    
    lazy private var zipCodeTextField: UITextField = {
        let text = CustomTexField()
        text.autocapitalizationType = .words
        text.keyboardType = .numberPad
        text.addTarget(self, action: #selector(handleZipCodeTextChange), for: .editingChanged)
        text.placeholder = "CEP"
        return text
    }()
    
    lazy var errorZipCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.text = "Digite um CEP válido"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .red
        return label
    }()
    
    lazy var signUpButton: TransitionButton = {
        let button = TransactionCustomButton()
        button.setTitle("Finalizar", for: .normal)
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
    
    @objc private func handleStreetTextChange() {
        guard let text = streetTextField.text else { return }
        if !text.isEmpty {
            
            streetTextField.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
            errorStreetLabel.isHidden = true
            signUpButton.isEnabled = shouldEnabledButton()
        } else {
            streetTextField.backgroundColor = UIColor(red: 0.72, green: 0.00, blue: 0.00, alpha: 0.2)
            errorStreetLabel.isHidden = false
            signUpButton.isEnabled = shouldEnabledButton()
        }
        
        if signUpButton.isEnabled {
            signUpButton.alpha = 1
        } else {
            signUpButton.alpha = 0.5
        }
        
    }
    
    @objc private func handleDistrictTextChange() {
        guard let text = districtTextField.text else { return }
        if text.isValid(.zipCode) {
            districtTextField.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
            errorDistrictLabel.isHidden = true
            signUpButton.isEnabled = shouldEnabledButton()
        } else {
            districtTextField.backgroundColor = UIColor(red: 0.72, green: 0.00, blue: 0.00, alpha: 0.2)
            errorDistrictLabel.isHidden = false
            signUpButton.isEnabled = shouldEnabledButton()
        }
        
        if signUpButton.isEnabled {
            signUpButton.alpha = 1
        } else {
            signUpButton.alpha = 0.5
        }
    }
    
    @objc private func handleCityTextChange() {
        guard let text = districtTextField.text else { return }
        if !text.isEmpty {
            cityTextField.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
            errorCityLabel.isHidden = true
            signUpButton.isEnabled = shouldEnabledButton()
        } else {
            cityTextField.backgroundColor = UIColor(red: 0.72, green: 0.00, blue: 0.00, alpha: 0.2)
            errorCityLabel.isHidden = false
            signUpButton.isEnabled = shouldEnabledButton()
        }
        
        if signUpButton.isEnabled {
            signUpButton.alpha = 1
        } else {
            signUpButton.alpha = 0.5
        }
    }
    
    @objc private func handleZipCodeTextChange() {
        guard let text = districtTextField.text else { return }
        if !text.isEmpty {
            cityTextField.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
            errorCityLabel.isHidden = true
            signUpButton.isEnabled = shouldEnabledButton()
        } else {
            cityTextField.backgroundColor = UIColor(red: 0.72, green: 0.00, blue: 0.00, alpha: 0.2)
            errorCityLabel.isHidden = false
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
        let fullname = streetTextField.text!
        let phone = districtTextField.text!
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
        guard let street = streetTextField.text,
                let district = districtTextField.text,
                let city = cityTextField.text,
                let zipCode = zipCodeTextField.text else {
            return false
        }
        return street.isEmpty || district.isEmpty || city.isEmpty || zipCode.isEmpty ? false : true
    }

    
    private func delegates() {
        streetTextField.delegate = self
        districtTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension StepThirdSignUpView: CodeView {
    func buildViewHierarchy() {
        self.addSubviews(infoCadLabel, containerStack, signUpButton)
        containerStack.addArrangedSubviews(streetTextField,
                                           errorStreetLabel,
                                           districtTextField,
                                           errorDistrictLabel,
                                           cityTextField,
                                           errorCityLabel,
                                           complementTextField,
                                           zipCodeTextField,
                                           errorZipCodeLabel
        )
    }
    
    func setupConstraints() {
        
        //Title
        NSLayoutConstraint.activate([
            infoCadLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50),
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

extension StepThirdSignUpView: UITextViewDelegate, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}
