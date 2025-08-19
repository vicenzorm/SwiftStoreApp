//
//  CategoriesVIew.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 14/08/25.
//

import SwiftUI
import SwiftData

struct CartView: View {
    
    var viewModel: UserViewModel
    var teste: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack{
                //if user.cartList.isEmpty {
                if viewModel.getProductsOnCart().isEmpty {
                    EmptyState(icon: "cart.badge.questionmark", title: "No favorites yet!", subtitle: "Favorite an item and it will show up here.")
                } else {
                    ForEach(viewModel.getProductsOnCart()) { product in
                        ProductCardList(product: product)
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Cart")
    }
    
}


#Preview {
    TabBar()
}
