import SwiftUI
import SwiftData

/// Tela responsável por exibir o carrinho de compras do usuário.
/// - Mostra uma lista de produtos no carrinho.
/// - Permite visualizar o total da compra.
/// - Permite finalizar a compra (Checkout) e limpar o carrinho.
struct CartView: View {
    
    /// ViewModel que gerencia os produtos do usuário e o carrinho
    var viewModel: UserViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                
                // Caso o carrinho esteja vazio
                if viewModel.productsOnCart.isEmpty {
                    Spacer() // Centraliza verticalmente
                    EmptyState(
                        icon: "cart.badge.questionmark",
                        title: "Your Cart is Empty!",
                        subtitle: "add an item to your cart"
                    )
                    Spacer()
                    
                // Caso o carrinho tenha produtos
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            // Lista todos os produtos no carrinho
                            ForEach(viewModel.productsOnCart) { product in
                                ProductCardList(product: product, cardType: .cart)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .top)
                    }
                    
                    // Área de resumo do carrinho: total e botão de checkout
                    VStack(spacing: 16) {
                        HStack {
                            Text("Total:")
                                .font(.subheadline)
                            Spacer()
                            Text(
                                Formatters.paraDolarAmericano.string(
                                    from: NSNumber(value: viewModel.getCartTotalPrice())
                                ) ?? "US$: 00,00"
                            )
                            .font(.subheadline)
                        }
                        
                        // Botão de Checkout
                        Button {
                            viewModel.addToOrder()
                            
                            // Limpa o carrinho
                            for product in viewModel.productsOnCart {
                                product.quantity = 0
                                product.isOnCart = false
                            }
                            viewModel.productsOnCart.removeAll()
                                
                        } label: {
                            Text("Checkout")
                                .foregroundStyle(.labelsPrimary)
                                .frame(maxWidth: .infinity)
                        }
                        .frame(height: 54)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundStyle(.fillsTertiary)
                        )
                    }
                    .padding(.top, 16)
                }
            }
            .padding()
            .navigationTitle("Cart")
            .onAppear {
                // Atualiza os produtos no carrinho ao aparecer a tela
                viewModel.productsOnCart = viewModel.getProductsOnCart()
            }
        }
    }
}
