//
//  File.swift
//  
//
//  Created by Devran Uenal on 04.06.19.
//

import Foundation

public struct Property {
    public let name: String
    public let valueType: String
    public let isArray: Bool
    
    init(name: String, valueType: String, isArray: Bool = false) {
        self.name = name
        self.valueType = valueType.camelCased(String.letterCase.upper)
        self.isArray = isArray
    }
    
    init(input: String) {
        let splitStrings = input.split(separator: ":")
        let nameSubsequence = splitStrings.first
        let valueTypeSubsequence = (splitStrings.count > 1 ? splitStrings[1] : "String")
        
        var name = String(nameSubsequence ?? "Invalid property name.")
        print("THIS IS THE TYPE: \(valueTypeSubsequence)")
        let valueType = String(valueTypeSubsequence).camelCased(String.letterCase.upper)
        var isArray = false
        
        if name.hasSuffix("s") {
            isArray = true
            name.removeLast()
        }
        
        self.name = name
        self.valueType = valueType
        self.isArray = isArray
    }
    
    static func createList(inputStrings: [String]) -> [Property] {
        var properties = [Property]()
        
        for inputString in inputStrings {
            properties.append(Property(input: inputString))
        }
        
        return properties
    }
    
    var isLinkable: Bool {
        !(["String", "Int", "Date"].contains(valueType) || isArray)
    }
    
    func mock(string: String?) -> String {
        switch valueType {
        case "String":
            guard let string = string else {
                return "String"
            }
            return "\"\(string)\""
        case "Int":
            return String(Int.random(in: 1..<100))
        case "Date":
            return "Date()"
        default:
            return "\(valueType).mock().first!"
        }
    }
}
