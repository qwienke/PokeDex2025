//
//  Tab View.swift
//  New pokedex
//
//  Created by Quinn Wienke on 1/30/25.
//

import SwiftUI

struct MainTabView: View {
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
            
            // Optional: Placeholder for future features
            Text("Favorites")
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
        }
    }
}

#Preview {
    MainTabView()
}
