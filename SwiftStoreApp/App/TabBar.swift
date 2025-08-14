//
//  TabBar.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 14/08/25.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                NavigationStack {
                    
                }
            }
            Tab("Categories", systemImage: "square.grid.2x2.fill") {
                NavigationStack {
                    
                }
            }
            Tab("Cart", systemImage: "cart.fill") {
                NavigationStack {
                    
                }
            }
            Tab("Favorites", systemImage: "heart.fill") {
                NavigationStack {
                    
                }
            }
            Tab("Orders", systemImage: "bag.fill") {
                NavigationStack {
                    
                }
            }
        }
    }
}

#Preview {
    TabBar()
}
