import Foundation
import SwiftUI

protocol HomeViewModelProtocol {
    var products: [Product] { get set }
    var isLoadingProducts: Bool { get set }
    var errorMessage: String? { get set }
    var isFavorited: Bool { get set }
    var selectedProduct: Product? { get set }
    
    func loadProducts() async
    func isProductFavorite(product: Product) -> Binding<Bool>
    func addToFavorites(product: Product)
}
