//
//  ProductDetailsView.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 15/08/25.
//
import SwiftUI

struct ProductDetailsView: View {
    
    
    @Environment(\.dismiss) var dismiss
    var viewModel: UserViewModel
    var product: Product?
    @State var productIsFavorited = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                VStack {
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
                        .frame(width: 329, height: 329)
                        .padding()
                        .overlay(
                            HeartComponent(isFavorited: $productIsFavorited)
                                .padding(24),
                            alignment: .topTrailing
                        )
                        .onChange(of: productIsFavorited) { oldValue, newValue in
                            if newValue {
                                Task { await viewModel.addToFavorites(product: product) } // forma de utilziar uma função assincrona que mexe com swiftdata
                            } else {
                                // deveria ter uma função de !favoritar mas a dharana nao deixou
                            }
                        }
                        
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 32)
                        .foregroundStyle(.backgroundSecondary)
                )
                
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(product?.title ?? "Name of a product with two or more lines goes here")
                            .font(.title3)
                            .foregroundStyle(.labelsPrimary)
                        
                        Text(Formatters.paraDolarAmericano.string(from: NSNumber(value: product?.price ?? 0.0)) ?? "US$ 00,00")
                            .font(.title2.bold())
                            .foregroundStyle(.labelsPrimary)
                    }
                    
                    ScrollView {
                        Text(product?.description ?? "Lorem ipsum dolor sit amet...")
                            .font(.body)
                            .foregroundStyle(.labelsSecondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(height: 182)
                    
                    Button {
                        if let product {
                            Task { await viewModel.addToCart(product: product) }
                            dismiss()
                        }
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
                }
                .padding()
                
                Spacer()
            }
            .padding(.top, 60)
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.backgroundTertiary, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    TabBar()
}
