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

    // MARK: - View
    var body: some View {
        NavigationStack {
            
            // Exibe indicador de carregamento enquanto produtos são buscados
            if viewModel.isLoadingProducts {
                ProgressView()
                
            // Exibe produtos quando disponíveis
            } else {
                ScrollView {
                    LazyVGrid(columns: collumns) {
                        ForEach(viewModel.filteredProducts) { product in
                            ProductCardVertical(product: product, isFavorited: $viewModel.isFavorited) {
                                viewModel.toggleFavorite(product: product)
                            }
                        }
                    }
                }
                .padding()
                .navigationTitle(viewModel.category.name)
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $viewModel.searchText, prompt: "Search") // Campo de busca
            }
        }
        .task {
            await viewModel.loadProductsByCategories(category: viewModel.category.slug)
            await viewModel.loadFavoriteProducts()
        }
    }
}

#Preview {
//    CategoryView(viewModel: ShopViewModel(service: ShopService()), category: Category(name: "Food", slug: "food"))
}
