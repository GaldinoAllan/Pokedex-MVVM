//
//  RequestPokedex.swift
//  MVVMPokedex
//
//  Created by allan.galdino on 09/05/21.
//

import Foundation
import Alamofire

struct PokemonAPIURL {
  static let baseUrl: String = "http://pokeapi.co/api/v2/pokemon/"
}

class RequestPokedex {
  let alamofireManager: SessionManager = {
    // criando configuracoes
    let configuration = URLSessionConfiguration.default
    // tempo de timeout em milissegundos
    configuration.timeoutIntervalForRequest = 10000
    configuration.timeoutIntervalForResource = 10000
    return SessionManager(configuration: configuration)
  }()
  
  let parse = ParsePokedex()
  
  func getAllPokemons(url: String?, completion: @escaping (_ response: PokedexResponse) -> Void){
    // verificando se tem url, se nao tiver, usar a base
    let page = url == "" || url == nil ? PokemonAPIURL.baseUrl : url ?? ""
    
    alamofireManager.request(page, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
      // pega o status
      let statusCode = response.response?.statusCode
      
      switch response.result {
        case .success(let value):
          // JSON com retorno
          let resultValue = value as? [String: Any]
          
          if statusCode == 404 {
            if let description = resultValue?["detail"] as? String {
              let error = ServerError(msgError: description, statusCode: statusCode!)
              
              completion(.serverError(description: error))
            }
          } else if statusCode == 200 {
            let model = self.parse.parseAllPokedex(response: resultValue)
            
            completion(.success(model: model))
          }
          
        case .failure(let error):
          // status de erro
          let errorCode = error._code
          
          let erro = ServerError(msgError: error.localizedDescription, statusCode: errorCode)
          
          if errorCode == -1009 {
            completion(.noConnection(description: erro))
          } else if errorCode == -1001 {
            completion(.timeOut(description: erro))
          }
      }
    }
  }
  
  func getPokemon(id: Int, completion: @escaping (_ response: PokemonResponse) -> Void){
    let pokemonUrl = "\(PokemonAPIURL.baseUrl)\(id)/"
    
    alamofireManager.request(pokemonUrl, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
      // pega o status
      let statusCode = response.response?.statusCode
      
      switch response.result {
        case .success(let value):
          // JSON com retorno
          let resultValue = value as? [String: Any]
          
          if statusCode == 404 {
            if let description = resultValue?["detail"] as? String {
              let error = ServerError(msgError: description, statusCode: statusCode!)
              
              completion(.serverError(description: error))
            }
          } else if statusCode == 200 {
            let model = self.parse.parsePokemon(response: resultValue)
            
            completion(.success(model: model))
          }
          
        case .failure(let error):
          // status de erro
          let errorCode = error._code
          
          let erro = ServerError(msgError: error.localizedDescription, statusCode: errorCode)
          
          if errorCode == -1009 {
            completion(.noConnection(description: erro))
          } else if errorCode == -1001 {
            completion(.timeOut(description: erro))
          }
      }
    }
  }
  
  func getImagePokemon(url: String, completion: @escaping (_ response: ImageResponse) -> Void) {
    // o evento responseData vai debolver um objeto Data no case success
    alamofireManager.request(url, method: .get).responseData { (response) in
      if response.response?.statusCode == 200 {
        // se o objeto Data vier nulo mesmo retornando 200, algo esta errado
        
        guard let data = response.data else {
          let error = ServerError(msgError: "Falha no Download, data vazio", statusCode: 404)
          completion(.serverError(description: error))
          return
        }
        
        // retornando a imagem
        completion(.success(model: data))
      } else {
        let error = ServerError(msgError: "Falha no Download, data vazio", statusCode: 404)
        completion(.serverError(description: error))
      }
    }
  }
}
