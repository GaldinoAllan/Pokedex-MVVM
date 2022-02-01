//
//  PokedexService.swift
//  MVVMPokedex
//
//  Created by Allan Gazola Galdino on 31/01/22.
//

import Foundation

protocol PokedexServiceProtocol {

    func loadPokedex(completionHandler: @escaping (Result<Pokedex, NetworkErros>) -> Void)

//    func loadPokemonImage(from url: String, completionHandler: @escaping NetworkResponse)
}

class PokedexService: PokedexServiceProtocol {

    private let pokeApiURL: String
    private let session: NetworkSession

    init(apiUrl: String = PokeAPI.url, session: NetworkSession = URLSession.shared) {
        self.pokeApiURL = apiUrl
        self.session = session
    }

    func loadPokedex(completionHandler: @escaping (Result<Pokedex, NetworkErros>) -> Void) {
        guard let apiUrl = URL(string: pokeApiURL) else {
            completionHandler(.failure(.invalidUrl))
            return
        }

        session.executeRequest(with: apiUrl) { [weak self] (data, response, error) in
            guard self != nil else { return }

            guard error == nil else {
                completionHandler(.failure(
                    .serverError(message: error?.localizedDescription ?? "")))
                return
            }

            guard let jsonData = data else {
                completionHandler(.failure(.emptyResponse))
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedPokedex = try decoder.decode(Pokedex.self, from: jsonData)
                completionHandler(.success(decodedPokedex))
            } catch let error {
                completionHandler(.failure(.jsonDecoding(message: error.localizedDescription)))
            }
        }
    }
}

//func getImagePokemon(url: String, completion: @escaping (_ response: ImageResponse) -> Void) {
//    // o evento responseData vai debolver um objeto Data no case success
//    alamofireManager.request(url, method: .get).responseData { (response) in
//        if response.response?.statusCode == 200 {
//            // se o objeto Data vier nulo mesmo retornando 200, algo esta errado
//
//            guard let data = response.data else {
//                let error = ServerError(msgError: "Falha no Download, data vazio", statusCode: 404)
//                completion(.serverError(description: error))
//                return
//            }
//
//            // retornando a imagem
//            completion(.success(model: data))
//        } else {
//            let error = ServerError(msgError: "Falha no Download, data vazio", statusCode: 404)
//            completion(.serverError(description: error))
//        }
//    }
//    }
