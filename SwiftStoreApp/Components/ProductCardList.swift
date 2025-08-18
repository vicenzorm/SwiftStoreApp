//
//  ListComponent.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 18/08/25.
//

import SwiftUI

struct ProductCardList: View {
    
    var product: UserProduct
    
    var body: some View {
        
        HStack(spacing: 16) {
            if let image = UIImage(data: product.image) {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(width: 78, height: 78)
            }
            
            HStack {
                if product.isOrdered {
                    VStack(alignment: .leading, spacing: 8) {
                            
                        Text(product.shippingInformation.uppercased())
                            .font(.caption)
                            .font(.system(size: 12))
                            .foregroundStyle(.labelsSecondary)
                        
                        Text(product.title)
                            .font(.footnote)
                            .font(.system(size: 13))
                            .foregroundStyle(.labelsPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(1)
                            
                        Text("US$\(Product.numberFormattedToString(number: product.price))")
                            .font(.headline)
                            .foregroundStyle(.labelsPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: 241)
                    
                } else {
                    VStack(alignment: .leading, spacing: 8) {
                            
                            Text(product.title)
                                .font(.footnote)
                                .font(.system(size: 13))
                                .foregroundStyle(.labelsPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(2)
                            
                            Text("US$\(Product.numberFormattedToString(number: product.price))")
                                .font(.headline)
                                .foregroundStyle(.labelsPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                    }
                    .frame(width: 157)
                    
                    Spacer()
                    
                    if product.isFavorite {
                        Button {
                            product.quantity += 1
                        } label: {
                            Image(systemName: "cart.fill")
                                .foregroundStyle(.labelsPrimary)
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(.fillsTertiary)
                                )
                        }
                        .padding(.trailing, 16)
                        
                    } else if product.isOnCart {
                        
                        HStack(spacing: 4) {
                            Button {
                                if product.quantity > 0 { product.quantity -= 1 }
                            } label: {
                                Image(systemName: "minus")
                                    .foregroundStyle(.labelsPrimary)
                                    .padding(.horizontal, 4)
                                    .padding(.vertical, 10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .foregroundStyle(.fillsTertiary)
                                    )
                            }
                            
                            Text("\(product.quantity)")
                                .font(.body)
                                .foregroundStyle(.labelsPrimary)
                            
                            Button {
                                if product.quantity < 9 { product.quantity += 1 }
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundStyle(.labelsPrimary)
                                    .padding(4)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .foregroundStyle(.fillsTertiary)
                                    )
                            }
                        }
                    }
                }
            }
            .frame(width: 243,alignment: .leading)
            .padding(.vertical, 16)
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.backgroundSecondary)
        )
    }
}

#Preview {
    ProductCardList(product: UserProduct(id: 02, title: "Product name with two or more lines goes here", productDescription: "hehe", price: 20, shippingInformation: "DELIVERY BY MONTH, 00", image: .placeholder, isFavorite: false, isOrdered: false, isOnCart: true))
}
