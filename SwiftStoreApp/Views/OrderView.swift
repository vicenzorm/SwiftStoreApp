//
//  CategoriesVIew.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 14/08/25.
//

import SwiftUI

struct OrdersView: View {
    
    @State var textToSearch: String = ""
    let teste: Bool = true
    
    var body: some View {
        VStack{
            if teste {
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
