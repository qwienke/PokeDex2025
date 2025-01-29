//
//  PokeDexListResponse.swift
//  New pokedex
//
//  Created by Quinn Wienke on 1/22/25.
//

import Foundation
    
    struct PokeDexListResponse: Codable {
        
        let next: String
        let previous: String?
        
        let results: [ResultsWrapper]
        
        struct ResultsWrapper: Codable, Identifiable {
            var id = UUID()
            
            let name: String
            let url: String
            
            private enum CodingKeys: String, CodingKey {
                case name
                case url
            }
        }
    }
    

