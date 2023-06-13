//
//  ItemsManager.swift
//  ios_base_testing
//
//  Created by Casper on 06/06/2023.
//

import SwiftUI
import Combine
import FirebaseFirestore

protocol ItemsManagerProtocol {
    
    var publisher: CurrentValueSubject<[ItemModels.ItemModel], Never> { get }
    
    func createOrUpdateItem(_ item: ItemModels.ItemModel) async throws
    func readItems()
    func deleteItem(_ item: ItemModels.ItemModel) async throws
}

class ItemsManager: ItemsManagerProtocol {
    
    @AppStorage(AppStorageKeys.loggedInUser.rawValue) private var signedInUser: Data = Data()
    
    public var publisher = CurrentValueSubject<[ItemModels.ItemModel], Never>([])
    
    private let firestore = Firestore.firestore()
    
    func createOrUpdateItem(_ item: ItemModels.ItemModel) async throws {
        do {
            let user = try JSONDecoder().decode(UserModels.LoggedInUser.self, from: signedInUser)
            try await firestore
                .collection(FirebaseKeys.Collections.users.rawValue)
                .document(user.uid)
                .collection(FirebaseKeys.Collections.userItems.rawValue)
                .document(item.id)
                .setData([FirebaseKeys.UserItemDocument.id.rawValue: item.id,
                          FirebaseKeys.UserItemDocument.isCompleted.rawValue: item.isCompleted,
                          FirebaseKeys.UserItemDocument.spot.rawValue: item.spot,
                          FirebaseKeys.UserItemDocument.tag.rawValue: item.tag,
                          FirebaseKeys.UserItemDocument.title.rawValue: item.title])
        } catch {
            throw ToDoListError.genericError
        }
    }
    
    func readItems() {
        guard let user = try? JSONDecoder().decode(UserModels.LoggedInUser.self, from: signedInUser) else { return }
        firestore
            .collection(FirebaseKeys.Collections.users.rawValue)
            .document(user.uid)
            .collection(FirebaseKeys.Collections.userItems.rawValue)
            .addSnapshotListener { query, error in
                guard let documents = query?.documents else { return }
                var array = [ItemModels.ItemModel]()
                for document in documents {
                    let data = document.data()
                    guard let id = data[FirebaseKeys.UserItemDocument.id.rawValue] as? String,
                          let title = data[FirebaseKeys.UserItemDocument.title.rawValue] as? String,
                          let isCompleted = data[FirebaseKeys.UserItemDocument.isCompleted.rawValue] as? Bool,
                          let spot = data[FirebaseKeys.UserItemDocument.spot.rawValue] as? Int else { return }
                    let tag = data[FirebaseKeys.UserItemDocument.tag.rawValue] as? String
                    array.append(.init(id: id,
                                       title: title,
                                       isCompleted: isCompleted,
                                       tag: tag,
                                       spot: spot))
                }
                self.publisher.send(array)
            }
    }
    
    func deleteItem(_ item: ItemModels.ItemModel) async throws {
        do {
            let user = try JSONDecoder().decode(UserModels.LoggedInUser.self, from: signedInUser)
            try await firestore
                .collection(FirebaseKeys.Collections.users.rawValue)
                .document(user.uid)
                .collection(FirebaseKeys.Collections.userItems.rawValue)
                .document(item.id)
                .delete()
        } catch {
            throw ToDoListError.genericError
        }
    }
}
