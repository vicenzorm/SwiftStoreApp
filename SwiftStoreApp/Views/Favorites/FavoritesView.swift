//
//  CategoriesVIew.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 14/08/25.
//

import SwiftUI

struct FavoritesView: View {
    @State var viewModel: FavoritesViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.favoriteProducts.isEmpty {
                    EmptyState(icon: "heart.slash",
                               title: "No favorites yet!",
                               subtitle: "Favorite an item and it will show up here.")
                } else {
                    ScrollView {
                        VStack(spacing: 8) {
                            ForEach(viewModel.filteredFavorite) { product in
                                ProductCardList(
                                    cardType: .favorites,
                                    product: product,
                                    showDetails: {
                                        viewModel.selectedProduct = product
                                    })
                            }
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
            .searchable(text: $viewModel.searchText, prompt: "Search")
            .task {
                await viewModel.loadFavoriteProducts()
            }
            .sheet(item: $viewModel.selectedProduct) { product in
                DetailsView(viewModel: DetailsViewModel(apiService: APIService.shared, favoritesService: Persistence.shared.favoriteService, cartService: Persistence.shared.cartService, isFavorite: viewModel.isProductFavorite(product: product)), product: product)
            }
        }
    }
}

#Preview {
    TabBar()
}
