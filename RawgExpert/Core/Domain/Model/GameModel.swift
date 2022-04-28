//
//  GameModel.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import Foundation

struct GameModel: Equatable, Identifiable {
    let id: Int
    var name: String
    var releaseDate: String
    var rating: Double?
    var imageBackground: String?
}
