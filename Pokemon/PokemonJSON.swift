//
//  PokemonJSON.swift
//  Pokemon
//
//  Created by 張永霖 on 2021/5/2.
//

import Foundation

// For specific pokemon

struct PokemonData: Codable{
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
    let types: [Types]
}

struct  Sprites: Codable{
    let frontDefault: String
}

struct  Types: Codable{
    let type: type
}

struct  type: Codable{
    let name: String
}

// For ColletionView

struct PokemonList: Codable, Hashable{
    let results: [Reslut]
}

struct  Reslut: Codable, Hashable{
    let name: String
    let url: String
}
