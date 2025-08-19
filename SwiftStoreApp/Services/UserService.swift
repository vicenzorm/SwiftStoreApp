//
//  UserService.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 18/08/25.
//

import Foundation
import UIKit
import SwiftData
import SwiftUI

class UserService: UserServiceProtocol {
    
    @Environment(\.modelContext) var modelContext
    @Query var userProducts: [UserProduct]
    
    func addToFavorites(product: Product) {
        addProductsTo(ocassion: .favorites, product: product)
    }
    
    func addToCart(product: Product) {
        addProductsTo(ocassion: .cart, product: product)
    }
    
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
    
    func getAllFavorites() -> [UserProduct] {
        return getAllProductsIn(ocassion: .onFavorites)
    }
    
    func getCartListProducts() -> [UserProduct] {
        return getAllProductsIn(ocassion: .onCart)
    }
    
    func getAllOrders() -> [UserProduct] {
        return getAllProductsIn(ocassion: .onOrders)
    }
    
    func convertImageToData(image: String) -> UIImage {
        var uiImage: UIImage = UIImage()
        
        if let url = URL(string: image) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data {
                    DispatchQueue.main.async {
                        if let image = UIImage(data: data){
                            uiImage = image
                        }
                    }
                }
            }.resume()
        }
        return uiImage
    }
    
    func addProductsTo(ocassion: AddTo, product: Product) {
        if userProducts.contains(where: {$0.id == product.id}), let index = userProducts.firstIndex(where:  {$0.id == product.id}) {
            switch ocassion {
            case .cart:
                userProducts[index].isOnCart = true
            case .favorites:
                userProducts[index].isFavorite = true
            }
            
        } else {
            let image = convertImageToData(image: product.thumbnail)
            var newUserProduct: UserProduct
            
            switch ocassion {
            case .cart:
                newUserProduct = UserProduct(id: product.id, title: product.title, productDescription: product.description, price: product.price, shippingInformation: product.shippingInformation, image: image, isFavorite: false, isOrdered: false, isOnCart: true)
            case .favorites:
                newUserProduct = UserProduct(id: product.id, title: product.title, productDescription: product.description, price: product.price, shippingInformation: product.shippingInformation, image: image, isFavorite: true, isOrdered: false, isOnCart: false)
            }
            
            modelContext.insert(newUserProduct)
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
    
    enum GetFrom {
        case onCart, onFavorites, onOrders
    }
    
    enum AddTo {
        case cart
        case favorites
    }
}
