//
//  RegisterViewModel.swift
//  ios_base_testing
//
//  Created by Casper on 22/05/2023.
//

import SwiftUI
import Factory

class RegisterViewModel: ObservableObject {
    
    @Injected(\.authManager) private var authManager
    
    @Published var user = AuthModels.RegisterUser(email: "",
                                                  password: "",
                                                  confirmPassword: "",
                                                  username: "")
    @Published var errorMessage = ""
    @Published var currentlyHandling = false
    
    @MainActor
    func handleRegister() async {
        /// 1. Validate the data
        guard user.email.isValidEmail else {
            self.errorMessage = AuthenticationError.invalidEmailAddress.description
            return
        }
        guard user.password.count > 7 else {
            self.errorMessage = AuthenticationError.weakPassword.description
            return
        }
        guard user.password == user.confirmPassword else {
            self.errorMessage = AuthenticationError.mismatchedPasswords.description
            return
        }
        guard user.email.isValidEmail && user.password.isValidPassword && user.username.isValidUsername else {
            self.errorMessage = AuthenticationError.incompleteCredentials.description
            return
        }
        /// 2. Start handling
        currentlyHandling = true
        do {
            try await authManager.registerUser(user)
        } catch {
            self.errorMessage = AuthenticationError.genericError.description
        }
        self.currentlyHandling = false
    }
}
