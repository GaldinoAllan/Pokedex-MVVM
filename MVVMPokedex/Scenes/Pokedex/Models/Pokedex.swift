//
//  Pokedex.swift
//  MVVMPokedex
//
//  Created by allan.galdino on 09/05/21.
//

struct Pokedex: Codable, Equatable {
    let count: Int
    let next: String?
    let previous: String?
    var results = [PokemonName]()

    struct PokemonName: Codable, Equatable {
        let name: String
        let url: String
    }
}
