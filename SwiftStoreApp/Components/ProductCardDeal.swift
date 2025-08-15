import SwiftUI

struct ProductCardDeal: View {
    
    var product: Product?
    
    var body: some View {
        
        let category = product?.category ?? "CATEGORY"
        let title = product?.title ?? "Product name with two or more lines goes here"
        let price = product?.price ?? 0
        
        VStack (spacing: 8){
            
            Text("Deals of the day")
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack{
                HStack(alignment: .top){
                    Image(.placeholder)
                        .resizable()
                        .frame(width: 160, height: 160)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.vertical, 8)
                        .padding(.trailing, 16)
                        .padding(.leading, 8)
                    
                    VStack(alignment: .leading, spacing: 24) {
                        HStack {
                            Text(category)
                                .font(.footnote)
                                .foregroundStyle(.labelsSecondary)
                            
                            Spacer()
                            
                            VStack {
                                HeartComponent(isFavorite: false)
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(.fillsTertiary)
                            )
                        }
                        .padding(.top, 8)
                        
                        VStack (spacing: 4) {
                            Text(title)
                                .font(.subheadline)
                                .frame(maxWidth: .infinity ,alignment: .leading)
                            
                            Text("US$ \(Product.numberFormattedToString(number: price))")
                                .font(.headline)
                                .foregroundStyle(.labelsPrimary)
                                .frame(maxWidth: .infinity ,alignment: .leading)
                        }
                    }
                }
                .padding(.horizontal, 8)
                .padding(.top, 8)
                .padding(.bottom, 8)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.backgroundSecondary)
                )
            }
        }   .padding(.horizontal)
    }
}

#Preview {
    ProductCardDeal()
}
