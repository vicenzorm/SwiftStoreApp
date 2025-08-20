//
//  SwiftStoreAppApp.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 13/08/25.
//

import SwiftUI
import SwiftData

@main
struct SwiftStoreAppApp: App {
    
    var body: some Scene {
        WindowGroup {
            TabBar()
        }
        .modelContainer(for: UserProduct.self)
    }
}
