//
//  File.swift
//  
//
//  Created by Devran on 06.06.19.
//

import Foundation

extension String {
    enum letterCase {
        case upper
        case lower
    }
    
    func camelCased(_ firstLetterCase: letterCase) -> String {
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
    
    var pluralized: String {
        return self + "s"
    }
}
