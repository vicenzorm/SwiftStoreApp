//
//  TabBar.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 14/08/25.
//

import SwiftUI

struct TabBar: View {
    
    let productViewModelService = ShopViewModel(service: ShopService())
//    let userViewModelService = UserViewModel(service: )
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                NavigationStack {
                    HomeView(viewModel: productViewModelService)
                }
            }
            Tab("Categories", systemImage: "square.grid.2x2.fill") {
                NavigationStack {
                    CategoriesVIew(viewModel: ShopViewModel(service: ShopService()))
                }
            }
            Tab("Cart", systemImage: "cart.fill") {
                NavigationStack {
                    CartView(viewModel: UserViewModel(service: UserService()))
                }
            }
            Tab("Favorites", systemImage: "heart.fill") {
                NavigationStack {
                    FavoritesView(viewModel: UserViewModel(service: UserService()))
                }
            }
            Tab("Orders", systemImage: "bag.fill") {
                NavigationStack {
                    OrdersView()
                }
            }
        }
    }
}

#Preview {
    TabBar()
}
