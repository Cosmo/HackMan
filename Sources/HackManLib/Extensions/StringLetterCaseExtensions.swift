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
    enum LetterCase {
        case upper
        case lower
    }

    func camelCased(_ firstLetterCase: LetterCase) -> String {
        var camelCasedString = ""
        
        for (index, word) in self.split(separator: "_").enumerated() {
            if firstLetterCase == .lower && index == 0 {
                camelCasedString.append(String(word).lowercased())
            } else {
                camelCasedString.append(String(word).capitalized)
            }
        }
        
        return camelCasedString
    }
    
    func camelCasedIfNeeded(_ firstLetterCase: LetterCase) -> String {
        if firstLetterCase == .upper && !isUpperCamelCase || firstLetterCase == .lower && !isLowerCamelCase {
            return self.camelCased(firstLetterCase)
        } else {
            return self
        }
    }
}
