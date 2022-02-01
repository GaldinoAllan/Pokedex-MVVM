//
//  PokeAPI.swift
//  MVVMPokedex
//
//  Created by Allan Gazola Galdino on 31/01/22.
//

import Foundation

class PokeAPI {
    static let url = "https://pokeapi.co/api/v2/pokemon?limit=151"

    static func getPokemonImageUrl(for id: Int) -> String {
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
}
