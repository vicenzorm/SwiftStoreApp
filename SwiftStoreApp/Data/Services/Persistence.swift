//
//  Persistence.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 26/08/25.
//

import SwiftUI
import SwiftData

@MainActor
class Persistence {
    
    let modelContainer: ModelContainer
    let modelContext: ModelContext
    
    var favoriteService: FavoritesServiceProtocol
    var orderService: OrdersServiceProtocol
    var cartService: CartServiceProtocol
    
    static var shared = Persistence()
    
    private init() {
        self.modelContainer = try! ModelContainer(for: Favorite.self, Cart.self, Order.self)
        self.modelContext = modelContainer.mainContext
        
        self.favoriteService = FavoritesService(modelContext: modelContext)
        self.orderService = OrdersService(modelContext: modelContext)
        self.cartService = CartService(modelContext: modelContext)
    }
}
