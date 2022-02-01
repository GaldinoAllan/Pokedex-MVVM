//
//  PokedexCell.swift
//  MVVMPokedex
//
//  Created by Allan Gazola Galdino on 31/01/22.
//

import UIKit

class PokedexCell: UITableViewCell {

    // MARK: - Views

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
            pokemonNameLabel.text = pokemonName
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
        contentView.addSubview(pokemonImage)
        contentView.addSubview(pokemonNameLabel)
    }

    private func setUpConstraints() {
        setUpContactImageConstraints()
        setUpFullNameLabelConstraints()
    }

    private func setUpContactImageConstraints() {
        NSLayoutConstraint.activate([
            pokemonImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            pokemonImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            pokemonImage.heightAnchor.constraint(equalToConstant: 100),
            pokemonImage.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setUpFullNameLabelConstraints() {
        NSLayoutConstraint.activate([
            pokemonNameLabel.leadingAnchor.constraint(equalTo: pokemonImage.trailingAnchor,
                                                   constant: 16),
            pokemonNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -15),
            pokemonNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            pokemonNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
