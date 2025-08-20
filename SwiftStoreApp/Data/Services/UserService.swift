//
//  UserService.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 18/08/25.
//

import Foundation
import UIKit
import SwiftData

@MainActor
final class UserService: UserServiceProtocol {
    
    private let modelContext: ModelContext
    var userProducts: [UserProduct] { return getAllProducts() }
    
    init(modelContext: ModelContext) { self.modelContext = modelContext }
    
    func addToFavorites(product: Product) async { await addProductsTo(ocassion: .favorites, product: product) }
    
    func addToCart(product: Product) async { await addProductsTo(ocassion: .cart, product: product) }
    
    func checkoutOrders() {
        for product in userProducts {
            if product.isOnCart {
                product.isOrdered.toggle()
                product.isOnCart.toggle()
            }
        }
        do {
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getAllFavorites() -> [UserProduct] { return getAllProductsIn(ocassion: .onFavorites) }
    
    func getCartListProducts() -> [UserProduct] { return getAllProductsIn(ocassion: .onCart) }
    
    func getAllOrders() -> [UserProduct] { return getAllProductsIn(ocassion: .onOrders) }
    
    func downloadDataFromUrl(imageUrl: String) async throws -> Data {
        if let url = URL(string: imageUrl) {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } else {
            throw URLError(.badURL)
        }
    }
    
    func addProductsTo(ocassion: AddTo, product: Product) async {
        do {
            if userProducts.contains(where: {$0.id == product.id}), let index = userProducts.firstIndex(where:  {$0.id == product.id}) {
                switch ocassion {
                case .cart:          userProducts[index].isOnCart = true
                case .favorites:     userProducts[index].isFavorite = true
                }
                try modelContext.save()
                return
                
            }
            var imgData: Data? = nil
            do { imgData = try await downloadDataFromUrl(imageUrl: product.thumbnail) } catch {}
            let newUserProduct = UserProduct(
                id: product.id,
                title: product.title,
                productDescription: product.description,
                price: product.price,
                shippingInformation: product.shippingInformation,
                image: imgData ?? Data(),
                isFavorite: ocassion == .favorites,
                isOrdered: false,
                isOnCart: ocassion == .cart
            )
            
            modelContext.insert(newUserProduct)
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func getAllProductsIn(ocassion: GetFrom) -> [UserProduct] {
        var products: [UserProduct] = []
        for product in userProducts {
            switch ocassion {
            case .onCart:
                if product.isOnCart {
                    products.append(product)
                }
            case .onFavorites:
                if product.isFavorite {
                    products.append(product)
                }
            case .onOrders:
                if product.isOrdered {
                    products.append(product)
                }
            }
        }
        return products
    }
    
    func getAllProducts() -> [UserProduct] {
        do {
            return try modelContext.fetch(FetchDescriptor<UserProduct>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    enum GetFrom {
        case onCart, onFavorites, onOrders
    }
    
    enum AddTo {
        case cart
        case favorites
    }
}
