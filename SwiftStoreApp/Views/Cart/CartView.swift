import SwiftUI
import SwiftData

struct CartView: View {
    
    @State var viewModel: CartViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.cartItems.isEmpty {
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
                            ForEach(viewModel.cartItems) { product in
                                ProductCardList(
                                    product: product,
                                    cardType: .cart,
                                    onIncreaseQuantity: {
                                        viewModel.updateQuantity(
                                            productId: product.id,
                                            newQuantity: product.quantity + 1
                                        )
                                    },
                                    onDecreaseQuantity: {
                                        viewModel.updateQuantity(
                                            productId: product.id,
                                            newQuantity: product.quantity - 1
                                        )
                                    }
                                )
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .top)
                        .padding(.bottom, 20)
                    }
                    
                    VStack(spacing: 16) {
                        HStack {
                            Text("Total:")
                                .font(.subheadline)
                            Spacer()
                            Text(
                                Formatters.paraDolarAmericano.string(
                                    from: NSNumber(value: viewModel.getCartTotalPrice())
                                ) ?? "$0.00"
                            )
                            .font(.headline)
                        }
                        
                        Button {
                            viewModel.clearCart()
                        } label: {
                            Text("Checkout")
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                        }
                        .frame(height: 54)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundStyle(.blue) // Mudei a cor para ser mais visível
                        )
                        .disabled(viewModel.cartItems.isEmpty)
                    }
                    .padding(.top, 16)
                    .background(.background)
                }
            }
            .padding()
            .navigationTitle("Cart")
            .onAppear {
                viewModel.loadCart()
            }
        }
    }
}
