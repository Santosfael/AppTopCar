//
//  User.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 31/03/22.
//

import Foundation

struct User {
    let id: String
    let fullname: String
    let email: String
    let password: String
    let phone: [Phone]
    let address: [Address]
}

struct Phone {
    let id: String
    let number: String
}

struct Address {
    let id: String
    let street: String
    let houseOfNumber: Int
    let complement: String
    let district: String
    let city: String
    let country: String
    let zipcode: String
}
