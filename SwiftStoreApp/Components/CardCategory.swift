//
//  CardCategory.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 15/08/25.
//

import SwiftUI
import SwiftData

struct CardCategory: View {
    let category: Category
    
    var body: some View {
        NavigationLink(destination:
                        CategoryView(viewModel: CategoryViewModel(category: category, apiService: APIService.shared))
        )
        {
            
            VStack(spacing: 8){
                Image(category.image)
                    .resizable()
                    .frame(width: 84, height:84)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
                Text(category.name)
                    .font(.subheadline)
                    .truncationMode(.tail)
                    .lineLimit(1)
                    .foregroundStyle(.labelsPrimary)
            }
            .frame(width: 82)
            .accessibilityHint("Click to go to \(category.name)'s page")
        }
    }
}


#Preview {
    CardCategory(category: Category(name: "Beauty", slug: "categoria"))
}
