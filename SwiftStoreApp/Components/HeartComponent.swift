//
//  HeartComponent.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 14/08/25.
//

import SwiftUI

struct HeartComponent: View {
    
    var isFavorite: Bool
    
    var body: some View {
        ZStack(alignment: .center) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .resizable()
                .frame(width: 22, height: 20)
        }
        .frame(width: 38,height: 38)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(.fillsTertiary)
        )
    }
}

//#Preview {
//    HeartComponent()
//}
