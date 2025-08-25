import SwiftUI

struct DetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var viewModel: DetailsViewModel
    let product: Product
    
    var body: some View {
        NavigationStack {
            VStack {
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
                        HeartComponent(isFavorited: $viewModel.isFavorited) {
                            viewModel.addToFavorites(product: product)
                        }
                        .padding(24),
                        alignment: .topTrailing
                    )
                }
                .background(
                    RoundedRectangle(cornerRadius: 32)
                        .foregroundStyle(.backgroundSecondary)
                )
                
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
                        viewModel.addToCart(product: product)
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
        }
    }
}
