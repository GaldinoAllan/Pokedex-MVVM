//
//  PokedexCell.swift
//  MVVMPokedex
//
//  Created by Allan Gazola Galdino on 31/01/22.
//

import UIKit

class PokedexCell: UITableViewCell {

    // MARK: - Views

    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 16
        return view
    }()

    private lazy var pokemonImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()

    private lazy var pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Properties

    var pokemonName: String? {
        didSet {
            pokemonNameLabel.text = pokemonName?.capitalized
        }
    }

    var imageUrl: String? {
        didSet {
            pokemonImage.setImageUrl(with: imageUrl)
        }
    }

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    // MARK: - Lifecycle methods

    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonName = nil
        imageUrl = nil
    }

    // MARK: - Set Up methods

    private func setUp() {
        setUpSubViews()
        setUpConstraints()
    }

    private func setUpSubViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(pokemonImage)
        containerView.addSubview(pokemonNameLabel)
    }

    private func setUpConstraints() {
        setUpContainerViewConstraints()
        setUpContactImageConstraints()
        setUpFullNameLabelConstraints()
    }

    private func setUpContainerViewConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: 16),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                               constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    private func setUpContactImageConstraints() {
        NSLayoutConstraint.activate([
            pokemonImage.heightAnchor.constraint(equalToConstant: 100),
            pokemonImage.widthAnchor.constraint(equalToConstant: 100),
            pokemonImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            pokemonImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            pokemonImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)

        ])
    }

    private func setUpFullNameLabelConstraints() {
        NSLayoutConstraint.activate([
            pokemonNameLabel.leadingAnchor.constraint(equalTo: pokemonImage.trailingAnchor,
                                                   constant: 16),
            pokemonNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                    constant: -15),
            pokemonNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            pokemonNameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
