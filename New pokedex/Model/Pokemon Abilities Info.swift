//
//  Pokemon Abilities Info.swift
//  New pokedex
//
//  Created by Quinn Wienke on 1/21/25.
//

import Foundation

struct PokemonAbilitiesInfo: Codable, Identifiable {
    let id: Int
        let name: String
        let effect_entries: [EffectEntry]

        struct EffectEntry: Codable {
            let effect: String
            let short_effect: String
            // language, if you need it
        }
}
