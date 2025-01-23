//
//  PokemonDetailView.swift
//  New pokedex
//
//  Created by Quinn Wienke on 1/14/25.
//

import SwiftUI

struct PokemonDetailView: View {
    
    let url: String
    @StateObject private var viewModel: PokemonDetailViewModel
    
    // Custom initializer to pass the URL to the ViewModel
    init(url: String) {
        self.url = url
        _viewModel = StateObject(wrappedValue: PokemonDetailViewModel(url: url))
    }
    
    var body: some View {
            VStack {
                // Display the Pokémon's name
                if let info = viewModel.pokemonInfo {
                    VStack {
                        Text("\(info.name.capitalized)")
                            .font(.title) // Optional: Style the text
                        Text("Entry Number: \(info.id)")
                        Text("Height: \(info.height)")
                        Text("Abilities:")
                        ForEach(info.abilities, id: \.ability.name) { abilityWrapper in
                            NavigationLink(abilityWrapper.ability.name.capitalized, destination: AbilitiesView(url: abilityWrapper.ability.url))
                        }
                    }
                    //Display Image
                    if let frontDefaultURL = viewModel.pokemonInfo?.sprites.front_default,
                       let frontShinyURL = viewModel.pokemonInfo?.sprites.front_shiny {
                        HStack {
                            // Display the default sprite
                            AsyncImage(url: URL(string: frontDefaultURL)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                case .failure:
                                    Text("Failed to load default image")
                                @unknown default:
                                    Text("Unknown error")
                                }
                            }
                            
                            // Display the shiny sprite
                            AsyncImage(url: URL(string: frontShinyURL)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                case .failure:
                                    Text("Failed to load shiny image")
                                @unknown default:
                                    Text("Unknown error")
                                }
                            }
                        }
                    }
                    
                    
                } else {
                    
                }
            }
            .onAppear {
                viewModel.fetchPokemonDetails()
            }
        }
        
    }
    
    #Preview {
        PokemonDetailView(url: "https://pokeapi.co/api/v2/pokemon/1/")
    }
    

