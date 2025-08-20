//
//  CategoriesVIew.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 14/08/25.
//

import SwiftUI

struct OrdersView: View {
    
    @State var textToSearch: String = "" // colocar em view model
    var viewModel: UserViewModel
//    
//    var filteredProducts: [UserProduct] {
//        if searchableText.isEmpty {
//            return viewModel.categories
//        } else {
//            return viewModel.categories.filter({$0.name.localizedCaseInsensitiveContains(searchableText)})
//        }
//    }
    
    var body: some View {
        VStack{
            if true {
                EmptyState(icon: "bag.badge.questionmark", title: "No orders yet!", subtitle: "Buy an item and it will show up here.")
            }            
        }
        .navigationTitle("Orders")
        .searchable(text: $textToSearch, prompt: "Search" )
    }
}

#Preview {
    TabBar()
}
