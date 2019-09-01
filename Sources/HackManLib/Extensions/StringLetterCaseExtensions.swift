//
//  File.swift
//  
//
//  Created by Devran on 01.09.19.
//

import Foundation

extension StringLiteralType {
    var isSnakeCase: Bool {
        // Strip all underscores and check if the rest is lowercase
        return self.filter{ $0 != "_" }.allSatisfy { $0.isLowercase }
    }
    
    var isLowerCamelCase: Bool {
        // Check if the first letter is lowercase and the rest contains letters
        if let firstCharacter = self.first, firstCharacter.isLowercase && self.allSatisfy { $0.isLetter } {
            return true
        }
        return false
    }
    
    var isUpperCamelCase: Bool {
        // Check if the first letter is uppercase and the rest contains letters
        if let firstCharacter = self.first, firstCharacter.isUppercase && self.allSatisfy { $0.isLetter } {
            return true
        }
        return false
    }
}

extension StringLiteralType {
    func lowerCamelCased() -> String {
        if self.isLowerCamelCase {
            return self
        }
        
        return self.split(separator: "_").enumerated().map { (offset, element) -> String in
            if offset == 0 {
                return String(element).lowercased()
            } else {
                return String(element).capitalized
            }
        }.joined()
    }
    
    func upperCamelCased() -> String {
        if self.isUpperCamelCase {
            return self
        }
        return self.split(separator: "_").map({ String($0).capitalized }).joined()
    }
}
