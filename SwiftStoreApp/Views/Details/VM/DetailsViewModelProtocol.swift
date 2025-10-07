import Foundation

@MainActor
protocol DetailsViewModelProtocol {
    var isLoadingProduct: Bool { get }
    var errorMessage: String? { get }
    var isFavorited: Bool { get set }

    func isProductFavorite(product: Product) -> Bool
    func addToCart(product: Product)
    func addToFavorites(product: Product)
}
