//
//  CategorieViewModelProtocol.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 25/08/25.
//

import Foundation

@MainActor
protocol CategoryViewModelProtocol: Observable {
    // estado base
    var category: Category { get }
    var isLoadingProducts: Bool { get set }
    var errorMessage: String? { get set }

    // produtos da categoria
    var productsByCategorie: [Product] { get set }   // mantém o mesmo nome que já usas
    var searchText: String { get set }
    var filteredProducts: [Product] { get }          // derivado
    var selectedProduct: Product? { get set }

    // favoritos
    var favoriteProducts: [Product] { get set }
    func loadFavoriteProducts() async
    func addToFavorites(product: Product)
    func isProductFavorite(product: Product) -> Bool
    func toggleFavorite(product: Product)

    // dados remotos
    func loadProductsByCategories(category: String) async
}
