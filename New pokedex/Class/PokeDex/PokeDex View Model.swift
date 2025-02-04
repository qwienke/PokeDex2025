//
//  PokeDex View Model.swift
//  New pokedex
//
//  Created by Quinn Wienke on 1/22/25.
//

import Foundation
class PokeDexViewModel: ObservableObject {
   
    @Published var pokeDexList: [PokeDexListResponse.ResultsWrapper] = []
    
    func fetchPokemon() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokedex/") else {
            
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
                let decodedResponse = try JSONDecoder().decode(PokeDexListResponse.self, from: data)
                print("Pokedex decoded")
                
                DispatchQueue.main.async {
                    self.pokeDexList = decodedResponse.results
                    
                    print("pokedex fetched")
                }
            } catch {
                print("error decoding data: \(error)")
            }
            
        }.resume()
        
    }
}
