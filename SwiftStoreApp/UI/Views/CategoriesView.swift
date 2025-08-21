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
    
    // MARK: - ViewModels
    
    /// ViewModel principal responsável pelas categorias e produtos.
    
    /// ViewModel do usuário, usado para interações que dependem do estado do usuário.
    var viewModel: APIViewModel
    var userViewModel: UserViewModel
    
    // MARK: - Estados
    
    /// Texto digitado pelo usuário na barra de busca.
    @State private var searchableText: String = ""
    
    // MARK: - Computed Properties
    
    /// Lista de categorias filtradas de acordo com o texto buscado.
    var filteredCategories: [Category] {
        if searchableText.isEmpty {
            return viewModel.categories
        } else {
            return viewModel.categories.filter { $0.name.localizedCaseInsensitiveContains(searchableText) }
        }
    }
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoadingCategories {
                /// Indicador de carregamento
                ProgressView()
                
            } else if let errorMessage = viewModel.errorMessage {
                /// Exibe mensagem de erro caso algo falhe
                Text(errorMessage)
                
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
                    List(filteredCategories) { category in
                        NavigationLink {
                            CategoryView(
                                viewModel: viewModel,
                                userViewModel: userViewModel,
                                category: category
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
                .searchable(text: $searchableText, prompt: "Search")
            }
        }
        .task {
            /// Carrega categorias ao aparecer a tela
            await viewModel.loadCategories()
        }
    }
}

