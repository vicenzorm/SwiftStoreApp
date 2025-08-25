//
//  EmptyState.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 15/08/25.
//

import SwiftUI

struct EmptyState: View {
    
    var icon: String
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 48))
                .foregroundStyle(.graysGray2)
            VStack(spacing: 16){
                Text(title)
                Text(subtitle)
                    .foregroundStyle(.labelsSecondary)
            }
        }
    }
}
#Preview {
    EmptyState(icon: "house", title: "titulo", subtitle: "subtitulo")
}
