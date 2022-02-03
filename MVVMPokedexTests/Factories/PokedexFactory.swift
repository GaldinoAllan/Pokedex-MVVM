//
//  PokedexFactory.swift
//  MVVMPokedexTests
//
//  Created by Allan Gazola Galdino on 03/02/22.
//

import Foundation
@testable import MVVMPokedex

class PokedexFactory {
    static func createPokedexData() -> Data? {
        let pokedexData = """
    {
      "count": 20,
      "next": null,
      "previous": null,
      "results": [{"name": "bulbasaur", "url": "https://pokeapi.co/api/v2/pokemon/1/"}]
    }
    """

        return pokedexData.data(using: .utf8)
    }

    static func createUndecodablePokedexData() -> Data? {
        let pokedexData = "{ Undecodable Pokemon }"

        return pokedexData.data(using: .utf8)
    }

    static func createPokedex(withPokemonsCount count: Int) -> Pokedex {

        var resultsList = [Pokedex.PokemonName]()

        for _ in 0..<count {
            resultsList.append(Pokedex.PokemonName(name: "bulbasaur",
                                                   url: "https://pokeapi.co/api/v2/pokemon/1/"))
        }

        let pokedex = Pokedex(count: 20, next: nil, previous: nil, results: resultsList)

        return pokedex
    }
}
