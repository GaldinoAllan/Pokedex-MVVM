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
    private(set) var pokedex = Pokedex(count: 0, next: "", previous: "", results: [PokemonName]())
//    private(set) var pokemonList = [Pokemon]()

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
                self.delegate?.pokedexDidLoad()
            case .failure(let error):
                self.delegate?.fetchFailed(withError: (title: "Error loading pokedex",
                                                        message: error.localizedDescription))
            }
        }
    }

    func loadPokemon(at indexPath: IndexPath) -> Pokemon? {
        let url = pokedex.results[indexPath.row].url
        var pokemonData: Pokemon?

        pokedexService.loadPokemon(with: url) { [weak self] (result) in
             switch result {
             case .success(let pokemon):
                 pokemonData = pokemon
             case .failure(let error):
                 self?.delegate?.fetchFailed(withError: (title: "Error loading pokemon",
                                                         message: error.localizedDescription))
             }
         }
        return pokemonData
    }
    
    func selectPokemonFromList(at indexPath: IndexPath) -> (title: String, message: String) {
        let selectedPokemon = pokedex.results[indexPath.row]
        return (title: "Selected", message: selectedPokemon.name)
    }
}
