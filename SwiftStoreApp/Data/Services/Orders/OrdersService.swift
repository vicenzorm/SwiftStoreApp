//
//  OrdersService.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 21/08/25.
//

import Foundation
import SwiftData

@MainActor
class OrdersService: OrdersServiceProtocol {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func getAllOrders() -> [Order] {
        do {
            return try modelContext.fetch(FetchDescriptor<Order>())
        } catch {
            return []
        }
    }
    
    func getOrder(byId: Int) -> Order? {
        let predicate = #Predicate<Order> { $0.id == byId }
        var descriptor = FetchDescriptor(predicate: predicate)
        descriptor.fetchLimit = 1
        
        do {
            return try modelContext.fetch(descriptor).first
        } catch {
            print("erro ao dar fetch na order")
            return nil
        }
    }
    
    func createOrder(productsId: [Int]) {
        
        var newOrder: [Order] = []
        
        for id in productsId {
            newOrder.append(Order(id: id))
        }
        
        for order in newOrder {
            modelContext.insert(order)
        }
        
        do {
            try modelContext.save()
        } catch {
            print("erro ao salvar order")
        }
        
    }
}
