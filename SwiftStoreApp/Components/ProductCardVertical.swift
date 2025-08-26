import SwiftUI

struct ProductCardVertical: View {
    
    var product: Product
    @Binding var isFavorited: Bool
    var onAddToFavorites: () -> Void
    
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
                    onAddToFavorites()
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.subheadline)
                    .lineLimit(2, reservesSpace: true)
                
                Text(Formatters.paraDolarAmericano.string(from: NSNumber(value: product.price)) ?? "US$ 00,00")
                    .font(.headline)
            }
            
        }
        .frame(width: 177, height: 250)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.backgroundSecondary)
        )
//        .padding(8)
        
    }
}

