//
//  ProductDetailsView.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 15/08/25.
//

import SwiftUI

struct ProductDetailsView: View {
    
    var product: Product?
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack() {
                    ZStack(alignment: .topTrailing) {
                        if let product {
                            AsyncImage(url: URL(string: product.thumbnail)) { image in
                                image.resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Image(.placeholder)
                                    .resizable()
                                    .scaledToFill()
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .frame(width: 329,height: 329)
                        }
                        HeartComponent(isFavorite: false)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 32)
                        .foregroundStyle(.backgroundSecondary)
                )
                VStack {
                    
                    VStack {
                        Text(product?.title ?? "Name of a product with two or more lines goes here")
                            .font(.title3)
                            .foregroundStyle(.labelsPrimary)
                        
                        Text("US$ \(Product.numberFormattedToString(number: product?.price ?? 0))")
                            .font(.headline)
                            .foregroundStyle(.labelsPrimary)
                    }
                    
                    ScrollView {
                        Text(product?.description ?? "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed lobortis nec mauris ac placerat. Cras pulvinar dolor at orci semper hendrerit. Nam elementum leo vitae quam commodo, blandit ultricies diam malesuada. Suspendisse lacinia euismod quam interdum mollis. Pellentesque a eleifend ante. Aliquam tempus ultricies velit, eget consequat magna volutpat vitae. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris pulvinar vestibulum congue. Aliquam et magna ultrices justo condimentum varius.")
                            .font(.body)
                            .font(.system(size: 17))
                            .foregroundStyle(.labelsSecondary)
                        
                    }
                    .frame(height: 182)
                    
                    Button {
                        
                    } label: {
                        Text("Add to cart")
                            .foregroundStyle(.labelsPrimary)
                    }
                    .frame(width: 361, height: 54)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(.fillsTertiary)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        )
                    
                }
            }
            .padding()
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.backgroundTertiary, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            
        }
    }
}

#Preview {
    ProductDetailsView()
}
