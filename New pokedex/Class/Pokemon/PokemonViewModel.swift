//
//  PokemonViewModel.swift
//  New pokedex
//
//  Created by Quinn Wienke on 1/13/25.
//

import Foundation
class PokemonViewModel: ObservableObject {
   
    @Published var pokemonInfo: PokemonModel?
    @Published var pokemonList: [PokemonModel] = []
    @Published var selectedFavorite: PokemonInfo?
    
    //Favorite pokemon
    @Published var favoritePokemonList: [FavoritePokemon] = []
    @Published var teams: [Teams] = []
    
    
    func toggleFavorite(for pokemon: PokemonModel) {
        if let index = pokemonList.firstIndex(where: { $0.id == pokemon.id }) {
            var updatedPokemon = pokemonList[index]
            updatedPokemon.isFavorite.toggle()
            pokemonList[index] = updatedPokemon // Reassign to trigger UI update
            
            if updatedPokemon.isFavorite {
                        fetchPokemonInfo(for: updatedPokemon.id)
                    addToFavorites(pokemon: updatedPokemon)
                    } else if selectedFavorite?.id == updatedPokemon.id {
                        selectedFavorite = nil // Unselect if unfavorited
                        removeFromFavorites(pokemon: updatedPokemon)
                    }
        }
    }
    
    func fetchPokemonInfo(for id: Int) {
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(id)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let detailedPokemon = try JSONDecoder().decode(PokemonInfo.self, from: data)
                    DispatchQueue.main.async {
                        self.selectedFavorite = detailedPokemon
                    }
                } catch {
                    print("Error decoding detailed Pokemon data: \(error)")
                }
            }
        }.resume()
    }
    
    //adds pokemon to favorites model
    func addToFavorites(pokemon: PokemonModel) {
        if !favoritePokemonList.contains(where: { $0.id == pokemon.id }) {
            let newFavorite = FavoritePokemon(
                id: pokemon.id,
                name: pokemon.name,
                isFavorite: true,
                teams: []
            )
            favoritePokemonList.append(newFavorite)
        }
    }
    //removes pokemon from favorites model if updated
    func removeFromFavorites(pokemon: PokemonModel) {
        favoritePokemonList.removeAll { $0.id == pokemon.id }
    }
    
    //Add the team
    func addTeam() -> Teams {
        let newTeam = Teams(id: UUID().hashValue, teamName: "My Team", pokemon: [])
        teams.append(newTeam)
        print("✅ New team created: \(newTeam.teamName), ID: \(newTeam.id)")
        return newTeam
    }
    
    //add favorite pokemon to the created team
    func addPokemonToTeam(pokemon: FavoritePokemon, teamID: Int) { // ✅ Ensure parameter is "teamID"
        guard let teamIndex = teams.firstIndex(where: { $0.id == teamID }) else {
            print("🚨 Error: No team found with ID \(teamID)")
            return
        }

        let newTeamPokemon = TeamPokemon(id: pokemon.id, name: pokemon.name, type: [])

        if !teams[teamIndex].pokemon.contains(where: { $0.id == pokemon.id }) {
            teams[teamIndex].pokemon.append(newTeamPokemon)
            print("✅ Added \(pokemon.name) to team \(teams[teamIndex].teamName)")
        } else {
            print("⚠️ \(pokemon.name) is already in the team!")
        }
    }
    func fetchPokemon() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=1304") else {
            
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
