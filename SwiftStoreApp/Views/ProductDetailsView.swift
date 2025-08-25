import SwiftUI

struct ProductDetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    // Injetando o ViewModel para lidar com a lógica
    let favoritesViewModel: FavoritesViewModel
    let cartViewModel: CartViewModel // Supondo que você tem um CartViewModel
    
    let product: Product
    
    // Estado local para o coração, inicializado pelo ViewModel
    @State private var isFavorited: Bool
    
    init(favoritesViewModel: FavoritesViewModel, cartViewModel: CartViewModel, product: Product) {
        self.favoritesViewModel = favoritesViewModel
        self.cartViewModel = cartViewModel
        self.product = product
        
        // Inicializa o estado do coração com base no ViewModel
        _isFavorited = State(initialValue: favoritesViewModel.isProductFavorite(product: product))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                // Conteúdo do cabeçalho com a imagem
                VStack {
                    AsyncImage(url: URL(string: product.thumbnail)) { image in
                        image.resizable()
                            .scaledToFill()
                    } placeholder: {
                        Image(.placeholder)
                            .resizable()
                            .scaledToFill()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .frame(width: 329, height: 329)
                    .padding()
                    .overlay(
                        // O HeartComponent agora interage com o estado local
                        HeartComponent(isFavorited: $isFavorited)
                            .padding(24)
                            .onTapGesture {
                                // Ação de favoritar/desfavoritar
                                favoritesViewModel.toggleFavorite(product: product)
                            },
                        alignment: .topTrailing
                    )
                }
                .background(
                    RoundedRectangle(cornerRadius: 32)
                        .foregroundStyle(.backgroundSecondary)
                )
                
                // Conteúdo de texto e botões
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(product.title)
                            .font(.title3)
                            .foregroundStyle(.labelsPrimary)
                        
                        Text(Formatters.paraDolarAmericano.string(from: NSNumber(value: product.price)) ?? "US$ 00,00")
                            .font(.title2.bold())
                            .foregroundStyle(.labelsPrimary)
                    }
                    
                    ScrollView {
                        Text(product.description)
                            .font(.body)
                            .foregroundStyle(.labelsSecondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(height: 182)
                    
                    Button {
                        // Ação de adicionar ao carrinho via ViewModel
                        cartViewModel.addToCart(productId: product.id)
                        dismiss()
                    } label: {
                        Text("Add to cart")
                            .foregroundStyle(.labelsPrimary)
                            .frame(maxWidth: .infinity)
                    }
                    .frame(height: 54)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(.fillsTertiary)
                    )
                    .padding()
                }
            }
            .padding(.top, 60)
            .padding(.bottom, 16)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 0)
                    .foregroundStyle(.bakgroundPrimary)
            )
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.bakgroundPrimary, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .onChange(of: favoritesViewModel.favoriteProducts) {
                // Observa a lista de favoritos e atualiza o estado local
                self.isFavorited = favoritesViewModel.isProductFavorite(product: product)
            }
        }
    }
}
