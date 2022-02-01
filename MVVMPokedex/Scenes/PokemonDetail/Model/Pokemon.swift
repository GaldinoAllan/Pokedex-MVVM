//
//  Pokemon.swift
//  MVVMPokedex
//
//  Created by allan.galdino on 09/05/21.
//

struct Pokemon: Codable, Equatable {
    var id: Int
    var name: String
    var sprites: Sprite

    struct Sprite: Codable, Equatable {
        var frontDefault: String?

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
}

extension Pokemon {
    var imageUrl: String? { sprites.frontDefault }
}
