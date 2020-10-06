//
//  pokemonModel.swift
//  pokemonNetworkingHw3
//
//  Created by Field Employee on 10/2/20.
//

import UIKit

struct pokemonModel: Codable {
    var results: [nameLink]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct pokemonInfo: Codable {
    var abilities: [ability]
    var id: Int
    var moves: [move]
    var name: String
    var sprites: Sprite
    var types: [type]
    
    
    enum CodingKeys: String, CodingKey {
        case abilities,id, moves,name, sprites, types
       
    }
    
}

struct move: Codable {
    var move: nameLink
    
    enum CodingKeys: String, CodingKey {
        case move
    }
}

struct ability: Codable {
    var ability: nameLink
    enum CodingKeys: String, CodingKey {
        case ability
    }
}

struct type: Codable {
    var slot: Int
    var type: nameLink
    
    enum CodingKeys: String, CodingKey {
        case slot, type
    }
}

struct Sprite: Codable {
    var other: other
    
    
    enum CodingKeys: String, CodingKey {
        case other
        
    }
}
struct other: Codable {
    var officialArtwork: frontDefault
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}
struct frontDefault: Codable {
    var frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct nameLink: Codable{
    var name: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case name, url
    }
}
