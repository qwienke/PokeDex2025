//
//  AbilitiesView.swift
//  New pokedex
//
//  Created by Quinn Wienke on 1/15/25.
//

import SwiftUI

struct AbilitiesView: View {
    
    let url: String
    @StateObject  var viewModel: PokemonAbilitiesViewModel
    
    //custom URL initilization
    init(url: String) {
        self.url = url
        _viewModel = StateObject(wrappedValue: PokemonAbilitiesViewModel(url: url))
    }
    
    var body: some View {
        VStack {
            //List of pokemon ablilities
            if let info = viewModel.pokemonAbilitiesInfo {
                Text("\(info.name)")
                ForEach(info.effect_entries, id: \.effect) { entry in
                    Text(entry.effect)
                }
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            // 🔑 Trigger the network call here
            viewModel.fetchPokemonDetails()
        }
    }
    
}

#Preview {
    AbilitiesView(url: "https://pokeapi.co/api/v2/ability/1/")
}
