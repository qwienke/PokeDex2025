//
//  PokeDexDetailViewModel.swift
//  New pokedex
//
//  Created by Quinn Wienke on 1/24/25.
//

import Foundation

class PokeDexDetailViewModel: ObservableObject {
   
    @Published var pokeDexInfo: PokeDexInfo?
    private let url: String
    
    init(url: String) {
        self.url = url
        print(url)
    }
    
    func fetchPokedexDetails() {
        guard let url = URL(string: self.url) else {
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
                let decodedResponse = try JSONDecoder().decode(PokeDexInfo.self, from: data)
                print("Pokedex decoded")
                
                DispatchQueue.main.async {
                    self.pokeDexInfo = decodedResponse
                    
                    print("pokedex fetched")
                }
            } catch {
                print("error decoding data: \(error)")
            }
            
        }.resume()
        
    }
    
    func toggleFavorite(for entryNumber: Int) {
            guard let info = pokeDexInfo else { return }
            
            // Find the index of the entry to update
            if let index = info.pokemon_entries.firstIndex(where: { $0.entry_number == entryNumber }) {
                // Because pokeDexInfo is a struct, you'll need to update the entire structure.
                // You might want to make pokeDexInfo mutable or use an inout update pattern.
                pokeDexInfo?.pokemon_entries[index].pokemon_species.isFavorite.toggle()
            }
        }

}
