//
//  CategoriesView.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 14/08/25.
//

import SwiftUI

/// Tela responsável por exibir as categorias disponíveis.
/// - Permite busca por categorias.
/// - Mostra um preview com até 4 categorias em cards.
/// - Exibe lista completa das categorias com navegação para a tela `CategoryView`.
struct CategoriesView: View {
    
    // MARK: - ViewModel
    
    /// ViewModel principal responsável pelas categorias.
    @State var viewModel: CategoriesViewModel
    
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoadingCategories {
                /// Indicador de carregamento
                ProgressView()
                
            } else {
                /// Conteúdo principal
                VStack {
                    
                    // MARK: Destaques iniciais (primeiras 4 categorias)
                    HStack(spacing: 8) {
                        ForEach(Array(viewModel.categories.shuffled().prefix(4))) { category in
                            CardCategory(category: category)
                        }
                    }
                    .padding(.top)
                    
                    // MARK: Lista de categorias
                    List(viewModel.filteredCategories) { category in
                        NavigationLink {
                            CategoryView(
                                viewModel: CategoryViewModel(category: category)
                            )
                        } label: {
                            HStack {
                                Text(category.name)
                                Spacer()
                            }
                            .frame(height: 60)
                        }
                    }
                    .listStyle(.plain)
                }
                .padding()
                .frame(maxHeight: .infinity, alignment: .top)
                .navigationTitle("Categories")
                .searchable(text: $viewModel.searchText, prompt: "Search")
            }
        }
        .task {
            /// Carrega categorias ao aparecer a tela
            await viewModel.loadCategories()
        }
    }
}

