//
//  Pokemon.swift
//  New pokedex
//
//  Created by Quinn Wienke on 1/13/25.
//

import Foundation


struct PokemonModel: Codable, Identifiable {
    var id: Int {
           if let lastNumber = url.split(separator: "/").last,
              let numericID = Int(lastNumber) {
               return numericID
           }
           return -1 // Default if no number is found
       }
    let name: String
    let url: String

    var isFavorite: Bool = false

    
    private enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}




