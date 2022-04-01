//
//  UserProtocol.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 31/03/22.
//

import Foundation

enum UserError: Error {
    case error(String)
    case urlInvalid
    case noDataAvailable
    case noProcessData
}

typealias completion = (Result<User, UserError>) -> Void

protocol UserServiceProtocol: AnyObject {
    func signIn(user: User, completion: @escaping completion)
    func signUp(user: User, completion: @escaping completion)
    func forgot(email: String, completion: @escaping completion)
    func logout()
}
