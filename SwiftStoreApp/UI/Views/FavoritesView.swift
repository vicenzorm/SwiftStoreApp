//
//  CategoriesVIew.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 14/08/25.
//

import SwiftUI

struct FavoritesView: View {
    
    let viewModel: UserViewModel
    
    @State var textToSearch: String = ""
    var filteredProducts: [UserProduct] {
        if textToSearch.isEmpty {
            return viewModel.favoriteProducts
        } else {
            return viewModel.favoriteProducts.filter({$0.title.localizedCaseInsensitiveContains(textToSearch)})
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.favoriteProducts.isEmpty {
                    EmptyState(icon: "heart.slash", title: "No favorites yet!", subtitle: "Favorite an item and it will show up here.")
                } else {
                    ScrollView {
                        VStack(spacing: 8) {
                            ForEach(filteredProducts) { product in
                                ProductCardList(product: product, cardType: .favorites)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
            .searchable(text: $textToSearch, prompt: "Search")
            .onAppear {
                print("ENTREI")
                viewModel.favoriteProducts = viewModel.getFavoriteProducts()
            }
        }
    }
}

#Preview {
    TabBar()
}
