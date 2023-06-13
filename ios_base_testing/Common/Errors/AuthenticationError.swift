//
//  AuthenticationError.swift
//  ios_base_testing
//
//  Created by Casper on 04/06/2023.
//

import Foundation

enum AuthenticationError: Error {
    
    case genericError
    
    case noCorrespondingAccount
    case invalidEmailAddress
    case weakPassword
    case mismatchedPasswords
    case incompleteCredentials
    
    var description: String {
        switch self {
            case .genericError:
                return "Unknown error occured"
            case .noCorrespondingAccount:
                return "No corresponding account found"
            case .invalidEmailAddress:
                return "Invalid email address"
            case .weakPassword:
                return "Weak password"
            case .mismatchedPasswords:
                return "Password mismatch"
            case .incompleteCredentials:
                return "Credentials incomplete"
        }
    }
}
