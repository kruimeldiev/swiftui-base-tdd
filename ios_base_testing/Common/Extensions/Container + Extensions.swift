//
//  Container + Extensions.swift
//  ios_base_testing
//
//  Created by Casper on 04/06/2023.
//

import Foundation
import Factory

extension Container {
    
    func setupMocks() {
        Container.shared.authManager.register { AuthManagerMock() }
        Container.shared.itemManager.register { ItemsManagerMock() }
    }
    
    var authManager: Factory<AuthManagerProtocol> {
        self { AuthManager() }
    }
    
    var itemManager: Factory<ItemsManagerProtocol> {
        self { ItemsManager() }
    }
}
