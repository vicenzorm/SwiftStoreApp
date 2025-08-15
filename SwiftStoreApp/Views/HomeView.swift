//
//  ContentView.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 13/08/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    let viewModel: ShopViewModel
    
    let colunas: [GridItem] = [
        GridItem(.fixed(177), spacing: 8),
        GridItem(.fixed(177), spacing: 8)
    ]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Deals of the day")
                        .font(.system(size: 22, weight: .bold))
                        .font(.title2)
        
                    ProductCardDeal()
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Top Picks")
                        .font(.system(size: 22, weight: .bold))
                        .font(.title2)
                    
                    ScrollView {
                        LazyVGrid(columns: colunas) {
                            ForEach(viewModel.products) { product in
                                ProductCardVertical(product: product)
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Home")
            .frame(maxHeight: .infinity, alignment: .top)
            .task {
                await viewModel.loadProducts()
            }
        }
    }
}


#Preview {
    TabBar()
}





// id, title, description,  category, price, isFavorite, discount(isInDeal)(DiscountPrice), shippingInformation, thumbnail
