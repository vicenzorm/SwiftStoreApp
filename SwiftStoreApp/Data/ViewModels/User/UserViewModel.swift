//
//  File.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 14/08/25.
//

import Foundation

@Observable
@MainActor
class UserViewModel {

    private var service: UserService
    var currentUser: User?
    
    init(service: UserService) {
        self.service = service
        self.currentUser = service.loadUser()
    }
}
