//
//  PokemonAbilitiesViewModel.swift
//  New pokedex
//
//  Created by Quinn Wienke on 1/21/25.
//

import Foundation

class PokemonAbilitiesViewModel: ObservableObject {
    @Published var pokemonAbilitiesInfo: PokemonAbilitiesInfo? 
    private let url: String
    
    init(url: String) {
        self.url = url
        print(url)
    }
    
    func fetchPokemonDetails() {
        guard let url = URL(string: self.url) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching details: \(error)")
                return
            }

            guard let data = data else {
                print("No data returned")
                return
            }

            do {
                let decodedInfo = try JSONDecoder().decode(PokemonAbilitiesInfo.self, from: data)
                DispatchQueue.main.async {
                    self.pokemonAbilitiesInfo = decodedInfo
                }
            } catch {
                print("Error decoding details: \(error)")
            }
        }.resume()
    }
}

