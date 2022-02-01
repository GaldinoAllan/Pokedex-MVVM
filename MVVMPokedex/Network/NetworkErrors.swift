//
//  NetworkErrors.swift
//  MVVMPokedex
//
//  Created by Allan Gazola Galdino on 31/01/22.
//

import Foundation

enum NetworkErros: Error {
    case invalidUrl
    case emptyResponse
    case serverError(message: String)
    case timeOut(message: String)
    case noConnection(message: String)
    case jsonDecoding(message: String)

    var localizedDescription: String {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .emptyResponse:
            return "Empty response"
        case .serverError(_):
            return "Error returning data from the server"
        case .timeOut(_):
            return "Server timeout"
        case .noConnection(_):
            return "Could not establish connection with the servers"
        case .jsonDecoding(_):
            return "Could not decode JSON"
        }
    }
}

//struct ServerError {
//    let msgError: String
//    let statusCode: Int
//}
//
//enum PokedexResponse {
//    case success(model: PokedexModel)
//    case serverError(description: ServerError)
//    case timeOut(description: ServerError)
//    case noConnection(description: ServerError)
//}
//
//enum PokemonResponse {
//    case success(model: PokemonModel)
//    case serverError(description: ServerError)
//    case timeOut(description: ServerError)
//    case noConnection(description: ServerError)
//}
//
//enum ImageResponse {
//    case success(model: Data)
//    case serverError(description: ServerError)
//    case timeOut(description: ServerError)
//    case noConnection(description: ServerError)
//}
