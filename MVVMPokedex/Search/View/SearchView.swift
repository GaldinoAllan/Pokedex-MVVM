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
        // SnapKit lets me desable the next line
//        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    private lazy var gridContainer: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        return stackView
    }()
    
    let leftGridBox = GridBoxView()
    let rightGridBox = GridBoxView()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SearchView: CodeView {
    func buildViewHierrarchy() {
        addSubview(button)
        gridContainer.addArrangedSubview(leftGridBox)
        gridContainer.addArrangedSubview(rightGridBox)
        addSubview(gridContainer)
    }
    
    func setupConstraints() {
        // without SnapKit
//        NSLayoutConstraint.activate([
//            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            button.heightAnchor.constraint(equalToConstant: 50),
//            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -112)
//        ])
        
        // with SnapKit
        button.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(112)
        }
        
        gridContainer.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(200)
            make.centerY.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .darkGray
    }
}
