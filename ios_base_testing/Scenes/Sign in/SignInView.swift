//
//  SignInView.swift
//  ios_base_testing
//
//  Created by Casper on 22/05/2023.
//

import SwiftUI
import Factory

struct SignInView: View {
    
    @StateObject var viewModel: SignInViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 40) {
                Text("Sign in")
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
                                Task { await viewModel.handleLogin() }
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Sign in")
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
                    Text("or")
                        .padding(.top, 8)
                        .foregroundColor(.gray)
                        .font(.caption)
                    NavigationLink {
                        RegisterView(viewModel: .init())
                    } label: {
                        Text("Register")
                            .padding(12)
                            .foregroundColor(.black)
                            .font(.callout)
                    }
                }
            }
            .padding(40)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        Container.shared.setupMocks()
        return SignInView(viewModel: .init())
    }
}
