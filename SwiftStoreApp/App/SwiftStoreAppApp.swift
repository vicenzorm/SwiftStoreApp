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
    
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: UserProduct.self)
        } catch {
            let ns = error as NSError
            print("error load no swift data")
            print("user info", ns.userInfo)
            assertionFailure("falha ao criar container")
            container = try! ModelContainer(for: UserProduct.self, configurations: .init(isStoredInMemoryOnly: true))
        }
    }
    
    var body: some Scene {
        WindowGroup {
            TabBar()
        }
        .modelContainer(container)
    }
}
