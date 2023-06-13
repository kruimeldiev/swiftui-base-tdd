//
//  HomeViewModel.swift
//  ios_base_testing
//
//  Created by Casper on 22/05/2023.
//

import SwiftUI
import Combine
import Factory

class HomeViewModel: ObservableObject {
    
    @Injected(\.authManager) private var authManager
    @Injected(\.itemManager) private var itemsManager
    
    private var cancellebles = Set<AnyCancellable>()
    
    @Published var newItemName: String = ""
    @Published var errorMessage = ""
    @Published var items = [ItemModels.ItemModel]()
    
    @Published var updateItemTitle: String = ""
    @Published var updateItemTag: String = ""
    
    init() {
        itemsManager.readItems()
        subscribeToFirestoreUpdates()
    }
    
    @MainActor
    func signOutUser() async {
        do {
            try await authManager.signOutUser()
        } catch {
            self.errorMessage = ToDoListError.genericError.description
        }
    }
    
    @MainActor
    func addNewItem() async {
        guard newItemName != "" && newItemName.count < 128 else {
            self.errorMessage = ToDoListError.invalidTitle.description
            return
        }
        let newItem = ItemModels.ItemModel(id: UUID().uuidString,
                                           title: newItemName,
                                           isCompleted: false,
                                           tag: nil,
                                           spot: items.count)
        do {
            try await itemsManager.createOrUpdateItem(newItem)
            newItemName = ""
        } catch {
            self.errorMessage = ToDoListError.genericError.description
        }
    }
    
    @MainActor
    func checkOffItem(_ item: ItemModels.ItemModel) async {
        var updatedItem = item
        updatedItem.isCompleted.toggle()
        do {
            try await itemsManager.createOrUpdateItem(updatedItem)
        } catch {
            self.errorMessage = ToDoListError.genericError.description
        }
    }
    
    @MainActor
    func changeItem(_ itemToChange: ItemModels.ItemModel) async {
        var item = itemToChange
        item.title = !updateItemTitle.isEmpty ? updateItemTitle : item.title
        item.tag = updateItemTag.isEmpty ? nil : updateItemTag
        do {
            try await itemsManager.createOrUpdateItem(item)
            updateItemTitle = ""
            updateItemTag = ""
        } catch {
            self.errorMessage = ToDoListError.genericError.description
        }
    }
    
    @MainActor
    func deleteItem(_ itemId: String) async {
        guard let itemToDelete = items.first(where: { $0.id == itemId }) else { return }
        do {
            try await itemsManager.deleteItem(itemToDelete)
        } catch {
            self.errorMessage = ToDoListError.genericError.description
        }
    }
}

private extension HomeViewModel {
    
    func subscribeToFirestoreUpdates() {
        itemsManager.publisher
            .sink { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                }
            } receiveValue: { items in
                self.items = items.sorted { $0.spot < $1.spot }
            }
            .store(in: &cancellebles)
    }
}
