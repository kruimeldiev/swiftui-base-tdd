//
//  ItemModelStubs.swift
//  ios_base_testing
//
//  Created by Casper on 06/06/2023.
//

import Foundation

enum ItemModelStubs {
    
    // MARK: - Item model
    struct ItemModel {
        static var stubToDoItem: ItemModels.ItemModel {
            return ItemModels.ItemModel(id: "1",
                                        title: "Lorem ipsum",
                                        isCompleted: false,
                                        tag: "Priority",
                                        spot: 0)
        }
        
        static var stubToDoItemArray: [ItemModels.ItemModel] {
            return [ItemModels.ItemModel(id: "1", title: "Lorem ipsum", isCompleted: false, tag: "Monday", spot: 0),
                    ItemModels.ItemModel(id: "2", title: "Vacuum living room", isCompleted: true, tag: nil, spot: 3),
                    ItemModels.ItemModel(id: "3", title: "Fold laundry", isCompleted: true, tag: "Wednesday", spot: 1),
                    ItemModels.ItemModel(id: "4", title: "Water plants", isCompleted: false, tag: "Saturday", spot: 4),
                    ItemModels.ItemModel(id: "5", title: "Clean kitchen", isCompleted: false, tag: "Sunday", spot: 2),
            ].sorted { $0.spot < $1.spot }
        }
    }
}
