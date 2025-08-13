//
//  ProductCardvertical.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 13/08/25.
//

import SwiftUI

struct ProductCardVertical: View {
    var body: some View {
        VStack(spacing: 8) {
            
            ZStack {
                Image(systemName: "plus")
                
            }
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text("Product name with two or more lines goes here")
                    .font(.subheadline)
                Text("US$ 00,00")
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

#Preview {
    ProductCardVertical()
}
