//
//  PokeDexInfo.swift
//  New pokedex
//
//  Created by Quinn Wienke on 1/24/25.
//

import Foundation

struct PokeDexInfo: Codable, Identifiable {
    var id: Int
    
    var name: String
    var pokemon_entries: [PokemonEntriesWrapper]
}

    struct PokemonEntriesWrapper: Codable, Identifiable {
        var id: Int { entry_number }
        
        var entry_number: Int
        
        var pokemon_species: PokemonSpeciesWrapper
    }

    struct PokemonSpeciesWrapper: Codable, Identifiable {
        var id = UUID()
        
        var name: String
        var url: String
        
        private enum CodingKeys: String, CodingKey {
               case name
               case url
           }
    }
    



