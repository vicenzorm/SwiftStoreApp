

import Foundation
import SwiftData

@MainActor
class CartService {
    
    func fetchCart(modelContext: ModelContext) -> [Cart] {
        do {
            return try modelContext.fetch(FetchDescriptor<Cart>(sortBy: [SortDescriptor(\.id)]))
        } catch {
            print("Error fetching cart: \(error.localizedDescription)")
            return []
        }
    }
    
    func addToCart(productId: Int, modelContext: ModelContext) {
        let predicate = #Predicate<Cart> { $0.id == productId }
        let description = FetchDescriptor<Cart>(predicate: predicate)
        
        do {
            if let existingItem = try modelContext.fetch(description).first {
                existingItem.quantity += 1
            } else {
                let newCartItem = Cart(id: productId, quantity: 1)
                modelContext.insert(newCartItem)
            }
        } catch {
            print("failed to add to cart: \(error.localizedDescription)")
        }
    }
    
    func removeFromCart(productId: Int, modelContext: ModelContext) {
        let predicate = #Predicate<Cart> { $0.id == productId }
        let description = FetchDescriptor<Cart>(predicate: predicate)
        
        do {
            if let productToDelete = try modelContext.fetch(description).first {
                modelContext.delete(productToDelete)
            }
        } catch {
            print("failed to delete from cart: \(error.localizedDescription)")
        }
    }
    
    func updateQuantity(productId: Int, newQuantity: Int, modelContext: ModelContext) {
        let predicate = #Predicate<Cart> { $0.id == productId }
        let descriptor = FetchDescriptor<Cart>(predicate: predicate)
        
        do {
            if let productToUpdate = try modelContext.fetch(descriptor).first {
                if newQuantity <= 0 {
                    modelContext.delete(productToUpdate)
                } else {
                    productToUpdate.quantity = newQuantity
                }
            }
        } catch {
            print("error updating cart quantity: \(error.localizedDescription)")
        }
    }
    
    func clearCart(modelContext: ModelContext) {
        do {
            try modelContext.delete(model: Cart.self)
        } catch {
            print("Erro ao limpar o carrinho: \(error.localizedDescription)")
        }
    }
}
