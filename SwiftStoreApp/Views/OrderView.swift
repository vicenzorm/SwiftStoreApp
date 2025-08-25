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
    
    /// ViewModel que gerencia os produtos do usuário
    @State var viewModel: OrdersViewModel
    
    @State private var searchText: String = ""
    
    var body: some View {
        ScrollView {
            
            // Caso não haja pedidos
            if viewModel.orders.isEmpty {
                EmptyState(
                    icon: "bag.badge.questionmark",
                    title: "No orders yet!",
                    subtitle: "Buy an item and it will show up here."
                )
            } else {
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(viewModel.orders) { order in
                            ProductCardList(order: order, cardType: .order)
                        }
                    }
                }
            }
        }
        .navigationTitle("Orders")
        .searchable(text: $searchText, prompt: "Search")
        .onAppear {
            Task { await viewModel.loadOrders() }
        }
    }
}

#Preview {
    TabBar()
}
