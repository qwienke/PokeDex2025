import SwiftUI

struct PokeDexDetailView: View {
    
    let url: String
    @StateObject private var viewModel: PokeDexDetailViewModel
    @State var searchText = ""
    
    //Custom URl Initilizer
    init(url: String) {
        self.url = url
        _viewModel = StateObject(wrappedValue: PokeDexDetailViewModel(url: url))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if let info = viewModel.pokeDexInfo {
                    VStack {
                        //Title text
                        Text(info.name.capitalized)
                            .font(.title)
                            .padding(.bottom, 10)
                        
                        // Pokémon Entries List
                        List(filteredPokemonEntries, id: \.entry_number) { entry in
                            NavigationLink(
                                destination: PokemonDetailView(url: entry.pokemon_species.url.replacingOccurrences(of: "pokemon-species", with: "pokemon"))
                                ){
                                Text("\(entry.entry_number): \(entry.pokemon_species.name.capitalized)")
                            }
                        } .searchable(text: $searchText)
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
    
    var filteredPokemonEntries: [PokemonEntriesWrapper] {
        if searchText.isEmpty {
            return viewModel.pokeDexInfo?.pokemon_entries ?? []
        } else {
            return (viewModel.pokeDexInfo?.pokemon_entries ?? []).filter { entry in
                entry.pokemon_species.name.lowercased().contains(searchText.lowercased())
            }
        }
    }

}


#Preview {
    PokeDexDetailView(url: "https://pokeapi.co/api/v2/pokedex/1/")
}
