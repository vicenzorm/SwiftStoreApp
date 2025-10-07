//
//  TabBar.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 14/08/25.
//

import SwiftUI

struct TabBar: View {

    @Environment(\.modelContext) var modelContext

    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                NavigationStack {
                    HomeView()
                }
            }
            Tab("Categories", systemImage: "square.grid.2x2.fill") {
                NavigationStack {
                    CategoriesView(viewModel: CategoriesViewModel())
                }
            }
            Tab("Cart", systemImage: "cart.fill") {
                NavigationStack {
                    CartView(viewModel: CartViewModel(apiservice: APIService.shared, cartService: Persistence.shared.cartService, orderService: Persistence.shared.orderService))
                }
            }
            Tab("Favorites", systemImage: "heart.fill") {
                NavigationStack {
                    FavoritesView(viewModel: FavoritesViewModel(favoritesService: Persistence.shared.favoriteService, productService: APIService.shared))
                }
            }
            Tab("Orders", systemImage: "bag.fill") {
                NavigationStack {
                    OrdersView(viewModel: OrdersViewModel(apiService: APIService.shared, orderService: Persistence.shared.orderService))
                }
            }
            
        }
    }
}

#Preview {
    TabBar()
}
