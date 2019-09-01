//
//  File.swift
//  
//
//  Created by Devran Uenal on 04.06.19.
//

import Foundation

struct Property: Equatable {
    public let name: String
    public let valueType: String
    
    public var isCustomResource: Bool {
        return !Property.basicTypes.contains(valueType)
    }
    
    static var basicTypes = [
        "Bool",
        "Date",
        "Double",
        "Float",
        "Int",
        "String",
    ]
    
    init(name: String, valueType: String, isArray: Bool = false) {
        self.name = name
        self.valueType = valueType.upperCamelCased()
    }
    
    init?(input: String) {
        let splitStrings = input.split(separator: ":").map({ String($0) })
        guard let name = splitStrings.first else {
            return nil
        }
        let valueTypeSubsequence = (splitStrings.count == 1 ? "String" : splitStrings[1])
        let valueType = String(valueTypeSubsequence).upperCamelCased()
        self.name = name.lowerCamelCased()
        self.valueType = valueType
    }
    
    static func createList(inputStrings: [String]) -> [Property] {
        return inputStrings.compactMap { Property(input: $0) }
    }
}

extension Property {
    func stringForMockContent(placeholder: String?) -> String {
        switch valueType {
        case "Bool":
            return Int.random(in: 0...1) == 1 ? "true" : "false"
        case "Date":
            return "Date()"
        case "Double":
            return String(Double.random(in: 1..<100))
        case "Float":
            return String(Float.random(in: 1..<100))
        case "Int":
            return String(Int.random(in: 1..<100))
        case "String":
            guard let placeholder = placeholder else {
                return "String"
            }
            return "\"\(placeholder)\""
        default:
            return "\(valueType).sampleData().first!"
        }
    }
}
