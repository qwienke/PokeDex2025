//
//  AddTeamView.swift
//  New pokedex
//
//  Created by Quinn Wienke on 2/3/25.
//

//
//  ContentView.swift
//  PracticePOkedex
//
//  Created by Quinn Wienke on 2/6/25.
//

import SwiftUI

struct AddTeamView: View {
    @StateObject var viewModel = PokemonViewModel()
    
    
    var favoriteEntries: [PokemonModel] {
        return viewModel.pokemonList.filter { $0.isFavorite }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                
                // Main Pokémon List
                List(viewModel.pokemonList) { entry in
                    HStack {
                        Text(entry.name.capitalized)
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.toggleFavorite(for: entry)
                        }) {
                            Image(systemName: entry.isFavorite ? "star.fill" : "star")
                                .foregroundColor(entry.isFavorite ? .yellow : .gray)
                        }
                    }
                }
                .frame(height: geometry.size.height - 200) // Reserve space for the favorite section
                
                // Selected Favorite Pokémon Display
                
                // Selected Favorites List
                VStack(alignment: .leading) {
                    Text("My Team")
                        .font(.headline)
                        .padding(.leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(favoriteEntries) { favorite in
                                VStack {
                                    AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(favorite.id).png")) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    
                                    Text(favorite.name.capitalized)
                                        .font(.caption)
                                }
                                .padding()
                                .background(Color.yellow.opacity(0.3))
                                .cornerRadius(8)
                                
                            }
                        }
                        .padding()
                    }
                    .frame(height: 150)
                    
                    if !favoriteEntries.isEmpty {
                        Button(action: {
                            print("Added Pokemon")
                            let newTeam = viewModel.addTeam()
                           
                            for favorite in viewModel.favoritePokemonList { // ✅ Loop through favorited Pokémon
                                       viewModel.addPokemonToTeam(pokemon: favorite, teamID: newTeam.id) // ✅ Add each favorite to the team
                                   }
                            print("\(newTeam.id)")
                           
                        }) {
                            Text("Finish")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .padding(.horizontal)
                        }
                    } else {
                        
                    }
                }
                .padding(.horizontal)
                
                
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .onAppear {
            viewModel.fetchPokemon()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
