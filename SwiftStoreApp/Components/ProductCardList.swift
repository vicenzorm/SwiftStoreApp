//
//  ListComponent.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 18/08/25.
//

import SwiftUI

struct ProductCardList: View {
    enum CardType {
        case cart
        case favorites
        case order
    }
    var cardType: CardType
    
    var product: Product?
    
    var showDetails: (() -> Void)?
    var onRemoveFromCart: (() -> Void)?
    var onIncreaseQuantity: (() -> Void)?
    var onDecreaseQuantity: (() -> Void)?
    
    var body: some View {
        
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: product?.thumbnail ?? "")) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Image(.placeholder).resizable()
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .frame(width: 160, height: 160)
            .padding(.vertical, 8)
            .padding(.trailing, 16)
            .padding(.leading, 8)
            
            HStack {
                if cardType == .order {
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text(product?.shippingInformation
                            .uppercased() ?? "Entrega em ...")
                            .font(.caption)
                            .font(.system(size: 12))
                            .foregroundStyle(.labelsSecondary)
                        
                        Text(product?.title ?? "name")
                            .font(.footnote)
                            .font(.system(size: 13))
                            .foregroundStyle(.labelsPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(1)
                        
                        Text(Formatters.paraDolarAmericano.string(from: NSNumber(value: product?.price ?? 0)) ?? "US$ 00,00")
                            .font(.headline)
                            .foregroundStyle(.labelsPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: 241)
                    
                } else {
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text(product?.title ?? "Nenhum0")
                            .font(.footnote)
                            .font(.system(size: 13))
                            .foregroundStyle(.labelsPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(2)
                        
                        Text(Formatters.paraDolarAmericano.string(from: NSNumber(value: product?.price ?? 0)) ?? "US$ 00,00")
                            .font(.headline)
                            .foregroundStyle(.labelsPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                    }
                    .frame(width: 157)
                    
                    Spacer()
                    
                    if cardType == .favorites {
                        Button {
                            showDetails!()
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
                        
                    } else if cardType == .cart {
                        
                        HStack(spacing: 4) {
                            Button {
                                onDecreaseQuantity!()
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
                            
                            Text("\(product?.quantity ?? 1)")
                                .font(.body)
                                .foregroundStyle(.labelsPrimary)
                                .padding(.horizontal, 4)
                            
                            Button {
                                onIncreaseQuantity!()
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
    //    ProductCardList(product: UserProduct(id: 02, title: "Product name with two or more lines goes here", productDescription: "hehe", price: 20, shippingInformation: "DELIVERY BY MONTH, 00", image: .placeholder, isFavorite: false, isOrdered: false, isOnCart: true))
}
