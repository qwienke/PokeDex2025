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
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                ForEach(viewModel.pokeDexList, id: \.url) { region in
                    Text(region.name.capitalized)
                        .frame(width: 100, height: 100)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .onTapGesture {
                        navigateToDetailView(url: region.url)
                                            }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchPokemon()
        }
        
    }
}

func navigateToDetailView(url: String) {
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
       let rootViewController = windowScene.windows.first?.rootViewController {
        let detailView = UIHostingController(rootView: PokeDexDetailView(url: url))
        rootViewController.present(detailView, animated: true, completion: nil)
    }
}
    
    #Preview {
        PokeDex_View()
    }

