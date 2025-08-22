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
        do {
            self.modelContainer = try ModelContainer(for: Cart.self)
            self.modelContext = modelContainer.mainContext
        } catch {
            fatalError()
        }
    }
    
    func fetchCart() -> [Cart] {
        do {
            return try modelContext.fetch(FetchDescriptor<Cart>(sortBy: [SortDescriptor(\.id)]))
        } catch {
            print("Error fetching cart: \(error.localizedDescription)")
            return []
        }
    }
    
    func addToCart(productId: Int){
        let predicate = #Predicate<Cart> { $0.id == productId }
        let description = FetchDescriptor<Cart>(predicate: predicate)
        
        do{
            if let existingDay = try modelContext.fetch(description).first {
                existingDay.quantity += 1
            } else {
                let newCartItem = Cart(id: productId, quantity: 1)
                modelContext.insert(newCartItem)
            }
            
            try modelContext.save()
            
        } catch {
            print("failed to save to cart: \(error.localizedDescription)")
        }
    }
    
    func removeFromCart(productId: Int){
        let predicate = #Predicate<Cart> { $0.id == productId }
        let description = FetchDescriptor<Cart>(predicate: predicate)
        
        do {
            if let productToDelete = try modelContext.fetch(description).first {
                modelContext.delete(productToDelete)
                try modelContext.save()
            }
        } catch {
            print("failed to delete from cart: \(error.localizedDescription)")
        }
    }
    
    func updateQuantity(productId: Int, newQuantity: Int){
        let predicate = #Predicate<Cart> { $0.id == productId }
        let descriptor = FetchDescriptor<Cart>(predicate: predicate)
        
        do {
            if let productToUpdate = try modelContext.fetch(descriptor).first {
                if newQuantity <= 0 {
                    modelContext.delete(productToUpdate)
                } else {
                    productToUpdate.quantity = newQuantity
                }
                try modelContext.save()
            }
        } catch {
            print("error updating cart quantity: \(error.localizedDescription)")
        }
    }
    
    func clearCart() {
        let cartItems = fetchCart()
          
          for item in cartItems {
              modelContext.delete(item)
          }
          
          do {
              try modelContext.save()
          } catch {
              print("Erro ao salvar a deleção do carrinho: \(error.localizedDescription)")
          }
    }
}
