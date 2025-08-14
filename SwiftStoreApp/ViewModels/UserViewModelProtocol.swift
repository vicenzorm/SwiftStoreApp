//
//  File.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 14/08/25.
//

import Foundation

protocol UserViewModelProtocol {
    var product: Product { get }
    var category: Category? { get }
    
    func addToCart(product: Product)
    func addToFav(product: Product)
    func addToOrder(product: Product)
}
