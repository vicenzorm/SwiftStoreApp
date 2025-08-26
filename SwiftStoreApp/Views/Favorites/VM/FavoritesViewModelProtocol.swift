import Foundation

protocol FavoritesViewModelProtocol {
    var favoriteProducts: [Product] { get set }
    var selectedProduct: Product? { get set }
    var searchText: String { get set }
    var filteredFavorite: [Product] { get }
    
    func loadFavoriteProducts() async
    func addToFavorites(product: Product)
    func isProductFavorite(product: Product) -> Bool
    func toggleFavorite(product: Product)
}
