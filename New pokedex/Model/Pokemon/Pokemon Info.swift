//
//  Pokemon Info.swift
//  New pokedex
//
//  Created by Quinn Wienke on 1/14/25.
//

import Foundation

struct PokemonInfo: Codable, Identifiable {
    let id: Int
    let name: String
    let abilities: [AbilityWrapper]
    let location_area_encounters: String
    let sprites: Sprites
    let height: Int
    let types: [TypesWrapper]

    
    
    struct AbilityWrapper: Codable {
        let ability: Ability
    }
    struct Ability: Codable {
        let name: String
        let url: String
    }
    
    struct Sprites: Codable {
        let front_default: String
        let front_shiny: String
    }
    
    struct TypesWrapper: Codable {
        let types: Type
    }
    struct `Type`: Codable {
        let name : String
        let url: String
    }
}
