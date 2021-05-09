//
//  ParsePokedex.swift
//  MVVMPokedex
//
//  Created by allan.galdino on 09/05/21.
//

import Foundation

typealias ParseResponseDict = [String: Any]?
typealias PokemonSpriteDict = [String: Any]

class ParsePokedex {
  func parseAllPokedex(response: ParseResponseDict) -> PokedexModel {
    
    // unwrap do dicionario enviado pelo request, caso for nulo chama a função de init para criar model vazio
    guard let response = response else {
      return PokedexModel()
    }
    
    // colocando o valor retornado em suas devidas variáveis
    let count = response["count"] as? Int ?? 0
    let next = response["next"] as? String ?? ""
    let previous = response["previous"] as? String ?? ""
    let resultList = response["results"] as? [[String: Any]] ?? []
    
    let results = resultList.count
    
    return PokedexModel(count: count, next: next, previous: previous, results: results)
  }
  
  func parsePokemon(response: ParseResponseDict) -> PokemonModel {
    guard let response = response else {
      return PokemonModel()
    }
    
    let name = response["name"] as? String ?? ""
    let id = response["id"] as? Int ?? 0
    let sprites = response["sprites"] as? PokemonSpriteDict
    let urlImage = sprites?["front_default"] as? String ?? ""
    
    return PokemonModel(id: id, name: name, urlImage: urlImage)
  }
}
