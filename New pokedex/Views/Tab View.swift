//
//  Tab View.swift
//  New pokedex
//
//  Created by Quinn Wienke on 1/30/25.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var viewModel = PokemonViewModel()
    
    var body: some View {
        TabView {
            PokeDex_View()
                .tabItem {
                    Label("Regions", systemImage: "map")
                }
            
            ContentView()
                .tabItem {
                    Label("Pokedex", systemImage: "list.bullet")
                }
            
        AddTeamView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
            
            TeamView()
                            .tabItem {
                                Label("Teams", systemImage: "person.3")
                            }
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    MainTabView()
}
