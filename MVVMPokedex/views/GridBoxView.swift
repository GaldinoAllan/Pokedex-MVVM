//
//  GridBoxView.swift
//  MVVMPokedex
//
//  Created by allan galdino on 23/05/21.
//

import UIKit

final class GridBoxView: UIView {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .green
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    lazy var textContainer: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        return stackView
    }()
    
    lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .orange
        label.text = "titulo muito legal"
        return label
    }()
    
    lazy var subtitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .red
        label.text = "subtitulo muito legal"
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GridBoxView: CodeView {
    func buildViewHierrarchy() {
        addSubview(imageView)
        textContainer.addArrangedSubview(title)
        textContainer.addArrangedSubview(subtitle)
        addSubview(textContainer)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        textContainer.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(16)
        }
    }
    
    func setupAdditionalConfiguration() {
        
    }
}

