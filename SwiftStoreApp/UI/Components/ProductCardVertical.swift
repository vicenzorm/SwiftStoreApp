import SwiftUI

struct ProductCardVertical: View {
    var product: Product?
    @Binding var isFavorited: Bool
    @State var showDetails: Bool = false
    var onAddToFavorites: () -> Void
    
    init(favoritesViewModel: FavoritesViewModel, cartViewModel: CartViewModel, product: Product) {
            self.cartViewModel = cartViewModel
            self.favoritesViewModel = favoritesViewModel
            self.product = product
            _isFavorited = State(initialValue: favoritesViewModel.isProductFavorite(product: product))
        }
    let cartViewModel: CartViewModel
    let favoritesViewModel: FavoritesViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image.resizable()
                        .scaledToFill()
                } placeholder: {
                    Image(.placeholder)
                        .resizable()
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .frame(width: 161, height: 160)
                
                HeartComponent(isFavorited: $isFavorited) {
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.subheadline)
                    .lineLimit(2, reservesSpace: true)
                
                Text(Formatters.paraDolarAmericano.string(from: NSNumber(value: product.price)) ?? "US$ 00,00")
                    .font(.headline)
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.backgroundSecondary)
        )
        .frame(width: 177, height: 250)
        .onTapGesture {
            showDetails = true
        }
        .sheet(isPresented: $showDetails){
            ProductDetailsView(
                favoritesViewModel: favoritesViewModel,
                cartViewModel: cartViewModel, // Passe a instância que você recebeu
                product: product
            )
            .presentationDragIndicator(.visible)
        }
        .presentationDragIndicator(.visible)
    }
    
}

