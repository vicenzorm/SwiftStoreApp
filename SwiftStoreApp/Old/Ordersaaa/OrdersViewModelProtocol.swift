//
//  OrdersViewModel.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 21/08/25.
//

import Foundation

@MainActor
protocol OrdersViewModelProtocolaaaaa {
    var orders: [Order] { get }
    func loadOrders() async
    func filterOrders(textToSearch: String)
}
