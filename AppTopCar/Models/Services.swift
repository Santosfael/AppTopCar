//
//  Services.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 17/04/22.
//

import Foundation
enum CategoryServiceEnum {
    case detail(model: [Service]) /// Detail
    case washing(model: [Service]) /// Lavagens
    case sanitation(model: [Service]) /// Higienização
    case polishes(model: [Service]) /// Polimento
}

struct Service {
    let id: String
    let name: String
    let thumbnail: String
}
