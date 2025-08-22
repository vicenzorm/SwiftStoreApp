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
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    static let shared = OrdersService()
    
    private init() {
        self.modelContainer = try! ModelContainer(for: Order.self)
        self.modelContext = modelContainer.mainContext
    }
    
    func getAllOrders() -> [Order] {
        do {
            return try modelContext.fetch(FetchDescriptor<Order>())
        } catch {
            fatalError(error.localizedDescription)
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
        }
    }
    
}
