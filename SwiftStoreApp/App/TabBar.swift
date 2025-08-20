//
//  TabBar.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 14/08/25.
//

import SwiftUI

struct TabBar: View {

    @Environment(\.modelContext) var modelContext

    let productViewModelService = ShopViewModel(service: ShopService())
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                NavigationStack {
                    HomeView(viewModel: productViewModelService,
                             userViewModel: UserViewModel(service: UserService(modelContext: modelContext)))
                }
            }
            Tab("Categories", systemImage: "square.grid.2x2.fill") {
                NavigationStack {
                    CategoriesView(viewModel: ShopViewModel(service: ShopService()), userViewModel: UserViewModel(service: UserService(modelContext: modelContext)))
                }
            }
            Tab("Cart", systemImage: "cart.fill") {
                NavigationStack {
                    CartView(viewModel: UserViewModel(service: UserService(modelContext: modelContext)))
                }
            }
            Tab("Favorites", systemImage: "heart.fill") {
                NavigationStack {
                    FavoritesView(viewModel: UserViewModel(service: UserService(modelContext: modelContext)))
                }
            }
            Tab("Orders", systemImage: "bag.fill") {
                NavigationStack {
                    OrdersView(viewModel: UserViewModel(service: UserService(modelContext: modelContext)))
                }
            }
            
        }
    }
}

#Preview {
    TabBar()
}
