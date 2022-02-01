//
//  PokedexService.swift
//  MVVMPokedex
//
//  Created by Allan Gazola Galdino on 31/01/22.
//

import Foundation

protocol PokedexServiceProtocol {

    func loadPokedex(completionHandler: @escaping (Result<Pokedex, NetworkErros>) -> Void)

    func loadPokemon(with pokemonUrl: String,
                     completionHandler: @escaping (Result<Pokemon, NetworkErros>) -> Void)
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

    func loadPokemon(with pokemonUrl: String,
                     completionHandler: @escaping (Result<Pokemon, NetworkErros>) -> Void) {
        guard let apiUrl = URL(string: pokemonUrl) else {
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
                let decodedPokedex = try decoder.decode(Pokemon.self, from: jsonData)
                completionHandler(.success(decodedPokedex))
            } catch let error {
                completionHandler(.failure(.jsonDecoding(message: error.localizedDescription)))
            }
        }
    }
}
