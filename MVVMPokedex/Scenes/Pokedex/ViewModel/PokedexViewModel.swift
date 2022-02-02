//
//  PokedexViewModel.swift
//  MVVMPokedex
//
//  Created by Allan Gazola Galdino on 31/01/22.
//

import Foundation

protocol PokedexViewModelDelegate: AnyObject {
    func pokedexDidLoad()
    func fetchFailed(withError errorInfo: (title: String, message: String))
}

class PokedexViewModel {

    // MARK: - Properties

    private let pokedexService: PokedexService
    private(set) var pokedex = Pokedex(count: 0, next: "", previous: "")
    private(set) var pokemonList = [Pokemon]()
    private var resultsCount = 0

    weak var delegate: PokedexViewModelDelegate?

    // MARK: - Initializer

    init(pokedexService: PokedexService = PokedexService()) {
        self.pokedexService = pokedexService
    }

    // MARK: - Contents

    func loadPokedex() {
        pokedexService.loadPokedex { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let pokedex):
                self.pokedex = pokedex
                self.onLoadPokedex()
            case .failure(let error):
                self.delegate?.fetchFailed(withError: (title: "Error loading pokedex",
                                                        message: error.localizedDescription))
            }
        }
    }

    private func onLoadPokedex() {
        resultsCount = pokedex.results.count
        pokedex.results.forEach { pokemon in
            loadPokemon(with: pokemon.url)
        }
    }

    private func loadPokemon(with url: String) {
        pokedexService.loadPokemon(with: url) { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let pokemon):
                self.onLoadPokemonSuccess(pokemon)
            case .failure(let error):
                self.delegate?.fetchFailed(withError: (title: "Error loading pokemon",
                                                        message: error.localizedDescription))
            }
        }
    }

    private func onLoadPokemonSuccess(_ pokemon: Pokemon) {
        pokemonList.append(pokemon)
        guard pokemonList.count == resultsCount else { return }
        pokemonList.sort { $0.id < $1.id }
        delegate?.pokedexDidLoad()
    }
}
