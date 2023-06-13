//
//  AuthModels.swift
//  ios_base_testing
//
//  Created by Casper on 22/05/2023.
//

import Foundation

enum AuthModels {
    
    struct SignInUser {
        var email: String
        var password: String
    }
    
    struct RegisterUser {
        var email: String
        var password: String
        var confirmPassword: String
        var username: String
    }
}
