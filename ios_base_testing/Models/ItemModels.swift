//
//  ItemModels.swift
//  ios_base_testing
//
//  Created by Casper on 06/06/2023.
//

import Foundation

enum ItemModels {
    
    struct ItemModel: Identifiable {
        var id: String
        var title: String
        var isCompleted: Bool
        var tag: String?
        var spot: Int
    }
}
