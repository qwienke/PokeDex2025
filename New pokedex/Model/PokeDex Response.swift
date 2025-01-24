//
//  PokeDex Response.swift
//  New pokedex
//
//  Created by Quinn Wienke on 1/22/25.
//

import Foundation

struct PokeDexResponse: Codable {
    var results: [PokeDexListResponse]
}
