//
//  TeamView.swift
//  New pokedex
//
//  Created by Quinn Wienke on 2/3/25.
//

import SwiftUI

struct Team: Identifiable, Codable {
    let id = UUID()  // Unique identifier for SwiftUI
    let members: [String]  // The names of the Pokémon in the team
}

struct TeamView: View {
    // Hardcoded list of teams for now
    let teams: [Team] = [
        Team(members: ["Pikachu", "Bulbasaur", "Charmander", "Squirtle", "Jigglypuff", "Meowth"]),
        Team(members: ["Ivysaur", "Wartortle", "Pidgey", "Rattata", "Ekans", "Sandshrew"])
    ]
    let columns: [GridItem] = [GridItem(.flexible())]
    
    
    var body: some View {
        Text("Teams")
            .font(.title)
            .bold()
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                                    ForEach(teams) { team in
                                        // Each team cell: a vertical stack
                                        VStack(alignment: .leading, spacing: 10) {
                                            Text("Team")
                                                .font(.headline)
                                            
                                            // Horizontal list of team members
                                            HStack {
                                                ForEach(team.members, id: \.self) { member in
                                                    Text(member)
                                                        .padding(4)
                                                        .background(Color.blue.opacity(0.2))
                                                        .cornerRadius(5)
                                                }
                                            }
                                        }
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                    }
                                }
                                .padding()
                                
                        }
                    }
                }
            }
 
    
    
    #Preview {
        TeamView()
    }

