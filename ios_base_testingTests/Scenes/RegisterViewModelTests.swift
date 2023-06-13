//
//  RegisterViewModelTests.swift
//  ios_base_testingTests
//
//  Created by Casper on 22/05/2023.
//

@testable import ios_base_testing
import XCTest
import Factory

final class RegisterViewModelTests: XCTestCase {
    
    override class func setUp() {
        super.setUp()
        Container.shared.setupMocks()
    }

    func test_handleRegister_WithValidCredentials_IsSignedIn() async {
        // Given
        let sut = RegisterViewModel()
        sut.user = AuthModelStubs.RegisterUser.stubSuccess
        // When
        await sut.handleRegister()
        // Then
        XCTAssertEqual(sut.errorMessage, "")
        XCTAssertFalse(sut.currentlyHandling)
    }
    
    func test_handleRegister_WithInvalidEmail_ReturnsError() async {
        // Given
        let sut = RegisterViewModel()
        sut.user = AuthModelStubs.RegisterUser.stubInvalidEmail
        // When
        await sut.handleRegister()
        // Then
        XCTAssertEqual(sut.errorMessage, AuthenticationError.invalidEmailAddress.description)
        XCTAssertFalse(sut.currentlyHandling)
    }
    
    func test_handleRegister_WithDifferentPasswords_ReturnsError() async {
        // Given
        let sut = RegisterViewModel()
        sut.user = AuthModelStubs.RegisterUser.stubMismatchedPasswords
        // When
        await sut.handleRegister()
        // Then
        XCTAssertEqual(sut.errorMessage, AuthenticationError.mismatchedPasswords.description)
        XCTAssertFalse(sut.currentlyHandling)
    }
    
    func test_handleRegister_WithWeakPassword_ReturnsError() async {
        // Given
        let sut = RegisterViewModel()
        sut.user = AuthModelStubs.RegisterUser.stubWeakPassword
        // When
        await sut.handleRegister()
        // Then
        XCTAssertEqual(sut.errorMessage, AuthenticationError.weakPassword.description)
        XCTAssertFalse(sut.currentlyHandling)
    }
    
    func test_handleRegister_WithIncompleteCredentials_ReturnsError() async {
        // Given
        let sut = RegisterViewModel()
        sut.user = AuthModelStubs.RegisterUser.stubIncompleteCredentials
        // When
        await sut.handleRegister()
        // Then
        XCTAssertEqual(sut.errorMessage, AuthenticationError.incompleteCredentials.description)
        XCTAssertFalse(sut.currentlyHandling)
    }
}
