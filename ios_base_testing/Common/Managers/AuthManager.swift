//
//  AuthManager.swift
//  ios_base_testing
//
//  Created by Casper on 04/06/2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

protocol AuthManagerProtocol {
    func signInUser(_ user: AuthModels.SignInUser) async throws
    func signOutUser() async throws
    func registerUser(_ user: AuthModels.RegisterUser) async throws
}

class AuthManager: AuthManagerProtocol {
    
    @AppStorage(AppStorageKeys.loggedInUser.rawValue) private var signedInUser: Data = Data()
    
    private let firestore = Firestore.firestore()
    
    func signInUser(_ user: AuthModels.SignInUser) async throws {
        do {
            /// 1. Login the user
            let result = try await Auth.auth().signIn(withEmail: user.email, password: user.password)
            /// 2. Fetch user data from Firestore
            let loggedInUser = try await fetchCurrentUser(id: result.user.uid)
            /// 3. Encode the user into data and store in AppStorage
            signedInUser = try JSONEncoder().encode(loggedInUser)
        } catch {
            throw AuthenticationError.genericError
        }
    }
    
    func signOutUser() async throws {
        do {
            /// Sign out from Firebase
            try Auth.auth().signOut()
            /// Clear data for signed in user
            signedInUser = Data()
        } catch {
            throw AuthenticationError.genericError
        }
    }
    
    func registerUser(_ user: AuthModels.RegisterUser) async throws {
        do {
            /// 1. Register using FirebaseAuth
            let result = try await Auth.auth().createUser(withEmail: user.email, password: user.password)
            /// 2. Store user data in Firestore
            try await firestore
                .collection(FirebaseKeys.Collections.users.rawValue)
                .document(result.user.uid)
                .setData([FirebaseKeys.UserDocument.uid.rawValue: result.user.uid,
                          FirebaseKeys.UserDocument.email.rawValue: user.email,
                          FirebaseKeys.UserDocument.username.rawValue: user.username])
            /// 3. Create data object from the registered user
            let registeredUser = UserModels.LoggedInUser(email: user.email, uid: result.user.uid, username: user.username)
            /// 4. Store the signed in user in AppStorage
            signedInUser = try JSONEncoder().encode(registeredUser)
        } catch {
            throw AuthenticationError.genericError
        }
    }
}

private extension AuthManager {
    
    /// Fetches the currently logged in user from Firestore
    /// Used at sign in to make sure we have all the needed user data
    func fetchCurrentUser(id: String) async throws -> UserModels.LoggedInUser {
        do {
            let document = try await firestore
                .collection(FirebaseKeys.Collections.users.rawValue)
                .document(id)
                .getDocument()
            
            guard let data = document.data() else { throw AuthenticationError.genericError }
            guard let id = data[FirebaseKeys.UserDocument.uid.rawValue] as? String else { throw AuthenticationError.genericError }
            guard let email = data[FirebaseKeys.UserDocument.email.rawValue] as? String else { throw AuthenticationError.genericError }
            guard let username = data[FirebaseKeys.UserDocument.username.rawValue] as? String else { throw AuthenticationError.genericError }
            
            return .init(email: email, uid: id, username: username)
        } catch {
            throw AuthenticationError.genericError
        }
    }
}
