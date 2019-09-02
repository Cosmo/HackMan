//
//  File.swift
//  
//
//  Created by Devran on 01.09.19.
//

import Foundation
import StringCase

struct Resource {
    var name: String
    var properties: [Property]?
    var nameForFunction: String
    var pluralizedName: String
    var pluralizedNameForFunction: String
    
    init(name: String, properties: [Property]?) {
        self.name = name.upperCamelCased()
        self.nameForFunction = self.name.lowerCamelCased()
        
        let pluralizedName = self.name.pluralized()
        if pluralizedName == self.name {
            self.pluralizedName = self.name + "Items"
        } else {
            self.pluralizedName = self.name.pluralized()
        }
        
        self.pluralizedNameForFunction = self.pluralizedName.lowerCamelCased()
        
        self.properties = properties
    }
}
