import SwiftUI
import Foundation

struct TeamView: View {
    
    @EnvironmentObject var viewModel: PokemonViewModel
    let columns = [GridItem(.flexible())]

    @State private var teamToDelete: Teams?
    @State private var showDeleteAlert = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.teams, id: \.id) { team in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(team.teamName)
                                    .font(.headline)
                                    .padding(.bottom, 5)

                                Spacer()

                                Button(action: {
                                    teamToDelete = team
                                    showDeleteAlert = true
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 10) {
                                    if team.pokemon.isEmpty {
                                        Text("No Pokémon Yet")
                                            .padding()
                                    } else {
                                        ForEach(team.pokemon, id: \.id) { pokemon in
                                            pokemonCardView(for: pokemon) // ✅ Now using our function
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                    }
                }
                .padding()
            }
            .navigationTitle("Teams")
        }
        .onAppear {
            viewModel.loadTeams()
        }
        .alert("Delete Team?", isPresented: $showDeleteAlert, presenting: teamToDelete) { team in
            Button("Delete", role: .destructive) {
                if let index = viewModel.teams.firstIndex(where: { $0.id == team.id }) {
                    viewModel.deleteTeam(at: IndexSet(integer: index))
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: { team in
            Text("Are you sure you want to delete \(team.teamName)? This action cannot be undone.")
        }
    }
    
    // ✅ Helper Function to Fix Compiler Issue
    private func pokemonCardView(for pokemon: TeamPokemon) -> some View {
        VStack {
            AsyncImage(url: URL(string: pokemon.imageURl)) { phase in
                if let image = phase.image {
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else if phase.error != nil {
                    Text("❌")
                        .frame(width: 80, height: 80)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    ProgressView()
                        .frame(width: 80, height: 80)
                }
            }

            Text(pokemon.name)
                .font(.caption)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    TeamView()
}
