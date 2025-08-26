//
//  OrdersView.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 14/08/25.
//
import SwiftUI

struct OrdersView: View {
    
    // 3. Use @StateObject para gerenciar o ciclo de vida da ViewModel
    @State var viewModel: OrdersViewModel
    
    @State private var searchText: String = ""
    
    // 2. A lógica da lista foi extraída para uma propriedade computada
    private var ordersList: some View {
        VStack(spacing: 8) {
            ForEach(viewModel.orders) { order in
                ProductCardList(cardType: .order, order: order)
            }
        }
    }
    
    var body: some View {
        // A View agora tem uma estrutura principal mais simples
        VStack {
            if viewModel.orders.isEmpty {
                EmptyState(
                    icon: "bag.badge.questionmark",
                    title: "No orders yet!",
                    subtitle: "Buy an item and it will show up here."
                )
            } else {
                ScrollView {
                    ordersList
                }
            }
            
        }
        // 1. A ScrollView interna foi removida
        .navigationTitle("Orders")
        .searchable(text: $searchText, prompt: "Search")
        .onAppear {
            Task { await viewModel.loadOrders() }
        }
        .onChange(of: searchText) { _, newValue in
            // Corrigindo a chamada da função para a de filtro de pedidos
            viewModel.filterOrders(textToSearch: newValue)
        }
    }
}

#Preview {
    TabBar()
}
