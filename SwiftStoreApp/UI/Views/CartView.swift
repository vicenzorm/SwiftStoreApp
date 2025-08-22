import SwiftUI

/// A view that displays the user's shopping cart.
/// It shows a list of products, the total price, and a checkout button.
struct CartView: View {
    
    @State var viewModel = CartViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                // If the cart is empty, show an empty state view.
                if viewModel.cartItems.isEmpty {
                    Spacer()
                    EmptyState(
                        icon: "cart.badge.questionmark",
                        title: "Your Cart is Empty!",
                        subtitle: "add an item to your cart"
                    )
                    Spacer()
                    
                } else {
                    // Show a list of products in the cart.
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(viewModel.cartItems) { product in
                                ProductCardList(
                                    product: product,
                                    cardType: .cart,
                                    onIncreaseQuantity: {
                                        // Aumenta a quantidade do produto no carrinho
                                        viewModel.updateQuantity(
                                            productId: product.id,
                                            newQuantity: product.quantity + 1
                                        )
                                    },
                                    onDecreaseQuantity: {
                                        // Diminui a quantidade do produto, se for maior que 1
                                        if product.quantity > 1 {
                                            viewModel.updateQuantity(
                                                productId: product.id,
                                                newQuantity: product.quantity - 1
                                            )
                                        } else {
                                            // Se a quantidade for 1, remove o produto do carrinho
                                            viewModel.removeFromCart(productId: product.id)
                                        }
                                    }
                                )
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .top)
                        .padding(.bottom, 20) // Add padding to avoid the last item being covered by the total section
                    }
                    
                    // Cart summary: total price and checkout button.
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
                            .font(.subheadline)
                        }
                        
                        // Checkout Button
                        Button {
                            // Finaliza a compra
                            //viewModel.addToOrder()
                            viewModel.clearCart()
                        } label: {
                            Text("Checkout")
                                .foregroundStyle(.white) // Use .white or a color that stands out
                                .frame(maxWidth: .infinity)
                        }
                        .frame(height: 54)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundStyle(.blue) // Use a distinct color for the button
                        )
                        .disabled(viewModel.cartItems.isEmpty) // Disable the button if the cart is empty
                    }
                    .padding(.top, 16)
                    .padding(.horizontal)
                    .background(.background)
                }
            }
            .padding()
            .navigationTitle("Cart")
            .onAppear {
                // Load cart data when the view appears.
                viewModel.loadCart()
            }
        }
    }
}
