//
//  AuthManagerMock.swift
//  ios_base_testing
//
//  Created by Casper on 05/06/2023.
//

import Foundation

class AuthManagerMock: AuthManagerProtocol {
    
    var signInUserCalled = false
    var signOutUserCalled = false
    var registerUserCalled = false
    
    func signInUser(_ user: AuthModels.SignInUser) async throws {
        if user.email == "unregisteredUser@d-tt.nl" { throw AuthenticationError.noCorrespondingAccount }
        signInUserCalled = true
    }
    
    func signOutUser() async throws {
        signOutUserCalled = true
    }
    
    func registerUser(_ user: AuthModels.RegisterUser) async throws {
        registerUserCalled = true
    }
}
