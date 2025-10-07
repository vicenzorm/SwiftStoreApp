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
                .accessibilityHidden(true)
                .font(.system(size: 48))
                .foregroundStyle(.graysGray2)
                .accessibilityHidden(true)
            VStack(spacing: 16){
                Text(String(localized: String.LocalizationValue(title)))
                Text(String(localized: String.LocalizationValue(subtitle)))
                    .foregroundStyle(.labelsSecondary)
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("\(title), \(subtitle)")
        }
    }
}
#Preview {
    EmptyState(icon: "house", title: "titulo", subtitle: "subtitulo")
}
