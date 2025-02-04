//
//  ContentView.swift
//  New pokedex
//
//  Created by Quinn Wienke on 1/13/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PokemonViewModel()

    var body: some View {
        NavigationView {
            //Pokemon list view
            List(viewModel.pokemonList) { pokemon in
                NavigationLink(destination: PokemonDetailView(url: pokemon.url)) {
                    Text(pokemon.name.capitalized)
                }
            }
            .navigationTitle("Pokedex")
        }
        .onAppear {
            viewModel.fetchPokemon()
        }
    }
}
#Preview {
    ContentView()
}
