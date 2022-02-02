//
//  Species.swift
//  MVVMPokedex
//
//  Created by Allan Gazola Galdino on 02/02/22.
//

import Foundation

struct Species: Codable {
    let name: String
    let color: ColorName

    struct ColorName: Codable {
        let name: String
        let url: String
    }
}
