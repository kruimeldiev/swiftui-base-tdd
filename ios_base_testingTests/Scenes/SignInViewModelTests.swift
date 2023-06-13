//
//  SignInViewModelTests.swift
//  ios_base_testingTests
//
//  Created by Casper on 22/05/2023.
//

@testable import ios_base_testing
import XCTest
import Factory

final class SignInViewModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
        Container.shared.setupMocks()
    }
    
    func test_handleLogin_WithValidCredentials_IsSignedIn() async {
        // Given
        let sut = SignInViewModel()
        sut.user = AuthModelStubs.SignInUser.stubSuccess
        // When
        await sut.handleLogin()
        // Then
        XCTAssertEqual(sut.errorMessage, "")
        XCTAssertFalse(sut.currentlyHandling)
    }
    
    func test_handleLogin_WithInvalidCredentials_ReturnsError() async {
        // Given
        let sut = SignInViewModel()
        sut.user = AuthModelStubs.SignInUser.stubInvalidCredentials
        // When
        await sut.handleLogin()
        // Then
        XCTAssertEqual(sut.errorMessage, AuthenticationError.invalidEmailAddress.description)
        XCTAssertFalse(sut.currentlyHandling)
    }
    
    func test_handleLogin_WithIncompleteCredentials_ReturnsError() async {
        // Given
        let sut = SignInViewModel()
        sut.user = AuthModelStubs.SignInUser.stubIncompleteCredentials
        // When
        await sut.handleLogin()
        // Then
        XCTAssertEqual(sut.errorMessage, AuthenticationError.incompleteCredentials.description)
        XCTAssertFalse(sut.currentlyHandling)
    }
    
    func test_handleLogin_WithUnregisteredEmail_ReturnsError() async {
        // Given
        let sut = SignInViewModel()
        sut.user = AuthModelStubs.SignInUser.stubUnregisteredEmail
        // When
        await sut.handleLogin()
        // Then
        XCTAssertEqual(sut.errorMessage, AuthenticationError.noCorrespondingAccount.description)
        XCTAssertFalse(sut.currentlyHandling)
    }
}
