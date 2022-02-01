//
//  SearchView.swift
//  MVVMPokedex
//
//  Created by allan galdino on 22/05/21.
//

import UIKit

final class SearchView: UIView {
    
    var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .red
        button.setTitle("Fetch", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        buildViewHierrarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildViewHierrarchy() {
        addSubview(button)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -112)
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .darkGray
    }
    
}
