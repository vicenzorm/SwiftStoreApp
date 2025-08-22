//
//  CartService.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 21/08/25.
//

import Foundation
import SwiftData

@MainActor
class CartService {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    static let shared = CartService()
    
    init() {
        self.modelContainer = try! ModelContainer(for: Cart.self)
        self.modelContext = modelContainer.mainContext
    }
    
    func fetchCart() -> [Cart] {
        do {
            return try modelContext.fetch(FetchDescriptor<Cart>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addToCart(productId: Int){
        let newProductToCart = Cart(id: productId, quantity: 1)
        modelContext.insert(newProductToCart)
        do{
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func removeFromCart(productId: Int){
        let productToRemove = fetchCart().first(where: { $0.id == productId })!
        modelContext.delete(productToRemove)
        do{
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func updateQuantity(productId: Int, newQuantity: Int){
        if let productToUpdate = fetchCart().first(where: { $0.id == productId }) {
            productToUpdate.quantity = newQuantity
            do{
                try modelContext.save()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
