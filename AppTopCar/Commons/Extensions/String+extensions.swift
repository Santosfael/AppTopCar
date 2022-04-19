//
//  String+extensions.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 30/03/22.
//

import Foundation

extension String {
    enum ValidityType {
        case fullName
        case phone
        case email
        case password
        case zipCode
    }
    
    enum Regex: String {
        case fullName = "^[a-zA-Z]{4,}(?: [a-zA-Z]+){1,5}$"
        case phone = "^(\\d{2}|\\d{0})[-. ]?(\\d{5}|\\d{4})[-. ]?(\\d{4})[-. ]?$"
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case password = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        case zipCode = "/^\\d{5}-?\\d{3}$/"
    }
    
    func isValid(_ validityTpe: ValidityType) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validityTpe {
        case .fullName:
            regex = Regex.fullName.rawValue
        case .phone:
            regex = Regex.phone.rawValue
        case .email:
            regex = Regex.email.rawValue
        case .password:
            regex = Regex.password.rawValue
        case .zipCode:
            regex = Regex.zipCode.rawValue
        }
        //print(NSPredicate(format: format, regex).evaluate(with: self))
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}
