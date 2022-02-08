//
//  PokemonViewController.swift
//  MVVMPokedex
//
//  Created by Allan Gazola Galdino on 01/02/22.
//

import UIKit

class PokemonViewController: UIViewController {

    private let pokemonName: String

    init(pokemonName: String) {
        self.pokemonName = pokemonName
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .red
        title = pokemonName.capitalized
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
