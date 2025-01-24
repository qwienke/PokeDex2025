//
//  PokeDex View.swift
//  New pokedex
//
//  Created by Quinn Wienke on 1/22/25.
//

import SwiftUI

struct PokeDex_View: View {
    @StateObject var viewModel = PokeDexViewModel()
    
    var body: some View {
        NavigationView{
            List(viewModel.pokeDexList) { region in
                HStack {
                    NavigationLink(destination: PokemonDetailView(url: region.url)) {
                    }
                    Text(region.name.capitalized)
                }
            }
            .onAppear {
                            viewModel.fetchPokemon()
                        }
        }
    }
}
    
    #Preview {
        PokeDex_View()
    }

