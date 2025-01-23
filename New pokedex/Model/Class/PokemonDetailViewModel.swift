//
//  PokemonViewModel.swift
//  New pokedex
//
//  Created by Quinn Wienke on 1/13/25.
//

import Foundation

class PokemonDetailViewModel: ObservableObject {
    @Published var pokemonInfo: PokemonInfo?  // The detailed data
    private let url: String                   // The Pokémon's URL

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
                let decodedInfo = try JSONDecoder().decode(PokemonInfo.self, from: data)
                DispatchQueue.main.async {
                    self.pokemonInfo = decodedInfo
                }
            } catch {
                print("Error decoding details: \(error)")
            }
        }.resume()
    }
}
