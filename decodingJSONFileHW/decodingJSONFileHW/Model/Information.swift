//
//  Information.swift
//  decodingJSONFileHW
//
//  Created by Field Employee on 9/30/20.
//

import Foundation

struct Information {
    var double_damage_from: [damageFrom]
    var double_damage_to: nameLink?
    var half_damage_from: [nameLink]
    var half_damage_to: nameLink?
    var no_damage_from: NSNull?
    var no_damage_to: nameLink?
    var game_indices: [gameIndices]
    var generation: nameLink?
    var id: Int?
    var move_damage_class: nameLink?
    var moves: [nameLink]
    var name: String?
    var pokemon: [pokemon]
    
}




struct damageFrom{
    var double_damage_From: nameLink
    
}

struct nameLink {
    var name: String?
    var url: String?
}

struct gameIndices {
    var game_index: Int?
    var generation: nameLink
}

struct pokemon {
    var pokemon: nameLink
    var slot: Int?
}
