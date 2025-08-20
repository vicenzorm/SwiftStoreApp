//
//  CategoriesVIew.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 14/08/25.
//

import SwiftUI

struct FavoritesView: View {
    
    @State var textToSearch: String = ""
    let viewModel: UserViewModel
    
    var body: some View {
        
        VStack {
            if viewModel.favoriteProducts.isEmpty {
                EmptyState(icon: "heart.slash", title: "No favorites yet!", subtitle: "Favorite an item and it will show up here.")
            } else {
                List(viewModel.favoriteProducts) { product in
                    ProductCardList(product: product, cardType: .favorites)
                }
            }
        }
        .navigationTitle("Favorites")
        .searchable(text: $textToSearch, prompt: "Search" )
    }
}

#Preview {
    TabBar()
}
