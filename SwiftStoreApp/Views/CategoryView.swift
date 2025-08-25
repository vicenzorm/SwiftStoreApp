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
    
    // MARK: - Estados
    /// Texto digitado no campo de busca
    @State var searchText: String = ""
    
    // MARK: - ViewModels
    /// ViewModel que gerencia produtos e categorias da loja
    /// ViewModel do usuário (para adicionar ao carrinho, favoritos, etc.)
    var viewModel: APIViewModel
    /// Categoria selecionada
    var category: Category
    
    // MARK: - Layout
    /// Configuração das colunas do grid de produtos
    var collumns: [GridItem] = [
        GridItem(.fixed(177), spacing: 8),
        GridItem(.fixed(177), spacing: 8)
    ]
    
    // MARK: - Computed Properties
    /// Lista de produtos filtrados pelo texto de busca
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return viewModel.filteredProdcuts
        } else {
            return viewModel.filteredProdcuts.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
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
                        ForEach(filteredProducts) { product in
//                            ProductCardVertical()
                        }
                    }
                }
                .padding()
                .navigationTitle(category.name)
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $searchText) // Campo de busca
            }
        }
        .task {
            // Limpa produtos antigos antes de carregar a nova categoria
            viewModel.filteredProdcuts = []
            await viewModel.loadProductsByCategories(category: category.slug)
        }
    }
}

#Preview {
//    CategoryView(viewModel: ShopViewModel(service: ShopService()), category: Category(name: "Food", slug: "food"))
}
