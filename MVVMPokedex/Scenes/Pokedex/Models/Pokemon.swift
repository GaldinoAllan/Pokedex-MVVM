//
//  Pokemon.swift
//  MVVMPokedex
//
//  Created by allan.galdino on 09/05/21.
//

struct Pokemon: Decodable, Equatable {
    let id: Int
    let name: String
    private let sprites: Sprite

    struct Sprite: Decodable, Equatable {
        let frontDefault: String?

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
}

extension Pokemon {
    var imageUrl: String? { sprites.frontDefault }
}


