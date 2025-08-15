//
//  Category.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 14/08/25.
//

import Foundation

struct Category: Decodable {
    var name: String
    var slug: String
    
    init(name: String, slug: String) {
        self.name = name
        self.slug = slug
    }
}
