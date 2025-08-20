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
        NavigationLink {
//            CategoryView(viewModel: ShopViewModel(service: ShopService()), userViewModel: UserViewModel(service: UserService(modelContext: )), category: category)
        } label: {
            VStack(spacing: 8){
                
                Image(category.image)
                    .resizable()
                    .frame(width: 84, height:84)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
                Text(category.name)
                    .font(.subheadline)
                    .foregroundStyle(.labelsPrimary)
                
            }
        }
    }
}

#Preview {
//    CardCategory(category: Category(name: "Beauty", slug: "categoria"))
}
