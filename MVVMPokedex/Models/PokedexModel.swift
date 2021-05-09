//
//  PokedexModel.swift
//  MVVMPokedex
//
//  Created by allan.galdino on 09/05/21.
//

import Foundation

struct PokedexModel {
  let count: Int
  let next: String
  let previous: String
  let results: Int
}

extension PokedexModel {
  init() {
    self.count = 0
    self.next = ""
    self.previous = ""
    self.results = 0
  }
}
