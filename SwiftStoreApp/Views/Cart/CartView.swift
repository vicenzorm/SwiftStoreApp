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
                        VStack(spacing: 8) {
                            ForEach(viewModel.cartItems) { product in
                                ProductCardList(
                                    cardType: .cart,
                                    product: product,
                                    onIncreaseQuantity: {
                                        viewModel.updateQuantity(
                                            productId: product.id,
                                            newQuantity: product.quantity + 1
                                        )
                                        Task {await viewModel.loadCart()}
                                    },
                                    onDecreaseQuantity: {
                                        viewModel.updateQuantity(
                                            productId: product.id,
                                            newQuantity: product.quantity - 1
                                        )
                                        Task {await viewModel.loadCart()}
                                    })
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .top)
                    .padding(.bottom, 20)
                    
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
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("Total")
                            .accessibilityValue(Formatters.paraDolarAmericano.string(from: NSNumber(value: viewModel.getCartTotalPrice())) ?? "$0.00")
                        
                        Button {
                            viewModel.checkoutCart()
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
                    .padding(16)
                    .background(.background)
                }
            }
            .navigationTitle("Cart")
            .task {
                await viewModel.loadCart()
            }
        }
    }
}
