//
//  RegisterView.swift
//  ios_base_testing
//
//  Created by Casper on 22/05/2023.
//

import SwiftUI
import Factory

struct RegisterView: View {
    
    @StateObject var viewModel: RegisterViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            Text("Sign up")
                .font(.title)
            VStack(alignment: .leading, spacing: 20) {
                TextField("Email address", text: $viewModel.user.email)
                    .keyboardType(.emailAddress)
                    .font(.callout)
                    .padding(12)
                    .background(.white)
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.3), radius: 3)
                SecureField("Password", text: $viewModel.user.password)
                    .font(.callout)
                    .padding(12)
                    .background(.white)
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.3), radius: 3)
                SecureField("Confirm password", text: $viewModel.user.confirmPassword)
                    .font(.callout)
                    .padding(12)
                    .background(.white)
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.3), radius: 3)
                TextField("Username", text: $viewModel.user.username)
                    .font(.callout)
                    .padding(12)
                    .background(.white)
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.3), radius: 3)
            }
            if viewModel.errorMessage.count > 0 {
                HStack(alignment: .center) {
                    Spacer()
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                    Spacer()
                }
            }
            VStack(alignment: .center) {
                HStack {
                    Spacer()
                    if viewModel.currentlyHandling {
                        ProgressView()
                    } else {
                        Button {
                            Task { await viewModel.handleRegister() }
                        } label: {
                            HStack {
                                Spacer()
                                Text("Register")
                                    .padding(12)
                                    .foregroundColor(.white)
                                    .font(.callout)
                                Spacer()
                            }
                            .background(.black)
                            .cornerRadius(12)
                            .shadow(color: .gray.opacity(0.3), radius: 3)
                        }
                    }
                    Spacer()
                }
            }
        }
        .padding(40)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        Container.shared.setupMocks()
        return RegisterView(viewModel: .init())
    }
}
