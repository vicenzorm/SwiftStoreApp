import Foundation
import SwiftData

@MainActor
protocol CartServiceProtocol {
    func fetchCart() -> [Cart]
    func addToCart(productId: Int)
    func removeFromCart(productId: Int)
    func updateQuantity(productId: Int, newQuantity: Int)
    func clearCart()
}
