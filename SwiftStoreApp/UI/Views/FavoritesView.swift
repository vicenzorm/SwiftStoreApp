//
//  CategoriesVIew.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 14/08/25.
//

import SwiftUI

struct FavoritesView: View {
    
    @State var viewModel: FavoritesViewModel
    
    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.favoriteProducts.isEmpty {
                    EmptyState(icon: "heart.slash", title: "No favorites yet!", subtitle: "Favorite an item and it will show up here.")
                } else {
                    ScrollView {
                        VStack(spacing: 8) {
                            ForEach(viewModel.favoriteProducts) { product in
                                ProductCardList()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
            .searchable(text: $searchText, prompt: "Search")
            .onAppear {
                print("ENTREI")
                Task { viewModel.loadFavoriteProducts() }
            }
            .onChange(of: searchText) { _, newValue in
                viewModel.filterFavorites(textToSearch: newValue)
            }
        }
    }
}

#Preview {
    TabBar()
}
