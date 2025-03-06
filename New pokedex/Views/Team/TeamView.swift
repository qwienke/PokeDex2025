//
//  TeamView.swift
//  New pokedex
//
//  Created by Quinn Wienke on 2/21/25.
//

import SwiftUI

struct TeamView: View {
    
    @EnvironmentObject var viewModel: PokemonViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.teams) { team in
                if team.pokemon.isEmpty {
                    Text("No Team Yet")
                } else {
                    ForEach(team.pokemon, id: \.id) { pokemon in
                        HStack {
                            Text(pokemon
                                .name)
                        }
                    }
                }
        }
        }
        .onAppear() {
            viewModel.loadTeams() 
        }
    }
}

#Preview {
    TeamView()
}
