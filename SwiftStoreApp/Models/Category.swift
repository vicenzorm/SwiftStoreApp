//
//  Category.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 14/08/25.
//

import Foundation

struct Category: Decodable, Identifiable {
    var id = UUID()
    var name: String
    var slug: String
    var image: String { name }
    
    enum CodingKeys: String, CodingKey {
        case name
        case slug
    }
    
    init(name: String, slug: String) {
        self.name = name
        self.slug = slug
    }
}
