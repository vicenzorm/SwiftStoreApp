//
//  ContentView.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 13/08/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(){
                ProductCardDeal()
            }
            .padding()
            .navigationTitle("Home")
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

#Preview {
    HomeView()
}





// id, title, description,  category, price, isFavorite, discount(isInDeal)(DiscountPrice), shippingInformation, thumbnail
