//
//  String + Validation.swift
//  ios_base_testing
//
//  Created by Casper on 04/06/2023.
//

import Foundation

extension String {
    
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}").evaluate(with: self)
    }
    
    var isValidUsername: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[a-zA-Z0-9]{4,18}").evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        NSPredicate(format: "SELF MATCHES %@", "\\w{7,32}").evaluate(with: self)
    }
}
