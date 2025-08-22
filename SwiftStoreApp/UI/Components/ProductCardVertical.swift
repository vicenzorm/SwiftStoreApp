//
//  ProductCardvertical.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 13/08/25.
//

import SwiftUI

struct ProductCardVertical: View {
    
    @Environment(\.modelContext) var modelContext
    
    var product: Product?
    @State var showDetails: Bool = false
    @State var productFavorited: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                if let product {
                    AsyncImage(url: URL(string: product.thumbnail)) { image in
                        image.resizable()
                            .scaledToFill()
                    } placeholder: {
                        Image(.placeholder)
                            .resizable()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(width: 161,height: 160)
                }
                HeartComponent(isFavorited: $productFavorited)
                    .onChange(of: productFavorited) { oldValue, newValue in
                        if newValue {
                            if let product {
                                Task { await viewModel.addToFavorites(product: product) }
                            }
                        } else {
                            // deveria ter uma função de !favoritar mas a dharana nao deixou (2)
                        }
                    }
            }
            VStack(alignment: .leading, spacing: 4) {
                
                Text(product?.title ?? "Product name with two or more lines goes here")
                    .font(.subheadline)
                    .lineLimit(2, reservesSpace: true)
                
                
                Text(Formatters.paraDolarAmericano.string(from: NSNumber(value: product?.price ?? 0.0)) ?? "US$ 00,00")
                    .font(.headline)
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.backgroundSecondary)
        )
        .frame(width: 177, height: 250)
        .sheet(isPresented: $showDetails){
            ProductDetailsView(viewModel: UserViewModel(service: UserService(modelContext: modelContext)), product: product)
                .presentationDragIndicator(.visible)
        }
        .onTapGesture {
            showDetails = true
        }
        
        
    }
    
}

#Preview {
//    ProductCardVertical()
}
