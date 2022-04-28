//
//  GameDetailModel.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import Foundation

struct GameDetailModel: Equatable, Identifiable {
    
    let id: Int
    let name: String
    let releaseDate: String
    let rating: Double?
    let imageBackground: String?
    let image: String
    let metacritic: String
    let playtime: String
    let esrbRating: String
    let platforms: String
    let genres: String
    let developers: String
    let publishers: String
    let description: String
    let urlWeb: String
    
}
