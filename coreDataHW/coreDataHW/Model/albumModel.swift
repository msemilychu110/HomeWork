//
//  albumModel.swift
//  coreDataHW
//
//  Created by Field Employee on 10/12/20.
//

import Foundation


struct albumModel: Codable {
    
    var feed : results
    
    enum CodingKeys: String, CodingKey {
        case feed
    }
    
}

struct results: Codable {
    var results: [nameLink]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct nameLink: Codable {
    var artistName: String
    var releaseDate: String
    var name: String
    var artworkUrl100: String
    var genres: [gen]
    
    enum CodingKeys: String, CodingKey {
        case artistName, releaseDate, name, artworkUrl100, genres
    }
}

struct gen: Codable {
    var genreId: String
    var name: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case genreId, name, url 
    }
}

struct albumInfo{
    var artistName: String
    var releaseDate: String
    var albumName: String
    var imageUrlString: String
    var genreName: String
}
