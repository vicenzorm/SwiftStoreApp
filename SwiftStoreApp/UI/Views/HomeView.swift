import SwiftUI
import SwiftData // Não se esqueça de importar SwiftData

struct HomeView: View {
    // 1. Declare os ViewModels sem inicializá-los aqui.
    //    Usar `private` é uma boa prática, pois a View gerencia seu próprio estado.
    @State private var apiViewModel: APIViewModel
    @State private var favoritesViewModel: FavoritesViewModel
    @State private var cartViewModel: CartViewModel
    
    // MARK: - Layout
    let colunas: [GridItem] = [
        GridItem(.fixed(177), spacing: 8),
        GridItem(.fixed(177), spacing: 8)
    ]
    
    // 2. Crie um inicializador que recebe a dependência externa (o modelContext)
    init(modelContext: ModelContext) {
        // 3. Inicialize TODOS os seus ViewModels aqui dentro, usando o wrapper `_`
        _apiViewModel = State(initialValue: APIViewModel(service: APIService.shared))
        _favoritesViewModel = State(initialValue: FavoritesViewModel(
            favoritesService: FavoritesService.shared,
            productService: APIService.shared
        ))
        
        // 4. Aqui está a correção principal: Crie o CartViewModel passando o modelContext
        _cartViewModel = State(initialValue: CartViewModel(modelContext: modelContext))
    }
    
    // MARK: - View
    var body: some View {
        // O corpo da sua View continua exatamente o mesmo.
        // Nenhuma mudança é necessária aqui.
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                // MARK: Seção: Deals of the Day
                if !apiViewModel.products.isEmpty, let dealProduct = apiViewModel.products.randomElement() {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Deals of the day")
                            .font(.system(size: 22, weight: .bold))
                            .font(.title2)
                        
                        ProductCardDeal(
                            favoritesViewModel: favoritesViewModel,
                            cartViewModel: cartViewModel, // Agora passa a instância correta
                            product: dealProduct
                        )
                    }
                }
                
                // MARK: Seção: Top Picks
                VStack(alignment: .leading, spacing: 8) {
                    Text("Top Picks")
                        .font(.system(size: 22, weight: .bold))
                        .font(.title2)
                    
                    ScrollView {
                        LazyVGrid(columns: colunas, spacing: 8) {
                            ForEach(apiViewModel.products) { product in
                                ProductCardVertical(
                                    favoritesViewModel: favoritesViewModel,
                                    cartViewModel: cartViewModel, // E aqui também
                                    product: product
                                )
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Home")
            .frame(maxHeight: .infinity, alignment: .top)
            .task {
                await apiViewModel.loadProducts()
                await favoritesViewModel.loadFavoriteProducts()
                // Não precisa mais carregar o carrinho aqui, pois ele já carrega no init do ViewModel
            }
        }
    }
}
