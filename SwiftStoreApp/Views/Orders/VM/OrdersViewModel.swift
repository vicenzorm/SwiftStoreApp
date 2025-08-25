//
//  OrdersViewModel.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 25/08/25.
//

import Foundation

class OrdersViewModel: OrdersViewModelProtocol {
    var orders: [Order] = []
    
    private let orderService: OrdersService

    init(orderService: OrdersService) {
        self.orderService = orderService
    }
    
    @MainActor
    func loadOrders() {
        orders = orderService.getAllOrders()
    }
    
    func filterOrders(textToSearch: String) -> [Order] {
        if textToSearch.isEmpty {
            return orders
        } else {
            return orders.filter { order in
                order.name.localizedCaseInsensitiveContains(textToSearch)
            }
        }
    }
}
