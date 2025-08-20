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
    
    var body: some View {
        NavigationStack {
            VStack{
                //if user.cartList.isEmpty {
                if viewModel.getProductsOnCart().isEmpty {
                    EmptyState(icon: "cart.badge.questionmark", title: "Your Cart is Empty!", subtitle: "add an item to your cart")
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
