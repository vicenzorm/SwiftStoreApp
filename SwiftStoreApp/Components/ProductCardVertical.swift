//
//  ProductCardvertical.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 13/08/25.
//

import SwiftUI

struct ProductCardVertical: View {
    
    var product: Product?
    @State var showDetails: Bool = false
    
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
                HeartComponent(isFavorite: true )
            }
            VStack(alignment: .leading, spacing: 4) {
                
                Text(product?.title ?? "Product name with two or more lines goes here")
                    .font(.subheadline)
                    .lineLimit(2, reservesSpace: true)
                
                
                Text("US$ \(Product.numberFormattedToString(number: product?.price ?? 0))")
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
            ProductDetailsView(product: product)
                .presentationDragIndicator(.visible)
        }
        .onTapGesture {
            showDetails = true
        }
        
        
    }
    
}

#Preview {
    ProductCardVertical()
}
