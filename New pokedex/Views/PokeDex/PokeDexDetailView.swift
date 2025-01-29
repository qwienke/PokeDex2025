import SwiftUI

struct PokeDexDetailView: View {
    
    let url: String
    @StateObject private var viewModel: PokeDexDetailViewModel
    
    init(url: String) {
        self.url = url
        _viewModel = StateObject(wrappedValue: PokeDexDetailViewModel(url: url))
    }
    
    var body: some View {
        NavigationView { // Wrap the entire view in NavigationView
            VStack {
                if let info = viewModel.pokeDexInfo {
                    VStack {
                        Text(info.name.capitalized)
                            .font(.title)
                            .padding(.bottom, 10)
                        
                        // Pokémon Entries List
                        List(info.pokemon_entries, id: \.entry_number) { entry in
                            NavigationLink(
                                destination: PokemonDetailView(url: entry.pokemon_species.url.replacingOccurrences(of: "pokemon-species", with: "pokemon"))
                                ){
                                Text("\(entry.entry_number): \(entry.pokemon_species.name.capitalized)")
                            }
                        }
                    }
                } else {
                    ProgressView("Loading...") // Show loading indicator
                }
            }
            .onAppear {
                print("Fetching Pokedex Details for URL: \(url)")
                viewModel.fetchPokedexDetails()
            }
            .navigationTitle("Pokedex Details")
        }
    }
}


#Preview {
    PokeDexDetailView(url: "https://pokeapi.co/api/v2/pokedex/1/")
}
