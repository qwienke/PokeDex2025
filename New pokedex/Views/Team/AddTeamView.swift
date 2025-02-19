import SwiftUI

struct AddTeamView: View {
    @StateObject var viewModel = PokemonViewModel()
    @State private var searchText = ""

    // Correctly filter `pokemonList` based on searchText
    var filteredPokemonEntries: [PokemonModel] {
        if searchText.isEmpty {
            return viewModel.pokemonList
        } else {
            return viewModel.pokemonList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    
                    // Use `filteredPokemonEntries` instead of `viewModel.pokemonList`
                    List(filteredPokemonEntries) { entry in
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
                    .searchable(text: $searchText)
                    .frame(height: geometry.size.height - 200)
                    
                    // Selected Favorites List
                    VStack(alignment: .leading) {
                        Text("My Team")
                            .font(.headline)
                            .padding(.leading)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(viewModel.pokemonList.filter { $0.isFavorite }) { favorite in
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
                        
                        if !viewModel.pokemonList.filter({ $0.isFavorite }).isEmpty {
                            Button(action: {
                                print("Added Pokemon")
                                let newTeam = viewModel.addTeam()
                                
                                for favorite in viewModel.favoritePokemonList {
                                    viewModel.addPokemonToTeam(pokemon: favorite, teamID: newTeam.id)
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
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .onAppear {
            viewModel.fetchPokemon()
        }
        .padding()
    }
}

#Preview {
    AddTeamView()
}
