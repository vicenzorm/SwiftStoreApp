import SwiftUI

struct ProductCardDeal: View {
    let product: Product
    @Binding var isFavorited: Bool
    @State var showDetail: Bool = false
    
    var onTapFav: (() -> Void)
    
    var body: some View {
        let category = product.category
        let title = product.title
        let price = product.price
        
        VStack(spacing: 8) {
            HStack {
                HStack(alignment: .top) {
                    // IMAGEM
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
                    
                    // TEXTOS + CORAÇÃO
                    VStack(alignment: .leading, spacing: 24) {
                        HStack {
                            Text(category)
                                .font(.footnote)
                                .foregroundStyle(.labelsSecondary)
                            
                            Spacer()
                            
                            HeartComponent(isFavorited: $isFavorited) {
                                onTapFav()    // UI já alternou; aqui você persiste
                            }
                        }
                        .padding(.top, 8)
                        
                        VStack(spacing: 4) {
                            Text(title)
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(Formatters.paraDolarAmericano
                                .string(from: NSNumber(value: price)) ?? "US$ 00,00")
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
        .contentShape(RoundedRectangle(cornerRadius: 16)) // melhora hit area
        .onTapGesture { showDetail = true }
        .sheet(isPresented: $showDetail) {
            ProductDetailsView(
                viewModel: FavoritesViewModel(service: FavoritesService.shared),
                product: product
            )
        }
    }
}


#Preview {
//    ProductCardDeal()
}
