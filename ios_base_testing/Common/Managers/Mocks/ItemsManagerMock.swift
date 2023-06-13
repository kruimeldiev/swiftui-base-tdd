//
//  ItemsManagerMock.swift
//  ios_base_testing
//
//  Created by Casper on 06/06/2023.
//

import Foundation
import Combine

class ItemsManagerMock: ItemsManagerProtocol {
    
    public var publisher = CurrentValueSubject<[ItemModels.ItemModel], Never>([])
    
    private var items = ItemModelStubs.ItemModel.stubToDoItemArray
    
    func createOrUpdateItem(_ item: ItemModels.ItemModel) async throws {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            /// Item already exists in the array, replace it
            items[index] = item
            publisher.send(items)
        } else {
            /// Item doesn't exist in the array, add it
            items.append(item)
            publisher.send(items)
        }
    }
    
    func readItems() {
        publisher.send(items)
    }
    
    func deleteItem(_ item: ItemModels.ItemModel) async throws {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
            publisher.send(items)
        } else {
            throw ToDoListError.genericError
        }
    }
}
