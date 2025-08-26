import SwiftUI

struct ProductCardDeal: View {
    let product: Product
    @Binding var isFavorited: Bool
    var onTapFav: () -> Void
    
    var body: some View {
        VStack(spacing: 4) {
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
                .accessibilityHidden(true)
                
                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        Text(product.category.uppercased())
                            .font(.footnote)
                            .foregroundStyle(.labelsSecondary)
                            .accessibilityHidden(true)
                        
                        Spacer()
                        
                        HeartComponent(isFavorited: $isFavorited) {
                            onTapFav()
                        }
                        
                    }
                    
                    VStack(spacing: 4) {
                        Text(product.title)
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(Formatters.paraDolarAmericano.string(from: NSNumber(value: product.price)) ?? "US$ 00,00")
                            .font(.headline)
                            .foregroundStyle(.labelsPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("\(product.title) costing \(product.price)")
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
        .contentShape(RoundedRectangle(cornerRadius: 16))
    }
}
