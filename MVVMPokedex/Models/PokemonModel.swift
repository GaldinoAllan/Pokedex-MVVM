//
//  PokemonModel.swift
//  MVVMPokedex
//
//  Created by allan.galdino on 09/05/21.
//

import Foundation

struct PokemonModel {
  let id: Int
  let name: String
  let urlImage: String
}

extension PokemonModel {
  init() {
    self.id = 0
    self.name = ""
    self.urlImage = ""
  }
}
