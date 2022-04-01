//
//  HTTPMethod.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 31/03/22.
//

import Foundation

enum HTTPMethod: String {
    case post
    case put
    case `get`
    case delete
    case path
    
    public var name: String {
        return rawValue.uppercased()
    }
}
