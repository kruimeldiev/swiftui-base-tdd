//
//  FirebaseKeys.swift
//  ios_base_testing
//
//  Created by Casper on 04/06/2023.
//

import Foundation

enum FirebaseKeys: Equatable {
   
    /// The names of all the collections we've got in Firestore
    enum Collections: String {
        case users
        case userItems
    }
    
    /// UserDocument properties as stored in Firestore
    enum UserDocument: String {
        case uid
        case email
        case username
    }
    
    /// Represents To-Do list Items as stored in Firestore
    enum UserItemDocument: String {
        case id
        case isCompleted
        case spot
        case tag
        case title
    }
}
