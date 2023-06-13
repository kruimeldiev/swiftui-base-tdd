//
//  UserModels.swift
//  ios_base_testing
//
//  Created by Casper on 07/06/2023.
//

import Foundation

enum UserModels {
    
    struct LoggedInUser: Codable {
        let email, uid, username: String
    }
}
