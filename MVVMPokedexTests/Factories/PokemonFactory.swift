//
//  PokemonFactory.swift
//  MVVMPokedexTests
//
//  Created by Allan Gazola Galdino on 03/02/22.
//

import Foundation
@testable import MVVMPokedex

class PokemonFactory {
    static func createPokemonData() -> Data? {
        let pokedexData = """
    {
      "id": 1,
      "name": "bulbasaur",
      "sprites": {
        "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
      }
    }
    """

        return pokedexData.data(using: .utf8)
    }

    static func createUndecodablePokemonData() -> Data? {
        let pokedexData = "{ Undecodable Pokemon }"

        return pokedexData.data(using: .utf8)
    }

    static func createPokemon() -> Pokemon {
        return Pokemon(id: 1,
                       name: "bulbasaur",
                       sprites: Pokemon.Sprite(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"))
    }
}
