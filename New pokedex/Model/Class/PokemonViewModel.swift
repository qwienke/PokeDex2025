//
//  PokemonViewModel.swift
//  New pokedex
//
//  Created by Quinn Wienke on 1/13/25.
//

import Foundation
class PokemonViewModel: ObservableObject {
   
    @Published var pokemonList: [PokemonModel] = []
    
    func fetchPokemon() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=100") else {
            
            print("invalid URl")
            
            return
        }
        
        //Network Request
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("error \(error)")
                return
            }
            
            
            guard let data = data else {
                print("no data to be returned")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(PokemonResponseModel.self, from: data)
                
                DispatchQueue.main.async {
                    self.pokemonList = decodedResponse.results
                    
                    print("pokemon fetched")
                }
            } catch {
                print("error decoding data: \(error)")
            }
            
        }.resume()
        
    }
}
