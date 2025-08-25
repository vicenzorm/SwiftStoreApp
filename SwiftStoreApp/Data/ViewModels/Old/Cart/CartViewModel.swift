

import Foundation
import SwiftData

@MainActor
@Observable
class CartViewModel {
    var cartItems: [Product] = []
    private var cart: [Cart] = []
    
    let apiService: APIService = .shared
    private let cartService = CartService()
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        print("CartViewModel inicializado. Carregando carrinho...")
    }
    
    private func saveChanges() {
        print("Tentando salvar mudanças no ModelContext...")
        do {
            try modelContext.save()
            print("✅ Mudanças salvas com sucesso!")
            loadCart()
        } catch {
            print("🚨 ERRO ao salvar o model context: \(error.localizedDescription)")
        }
    }
    
    func loadCart() {
        self.cart = cartService.fetchCart(modelContext: modelContext)
        print("🛒 Carrinho local carregado. Itens no banco de dados: \(self.cart.count)")
        
        Task {
            await fetchProductsFullDetails()
        }
    }
    
    func fetchProductsFullDetails() async {
        var cartProducts: [Product] = []
        print("Buscando detalhes completos dos produtos na API...")
        for item in cart {
            do {
                let product = try await apiService.getProduct(byId: item.id)
                product.quantity = item.quantity
                cartProducts.append(product)
            } catch {
                print("🚨 ERRO ao buscar detalhes do produto com id \(item.id): \(error)")
            }
        }
        self.cartItems = cartProducts
        print("✅ Detalhes de \(self.cartItems.count) produtos carregados. UI será atualizada.")
    }
    
    func addToCart(productId: Int) {
        print("Adicionando produto \(productId) ao carrinho...")
        cartService.addToCart(productId: productId, modelContext: modelContext)
        saveChanges()
    }
    
    func removeFromCart(productId: Int) {
        print("Removendo produto \(productId) do carrinho...")
        cartService.removeFromCart(productId: productId, modelContext: modelContext)
        saveChanges()
    }
    
    func updateQuantity(productId: Int, newQuantity: Int) {
        print("Atualizando quantidade do produto \(productId) para \(newQuantity)...")
        cartService.updateQuantity(productId: productId, newQuantity: newQuantity, modelContext: modelContext)
        saveChanges()
    }
    
    func getCartTotalPrice() -> Double {
        return cartItems.reduce(0.0) { total, item in
            total + (item.price * Double(item.quantity))
        }
    }
    
    func clearCart() {
        print("Limpando todos os itens do carrinho...")
        cartService.clearCart(modelContext: modelContext)
    
        do {
            try modelContext.save()
            print("✅ Contexto salvo após limpar o carrinho.")
        } catch {
            print("🚨 ERRO ao salvar após limpar o carrinho: \(error.localizedDescription)")
        }
        
        self.cartItems = []
        self.cart = []
    }
}
