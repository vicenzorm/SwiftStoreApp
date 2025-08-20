import SwiftUI

struct ProductCardDeal: View {
    
    var viewModel: UserViewModel
    var product: Product?
    
    @State var showDetail: Bool = false // vai pra view model
    @State var productFavorite: Bool
    
    var body: some View {
        
        let category = product?.category ?? "CATEGORY"
        let title = product?.title ?? "Product name with two or more lines goes here"
        let price = product?.price ?? 0
        
        VStack (spacing: 8){
            HStack{
                HStack(alignment: .top){
                    if let product {
                        AsyncImage(url: URL(string: product.thumbnail)) { image in
                            image.resizable()
                                .scaledToFill()
                                
                        } placeholder: {
                            Image(.placeholder)
                                .resizable()
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .frame(width: 160, height: 160)
                        .padding(.vertical, 8)
                        .padding(.trailing, 16)
                        .padding(.leading, 8)
                    }
                    
                    VStack(alignment: .leading, spacing: 24) {
                        HStack {
                            Text(category)
                                .font(.footnote)
                                .foregroundStyle(.labelsSecondary)
                            
                            Spacer()
                            
                            VStack {
                                HeartComponent(isFavorited: $productFavorite)
                            }
                            .onChange(of: productFavorite) { oldValue, newValue in
                                if newValue {
                                    if let product {
                                        Task { await viewModel.addToFavorites(product: product) }
                                    }
                                } else {
                                    // deveria ter uma função de !favoritar mas a dharana nao deixou
                                }
                            }
                        }
                        .padding(.top, 8)
                        
                        VStack (spacing: 4) {
                            Text(title)
                                .font(.subheadline)
                                .frame(maxWidth: .infinity ,alignment: .leading)
                            
                            Text(Formatters.paraDolarAmericano.string(from: NSNumber(value: price)) ?? "US$ 00,00")
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
        }
        .sheet(isPresented: $showDetail) {
//            ProductDetailsView(viewModel: UserViewModel(service: UserService()), product: product)
        }
        .onTapGesture {
            showDetail = true
        }
    }
}

#Preview {
//    ProductCardDeal()
}
