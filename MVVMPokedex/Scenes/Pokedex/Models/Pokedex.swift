//
//  Pokedex.swift
//  MVVMPokedex
//
//  Created by allan.galdino on 09/05/21.
//

struct Pokedex: Decodable, Equatable {
  let count: Int
  let next: String?
  let previous: String?
  let results: [PokemonName]
}

struct PokemonName: Decodable, Equatable {
    let name: String
    let url: String
}
