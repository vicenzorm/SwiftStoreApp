//
//  CategoriesVIew.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 14/08/25.
//

import SwiftUI

struct CategoriesView: View {
    
    var viewModel: ShopViewModel
    var userViewModel: UserViewModel
    
    @State var searchableText: String = ""
    
    var filteredCategories: [Category] {
        if searchableText.isEmpty {
            return viewModel.categories
        } else {
            return viewModel.categories.filter({$0.name.localizedCaseInsensitiveContains(searchableText)})
        }
    }
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoadingCategories {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            } else {
                VStack{
                    HStack(spacing: 8){
                        ForEach(viewModel.categories.prefix(4)) { category in
                            CardCategory(category: category)
                        }
                    }
                    .padding(.top)
                    
                    List(filteredCategories) { category in
                        
                        NavigationLink {
                            CategoryView(viewModel: viewModel, userViewModel: userViewModel, category: category)
                        } label : {
                            HStack {
                                Text(category.name)
                                Spacer()
                                
                            }
                            .frame(height: 60)
                        }
                    }
                    .listStyle(.plain)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .navigationTitle("Categories")
                .searchable(text: $searchableText, prompt: "Search")
            }
        }
        .task {
            await viewModel.loadCategories()
        }
    }
}

#Preview {
//   CategoriesView(viewModel: ShopViewModel(service: ShopService()))
}
