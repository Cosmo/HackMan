//
//  File.swift
//  
//
//  Created by Devran Uenal on 04.06.19.
//

import Foundation
import StringCase

struct Property: Equatable {
    public let name: String
    public var upperCamelCasedName: String
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
    
    private static var defaultValueType = "String"
    
    init(name: String, valueType: String?) {
        self.name = name.lowerCamelCased()
        self.upperCamelCasedName = self.name.upperCamelCased()
        
        self.valueType = valueType?.upperCamelCased() ?? Property.defaultValueType
    }
    
    init?(input: String) {
        let splitStrings = input.split(separator: ":").map({ String($0) })
        guard let name = splitStrings.first else { return nil }
        self.init(name: name, valueType: splitStrings.count > 1 ? splitStrings[1] : nil)
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
