//
//  OrdersViewModel.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 25/08/25.
//

import Foundation

@Observable
@MainActor
class OrdersViewModel: OrdersViewModelProtocol {
    var orders: [Product] = []
    var ordersId: [Order] = []
    
    private let orderService: OrdersService = Persistence.shared.orderService
    private let apiService: APIService = .shared
    
    var isLoading: Bool = false
    var textToSearch: String = ""
    
    var filteredOrders: [Product] {
        if textToSearch.isEmpty {
            return orders
        } else {
            return orders.filter({ $0.title.localizedCaseInsensitiveContains(textToSearch) })
        }
    }
    
    @MainActor
    func loadOrders() async {
        isLoading = true
        
        ordersId = orderService.getAllOrders()
        orders.removeAll()
        
        for order in ordersId {
            do {
                try await orders.append(apiService.getProduct(byId: order.id))
            } catch {
                orders = []
            }
        }
        
        isLoading = false
    }
}
