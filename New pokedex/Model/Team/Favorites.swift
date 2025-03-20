//
//  Favorites.swift
//  New pokedex
//
//  Created by Quinn Wienke on 2/18/25.
//

import Foundation

struct FavoritePokemon: Identifiable {
    var id: Int
    var name: String
    var isFavorite: Bool
    var teams: [Teams]
}

struct Teams: Identifiable, Encodable, Decodable {
    var id: Int = UUID().hashValue
    var teamName: String
    var pokemon: [TeamPokemon]
}

struct TeamPokemon: Identifiable, Encodable, Decodable {
    var id: Int
    var name: String
    var type: [String]
    var imageURl: String
}
