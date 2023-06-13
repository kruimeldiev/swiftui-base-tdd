//
//  ToDoListError.swift
//  ios_base_testing
//
//  Created by Casper on 06/06/2023.
//

import Foundation

enum ToDoListError: Error {
    
    case genericError
    case invalidTitle
    
    var description: String {
        switch self {
            case .genericError:
                return "Unknown error occured"
            case .invalidTitle:
                return "Invalid item title"
        }
    }
}
