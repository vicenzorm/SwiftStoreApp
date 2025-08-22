//
//  OrdersViewModel.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 21/08/25.
//

import Foundation

protocol OrdersViewModelProtocol {
    var orders: [Favorite] { get }
    func getOrderById(id: Int) -> Favorite?
    func loadOrders() async
    func filterOrders(textToSearch: String)
}
