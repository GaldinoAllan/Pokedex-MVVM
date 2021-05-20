//
//  PokedexResponses.swift
//  MVVMPokedex
//
//  Created by allan.galdino on 09/05/21.
//

import Foundation

enum PokedexResponse {
  case success(model: PokedexModel)
  case serverError(description: ServerError)
  case timeOut(description: ServerError)
  case noConnection(description: ServerError)
}

enum PokemonResponse {
  case success(model: PokemonModel)
  case serverError(description: ServerError)
  case timeOut(description: ServerError)
  case noConnection(description: ServerError)
}

enum ImageResponse {
  case success(model: Data)
  case serverError(description: ServerError)
  case timeOut(description: ServerError)
  case noConnection(description: ServerError)
}
