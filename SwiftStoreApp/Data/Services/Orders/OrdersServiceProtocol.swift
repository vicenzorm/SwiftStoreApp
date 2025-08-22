//
//  OrdersServiceProtocol.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 21/08/25.
//

import Foundation

@MainActor
protocol OrdersServiceProtocol {
    func getAllOrders() -> [Order]
    func getOrder(byId: Int) -> Order?
}
