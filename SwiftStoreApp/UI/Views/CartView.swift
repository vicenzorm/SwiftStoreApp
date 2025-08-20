import SwiftUI
import SwiftData

struct CartView: View {
    var viewModel: UserViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.productsOnCart.isEmpty {
                    // Centraliza verticalmente
                    Spacer()
                    EmptyState(
                        icon: "cart.badge.questionmark",
                        title: "Your Cart is Empty!",
                        subtitle: "add an item to your cart"
                    )
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(viewModel.productsOnCart) { product in
                                ProductCardList(product: product, cardType: .cart)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .top)
                    }
                    
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
                        
                        Button {
                            viewModel.addToOrder()
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
                viewModel.productsOnCart = viewModel.getProductsOnCart()
            }
        }
    }
}

