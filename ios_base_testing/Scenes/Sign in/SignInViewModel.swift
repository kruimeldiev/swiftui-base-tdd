//
//  SignInViewModel.swift
//  ios_base_testing
//
//  Created by Casper on 22/05/2023.
//

import SwiftUI
import Factory

class SignInViewModel: ObservableObject {
    
    @Injected(\.authManager) private var authManager
    
    @Published var user = AuthModels.SignInUser(email: "", password: "")
    @Published var errorMessage = ""
    @Published var currentlyHandling = false
    
    @MainActor
    func handleLogin() async {
        guard user.email.isValidEmail else {
            self.errorMessage = AuthenticationError.invalidEmailAddress.description
            return
        }
        guard user.password.isValidPassword else {
            self.errorMessage = AuthenticationError.incompleteCredentials.description
            return
        }
        currentlyHandling = true
        do {
            try await authManager.signInUser(user)
        } catch {
            self.errorMessage = AuthenticationError.noCorrespondingAccount.description
        }
        self.currentlyHandling = false
    }
}
