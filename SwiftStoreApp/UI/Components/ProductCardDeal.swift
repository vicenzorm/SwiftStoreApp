import SwiftUI

struct ProductCardDeal: View {
    let favoritesViewModel: FavoritesViewModel
    let cartViewModel: CartViewModel
    let product: Product
    @Binding var isFavorited: Bool
    @State var showDetail: Bool = false
    var onAddToFavorites: (() -> Void)? = nil
    var onTapFav: (() -> Void)
    init(favoritesViewModel: FavoritesViewModel, cartViewModel: CartViewModel, product: Product) {
            self.favoritesViewModel = favoritesViewModel
            self.cartViewModel = cartViewModel
            self.product = product
            _isFavorited = State(initialValue: favoritesViewModel.isProductFavorite(product: product))
        }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                HStack(alignment: .top) {
                    AsyncImage(url: URL(string: product.thumbnail)) { image in
                        image.resizable().scaledToFill()
                    } placeholder: {
                        Image(.placeholder).resizable()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(width: 160, height: 160)
                    .padding(.vertical, 8)
                    .padding(.trailing, 16)
                    .padding(.leading, 8)
                    
                    VStack(alignment: .leading, spacing: 24) {
                        HStack {
                            Text(product.category)
                                .font(.footnote)
                                .foregroundStyle(.labelsSecondary)
                            
                            Spacer()
                            
                            HeartComponent(isFavorited: $isFavorited) {
                                onTapFav()
                            }
                        }
                        .padding(.top, 8)
                        
                        VStack(spacing: 4) {
                            Text(product.title)
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(Formatters.paraDolarAmericano.string(from: NSNumber(value: product.price)) ?? "US$ 00,00")
                                .font(.headline)
                                .foregroundStyle(.labelsPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.backgroundSecondary)
                )
            }
        }
        .contentShape(RoundedRectangle(cornerRadius: 16))
        .onTapGesture { showDetail = true }
        .sheet(isPresented: $showDetail) {
                ProductDetailsView(
                    favoritesViewModel: favoritesViewModel,
                    cartViewModel: cartViewModel, // Passe a instância que você recebeu
                    product: product
                )
            }
//        .onChange(of: favoritesViewModel.favoriteProducts) {
//            // Update the state of the HeartComponent if the ViewModel's list changes
//            self.isFavorited = favoritesViewModel.isProductFavorite(product: product)
//        }
    }
}
