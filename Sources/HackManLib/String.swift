//
//  File.swift
//  
//
//  Created by Devran on 06.06.19.
//

import Foundation

extension StringLiteralType {
    enum LetterCase {
        case upper
        case lower
    }
    
    func camelCased(_ firstLetterCase: LetterCase) -> String {
        var string = ""
        
        for (index, word) in self.split(separator: "_").enumerated() {
            if firstLetterCase == .lower && index == 0 {
                string.append(String(word).lowercased())
            } else {
                string.append(String(word).capitalized)
            }
        }
        
        return string
    }
    
    func camelCasedIfNeeded(_ firstLetterCase: LetterCase) -> String {
        guard let firstLetter = self.first else {
            fatalError("String empty!")
        }
        
        if self.contains("_") || firstLetter.isUppercase && firstLetterCase != .upper || firstLetter.isLowercase && firstLetterCase != .lower {
            return self.camelCased(firstLetterCase)
        } else {
            return self
        }
    }
    
    func colored(_ color: TerminalColor) -> String {
        return "\(color.rawValue)\(self)\(TerminalColor.default.rawValue)"
    }
}
