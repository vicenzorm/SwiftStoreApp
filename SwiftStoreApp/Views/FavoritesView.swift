//
//  CategoriesVIew.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 14/08/25.
//

import SwiftUI

struct FavoritesView: View {
    
    @State var textToSearch: String = ""
    var teste: Bool = true
    
    var body: some View {
        
        VStack{
            //if user.cartList.isEmpty {
            if teste {
                EmptyState(icon: "heart.slash", title: "No favorites yet!", subtitle: "Favorite an item and it will show up here.")
            }
        }
        .navigationTitle("Favorites")
        .searchable(text: $textToSearch, prompt: "Search" )
        
    }
}

#Preview {
    TabBar()
}
