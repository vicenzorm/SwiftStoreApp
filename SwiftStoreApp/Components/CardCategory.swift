//
//  CardCategory.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 15/08/25.
//

import SwiftUI

struct CardCategory: View {
    
    let category: Category
    
    var body: some View {
        VStack(spacing: 8){
            
            Image(category.image)
                .resizable()
                .frame(width: 84, height:84)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            Text(category.name)
                .font(.subheadline)
            
        }
    }
}

#Preview {
    CardCategory(category: Category(name: "Beauty", slug: "categoria"))
}
