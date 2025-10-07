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
    
    var body: some View {
        // A View agora tem uma estrutura principal mais simples
        VStack {
            if viewModel.orders.isEmpty {
                EmptyState(
                    icon: "bag.badge.questionmark",
                    title: viewModel.title,
                    subtitle: viewModel.subtitle
                )
            } else {
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(viewModel.filteredOrders) { order in
                            ProductCardList(cardType: .order, product: order)
                        }
                    }
                }
            }
            
        }
        // 1. A ScrollView interna foi removida
        .navigationTitle("Orders")
        .searchable(text: $viewModel.textToSearch, prompt: "Search")
        .onAppear {
            Task { await viewModel.loadOrders() }
        }
    }
}

#Preview {
    TabBar()
}
