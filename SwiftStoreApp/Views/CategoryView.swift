//
//  CategoryView.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 18/08/25.
//

import SwiftUI

struct CategoryView: View {
    
    @State var searchText: String = ""
    
    var viewModel: ShopViewModel
    var category: Category
    
    var collumns: [GridItem] = [
        GridItem(.fixed(177), spacing: 8),
        GridItem(.fixed(177), spacing: 8)
    ]
    
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return viewModel.filteredProdcuts
        } else {
            return viewModel.filteredProdcuts.filter {$0.title.localizedCaseInsensitiveContains(searchText)}}
    }
    
    var body: some View {
        NavigationStack {
            
            if viewModel.isLoadingCategories {
                ProgressView()
            } else {
                ScrollView {
                    LazyVGrid(columns: collumns) {
                        ForEach(filteredProducts) { product in
                            ProductCardVertical(product: product)
                        }
                    }
                }
                .padding()
                .navigationTitle(category.name)
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $searchText)
            }
            
        }
        .task {
            await viewModel.loadProductsByCategories(category: category.name)
        }
    }
}



#Preview {
    CategoryView(viewModel: ShopViewModel(service: ShopService()), category: Category(name: "Food", slug: "food"))
}
