//
//  CodeView.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 22/03/22.
//

import Foundation
import SnapKit

protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    
    func setupView()
}

extension CodeView {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
