//
//  OrdersMock.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 28/08/25.
//

import Foundation
@testable import SwiftStoreApp

class OrdersServiceMock: OrdersServiceProtocol {
    
    var orders: [Order] = [Order(id: 1), Order(id: 2)]
    var shouldFail: Bool
    
    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
    }
    
    func getAllOrders() -> [SwiftStoreApp.Order] {
        if shouldFail {
            return []
        } else {
            return orders
        }
    }
    
    func getOrder(byId: Int)  -> SwiftStoreApp.Order? {
        if shouldFail {
            return nil
        } else {
            return orders.first(where: { $0.id == byId })
        }
    }
    
    func createOrder(productsId: [Int])  {
        if !shouldFail {
            orders.append(Order(id: orders.count + 1))
              
        } 
    }
    
    
}
