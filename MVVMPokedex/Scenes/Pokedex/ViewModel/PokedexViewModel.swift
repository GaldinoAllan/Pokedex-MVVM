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
    private let pokemonService: PokemonService
    private(set) var pokedex = Pokedex(count: 0, next: "", previous: "", results: [PokemonName]())
    private(set) var pokemonList = [Pokemon]()

    weak var delegate: PokedexViewModelDelegate?

    // MARK: - Initializer

    init(pokedexService: PokedexService = PokedexService(),
         pokemonService: PokemonService = PokemonService()) {
        self.pokedexService = pokedexService
        self.pokemonService = pokemonService
    }

    // MARK: - Contents

    func loadPokedex() {
        pokedexService.loadPokedex { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let pokedex):
                self.pokedex = pokedex
                self.delegate?.pokedexDidLoad()
            case .failure(let error):
                self.delegate?.fetchFailed(withError: (title: "Error loading pokedex",
                                                        message: error.localizedDescription))
            }
        }
    }

    func loadPokemon(with url: String) -> (name: String, imageUrl: String)? {
        var pokemonTuple: (name: String, imageUrl: String)?

        pokemonService.loadPokemon(with: url) { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let pokemon):
                pokemonTuple?.name = pokemon.name
                pokemonTuple?.imageUrl = pokemon.imageUrl ?? ""
                self.delegate?.pokedexDidLoad()
            case .failure(let error):
                self.delegate?.fetchFailed(withError: (title: "Error loading pokemon",
                                                       message: error.localizedDescription))
            }
        }

        return pokemonTuple
    }
    
    func selectPokemonFromList(at indexPath: IndexPath) -> (title: String, message: String) {
        let selectedPokemon = pokedex.results[indexPath.row]
        return (title: "Selected", message: selectedPokemon.name)
    }
}
