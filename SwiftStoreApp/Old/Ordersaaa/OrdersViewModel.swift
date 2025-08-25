//
//  OrdersViewModel.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 21/08/25.
//

import Foundation

@Observable
@MainActor
class OrdersaaaaViewModel: OrdersViewModelProtocolaaaaa {
    var orders: [Order] = []
    private var allOrders: [Order] = []
    
    private let ordersService: OrdersServiceProtocol
    
    init(ordersService: OrdersServiceProtocol) {
        self.ordersService = ordersService
    }
    
    func loadOrders() async {
        let allFetchedOrders = ordersService.getAllOrders()
        self.allOrders = allFetchedOrders
        self.orders = allFetchedOrders
    }
    
    func filterOrders(textToSearch: String) {
        if textToSearch.isEmpty {
            orders = allOrders
        } else {
            orders = allOrders.filter {
                $0.name.lowercased().contains(textToSearch.lowercased())
            }
        }
    }
}
