//
//  PokedexServiceMock.swift
//  MVVMPokedexTests
//
//  Created by Allan Gazola Galdino on 03/02/22.
//

import Foundation
@testable import MVVMPokedex

class PokexedServiceMock: PokedexServiceProtocol {

    var pokedex: Pokedex?
    var pokemon: Pokemon?

    func loadPokedex(completionHandler: @escaping (Result<Pokedex, NetworkErrors>) -> Void) {
        guard let pokedex = pokedex else {
            completionHandler(.failure(.jsonDecoding(message: "no pokedex found")))
            return
        }

        completionHandler(.success(pokedex))
    }

    func loadPokemon(with pokemonUrl: String,
                     completionHandler: @escaping (Result<Pokemon, NetworkErrors>) -> Void) {
        guard let _ = URL(string: pokemonUrl) else {
            completionHandler(.failure(.invalidUrl))
            return
        }

        guard let pokemon = pokemon else {
            completionHandler(.failure(.jsonDecoding(message: "no pokemon found")))
            return
        }

        completionHandler(.success(pokemon))
    }


}
