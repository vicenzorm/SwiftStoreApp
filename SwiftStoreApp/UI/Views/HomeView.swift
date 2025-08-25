import SwiftUI
import SwiftData // Não se esqueça de importar SwiftData

struct HomeView: View {
    
    @State private var homeViewModel = HomeViewModel(apiService: APIService.shared, favoritesService: FavoritesService.shared)
    
    // MARK: - Layout
    let colunas: [GridItem] = [
        GridItem(.fixed(177), spacing: 8),
        GridItem(.fixed(177), spacing: 8)
    ]
  
    // MARK: - View
    var body: some View {
        // O corpo da sua View continua exatamente o mesmo.
        // Nenhuma mudança é necessária aqui.
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                // MARK: Seção: Deals of the Day
                if !homeViewModel.products.isEmpty, let dealProduct = homeViewModel.products.randomElement() {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Deals of the day")
                            .font(.system(size: 22, weight: .bold))
                            .font(.title2)
                        
                        ProductCardDeal(product: dealProduct, isFavorited: $homeViewModel.isFavorited) {
                            homeViewModel.isProductFavorite(product: dealProduct)
                        }
                        .onTapGesture {
                            homeViewModel.selectedProduct = dealProduct
                        }
                    }
                }
                
                // MARK: Seção: Top Picks
                VStack(alignment: .leading, spacing: 8) {
                    Text("Top Picks")
                        .font(.system(size: 22, weight: .bold))
                        .font(.title2)
                    
                    ScrollView {
                        LazyVGrid(columns: colunas, spacing: 8) {
                            ForEach(homeViewModel.products) { product in
                                ProductCardVertical(product: product, isFavorited: $homeViewModel.isFavorited) {
                                    
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Home")
            .frame(maxHeight: .infinity, alignment: .top)
            .task {
                await homeViewModel.loadProducts()
            }
            .sheet(item: $homeViewModel.selectedProduct) { product in
                    ProductDetailsView(product: product)
            }
        }
    }
}
