//
//  OrdersView.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 14/08/25.
//

import SwiftUI

/// Tela responsável por exibir os pedidos do usuário.
/// - Permite busca por pedidos pelo título do produto.
/// - Mostra uma lista de produtos comprados ou um estado vazio caso não haja pedidos.
struct OrdersView: View {
    
    /// Texto digitado no campo de busca
    @State var textToSearch: String = "" // Futuramente pode ser movido para a ViewModel
    
    /// ViewModel que gerencia os produtos do usuário
    var viewModel: UserViewModel
    
    /// Lista de pedidos filtrada de acordo com o texto de busca
    var filteredOrders: [UserProduct] {
        if textToSearch.isEmpty {
            return viewModel.orderedProducts
        } else {
            return viewModel.orderedProducts.filter {
                $0.title.localizedCaseInsensitiveContains(textToSearch)
            }
        }
    }
    
    var body: some View {
        ScrollView {
            
            // Caso não haja pedidos
            if filteredOrders.isEmpty {
                EmptyState(
                    icon: "bag.badge.questionmark",
                    title: "No orders yet!",
                    subtitle: "Buy an item and it will show up here."
                )
                
            // Caso haja pedidos
            } else {
                VStack(spacing: 16) {
                    // Lista todos os pedidos filtrados
                    ForEach(filteredOrders) { order in
                        ProductCardList(product: order, cardType: .order)
                    }
                }
            }
        }
        .navigationTitle("Orders")
        .searchable(text: $textToSearch, prompt: "Search") // Campo de busca
        .onAppear {
            // Atualiza a lista de pedidos ao aparecer a tela
            viewModel.orderedProducts = viewModel.getOrderedProducts()
        }
    }
}

#Preview {
    TabBar()
}
