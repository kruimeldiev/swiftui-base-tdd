//
//  ios_base_testingApp.swift
//  ios_base_testing
//
//  Created by Casper on 22/05/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct ios_base_testingApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    /// The authHanlder listens for the user's login state, when this state changes, the handler acts accordingly by toggling the userIsLoggedIn bool
    @State private var authHandler: AuthStateDidChangeListenerHandle?
    @State private var userIsLoggedIn = false
    
    var body: some Scene {
        WindowGroup {
            VStack {
                if userIsLoggedIn {
                    HomeView(viewModel: .init())
                } else {
                    SignInView(viewModel: .init())
                }
            }.onAppear {
                authHandler = Auth.auth().addStateDidChangeListener { _, user in
                    userIsLoggedIn = (user != nil)
                }
            }.onDisappear {
                Auth.auth().removeStateDidChangeListener(authHandler!)
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
