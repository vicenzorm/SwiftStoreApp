//
//  ContentView.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 13/08/25.
//

import SwiftUI
import SwiftData

/// Tela inicial do aplicativo, mostrando produtos em destaque e sugestões do dia.
/// - Exibe uma seção "Deals of the day" com um produto aleatório em promoção.
/// - Exibe uma seção "Top Picks" com todos os produtos disponíveis em um grid.
/// - Carrega os produtos ao aparecer a tela.
struct HomeView: View {
    
    let viewModel: APIViewModel
    // MARK: - ViewModels
    /// ViewModel que gerencia produtos e categorias da loja
    /// ViewModel do usuário (para adicionar ao carrinho, favoritos, etc.)
    //let userViewModel: UserViewModel
    
    // MARK: - Layout
    /// Configuração das colunas do grid de produtos
    let colunas: [GridItem] = [
        GridItem(.fixed(177), spacing: 8),
        GridItem(.fixed(177), spacing: 8)
    ]
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                
                // MARK: Seção: Deals of the Day
                VStack(alignment: .leading, spacing: 8) {
                    Text("Deals of the day")
                        .font(.system(size: 22, weight: .bold))
                        .font(.title2)
                    
//                    ProductCardDeal(
//                        viewModel: userViewModel,
//                        product: viewModel.products.randomElement(),
//                        productFavorite: false
//                    )
                }
                
                // MARK: Seção: Top Picks
                VStack(alignment: .leading, spacing: 8) {
                    Text("Top Picks")
                        .font(.system(size: 22, weight: .bold))
                        .font(.title2)
                    
                    ScrollView {
                        LazyVGrid(columns: colunas) {
                            // Lista todos os produtos no grid
                            ForEach(viewModel.products) { product in
                                ProductCardVertical(viewModel: userViewModel, product: product)
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Home")
            .frame(maxHeight: .infinity, alignment: .top)
            .task {
                // Carrega todos os produtos ao aparecer a tela
                await viewModel.loadProducts()
            }
        }
    }
}

#Preview {
    TabBar()
}
