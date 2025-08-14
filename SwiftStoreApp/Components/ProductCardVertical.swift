//
//  ProductCardvertical.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 13/08/25.
//

import SwiftUI

struct ProductCardVertical: View {
    
    var product: Product?
    
    var body: some View {
        VStack(spacing: 8) {
            
            VStack {
                ZStack(alignment: .topTrailing){
                    if let product, let image = UIImage(named: product.image) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        HeartComponent(product: product)
                    } else {
                        Image(.placeholder)
                            .resizable()
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        HeartComponent()
                    }
                    
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
            
        }
    }

}

#Preview {
    ProductCardVertical()
}
