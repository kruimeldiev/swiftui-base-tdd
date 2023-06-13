//
//  AuthModelStubs.swift
//  ios_base_testing
//
//  Created by Casper on 05/06/2023.
//

import Foundation

enum AuthModelStubs {
    
    // MARK: - Sign in user
    struct SignInUser {
        static var stubSuccess: AuthModels.SignInUser {
            return AuthModels.SignInUser(email: "daris@d-tt.nl",
                                         password: "Admin123")
        }
        
        static var stubInvalidCredentials: AuthModels.SignInUser {
            return AuthModels.SignInUser(email: "daris",
                                         password: "admin")
        }
        
        static var stubIncompleteCredentials: AuthModels.SignInUser {
            return AuthModels.SignInUser(email: "daris@d-tt.nl",
                                         password: "")
        }
        
        static var stubUnregisteredEmail: AuthModels.SignInUser {
            return AuthModels.SignInUser(email: "unregisteredUser@d-tt.nl",
                                         password: "Admin123")
        }
    }
    
    // MARK: - Register user
    struct RegisterUser {
        static var stubSuccess: AuthModels.RegisterUser {
            return AuthModels.RegisterUser(email: "daris@d-tt.nl",
                                           password: "Admin123",
                                           confirmPassword: "Admin123",
                                           username: "Casper")
        }
        
        static var stubInvalidEmail: AuthModels.RegisterUser {
            return AuthModels.RegisterUser(email: "daris",
                                           password: "Admin123",
                                           confirmPassword: "Admin123",
                                           username: "Casper")
        }
        
        static var stubMismatchedPasswords: AuthModels.RegisterUser {
            return AuthModels.RegisterUser(email: "daris@d-tt.nl",
                                           password: "Admin123",
                                           confirmPassword: "admin123",
                                           username: "Casper")
        }
        
        static var stubWeakPassword: AuthModels.RegisterUser {
            return AuthModels.RegisterUser(email: "daris@d-tt.nl",
                                           password: "123",
                                           confirmPassword: "123",
                                           username: "Casper")
        }
        
        static var stubIncompleteCredentials: AuthModels.RegisterUser {
            return AuthModels.RegisterUser(email: "daris@d-tt.nl",
                                           password: "Admin123",
                                           confirmPassword: "Admin123",
                                           username: "")
        }
    }
}
