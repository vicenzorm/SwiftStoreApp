//
//  CategoryView.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 18/08/25.
//

import SwiftUI

/// Tela que exibe os produtos de uma categoria específica.
/// - Permite buscar produtos pelo nome.
/// - Mostra os produtos em um grid de duas colunas.
/// - Exibe um indicador de carregamento enquanto os produtos são carregados.
struct CategoryView: View {
    
    // MARK: - ViewModel
    @State var viewModel: CategoryViewModel
    
    // MARK: - Layout
    /// Configuração das colunas do grid de produtos
    var collumns: [GridItem] = [
        GridItem(.fixed(177), spacing: 8),
        GridItem(.fixed(177), spacing: 8)
    ]
    
    var iPadcollumns: [GridItem] = [
        GridItem(.fixed(177), spacing: 16),
        GridItem(.fixed(177), spacing: 16),
        GridItem(.fixed(177), spacing: 16),
        GridItem(.fixed(177), spacing: 16),
        GridItem(.fixed(177), spacing: 16)
    ]
    
    // MARK: - View
    var body: some View {
        Group {
            if viewModel.isLoadingProducts {
                ProgressView()
            } else {
                ScrollView {
                    
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        LazyVGrid(columns: iPadcollumns) {
                            ForEach(viewModel.filteredProducts) { product in
                                ProductCardVertical(product: product, isFavorited: viewModel.isProductFavorite(product: product)) {
                                    viewModel.toggleFavorite(product: product)
                                }
                                .onTapGesture {
                                    viewModel.selectedProduct = product
                                }
                            }
                        }
                    } else {
                        LazyVGrid(columns: collumns) {
                            ForEach(viewModel.filteredProducts) { product in
                                ProductCardVertical(product: product, isFavorited: viewModel.isProductFavorite(product: product)) {
                                    viewModel.toggleFavorite(product: product)
                                }
                                .onTapGesture {
                                    viewModel.selectedProduct = product
                                }
                            }
                        }
                    }
                    
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.category.name)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $viewModel.searchText, prompt: "Search")
        .task {
            await viewModel.loadProductsByCategories(category: viewModel.category.slug)
            await viewModel.loadFavoriteProducts()
        }
        .sheet(item: $viewModel.selectedProduct){ product in
            DetailsView(viewModel: DetailsViewModel(apiService: APIService.shared, favoritesService: Persistence.shared.favoriteService, cartService: Persistence.shared.cartService, isFavorite: viewModel.isProductFavorite(product: product)), product: product)
        }
    }
}


#Preview {
    //    CategoryView(viewModel: ShopViewModel(service: ShopService()), category: Category(name: "Food", slug: "food"))
}
