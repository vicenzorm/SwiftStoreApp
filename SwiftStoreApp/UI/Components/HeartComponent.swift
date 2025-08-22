//
//  HeartComponent.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 14/08/25.
//

import SwiftUI

struct HeartComponent: View {

    @Binding var isFavorited: Bool
    var onTap: (() -> Void)?
    
    var body: some View {
        Button {
            isFavorited.toggle()
            onTap?()
        } label: {
            Image(systemName: isFavorited ? "heart.fill" : "heart")
                .foregroundStyle(.labelsPrimary)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.fillsTertiary)
                )
        }
        .padding(.trailing, 16)
    }
    
}

#Preview {
//    HeartComponent()
}
