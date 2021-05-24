//
//  CodeView.swift
//  MVVMPokedex
//
//  Created by allan galdino on 22/05/21.
//

import Foundation
import SnapKit

protocol CodeView {
    func buildViewHierrarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension CodeView {
    func setupView() {
        buildViewHierrarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
