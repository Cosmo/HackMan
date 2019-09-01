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
    private var isAllLetters: Bool {
        return self
            .allSatisfy({ $0.isLetter })
    }
    
    var capitalizedStrings: [String] {
        return self
            .split(separator: "_")
            .map({ String($0).capitalized })
    }
    
    func lowerCamelCased() -> String {
        if self.isLowerCamelCase { return self }
        if self.isAllLetters { return prefix(1).lowercased() + dropFirst() }
        
        var strings = capitalizedStrings
        if let firstString = strings.first {
            strings[0] = firstString.lowercased()
        }
        return strings.joined()
    }
    
    func upperCamelCased() -> String {
        if self.isUpperCamelCase { return self }
        if self.isAllLetters { return prefix(1).uppercased() + dropFirst() }
        return capitalizedStrings.joined()
    }
}
