//
//  File.swift
//  
//
//  Created by Devran on 15.08.19.
//

import Foundation

public enum Command {
    case new
    case localize
    case generate
    case unknown
    
    public init(command: String) {
        switch command {
        case "new": self = .new
        case "localize", "l": self = .localize
        case "generate", "g": self = .generate
        default: self = .unknown
        }
    }
    
    public func run(arguments: [String], options: [String]) {
        print(self)
        
        switch self {
        case .new:
            if arguments.count > 0 {
                NewProject().generate(arguments: arguments, options: options)
            } else {
                print("No project name provided.")
                print("hackman new [AppName]")
            }
        case .localize:
            Localization().generate(arguments: arguments, options: options)
        case .generate:
            var arguments = arguments
            let generatorName = arguments.removeFirst()
            if let generator = NSClassFromString(generatorName.camelCased(.upper)) as? Generator.Type {
                generator.init().generate(arguments: arguments, options: options)
            } else {
                print("No generator name provided.")
                print("hackman generate [Generator]")
                print("or")
                print("hackman g [Generator]")
            }
        default:
            print("Unknown command.")
            print("Try one of those commands:")
            print("hackman new [AppName]")
            print("hackman generate app_delegate")
            print("hackman generate asset_catalog")
            print("hackman generate launch_screen")
            print("hackman generate reusable_view")
            print("hackman generate coordinator")
            print("hackman generate coordinator_main")
            print("hackman generate coordinator_child [Name]")
            print("hackman generate model [Name] [Property1]:[Type] [Property2]:[Type] …")
            print("hackman generate view_controller [Name]")
            print("hackman generate view_controller_collection [Name] [Property1]:[Type] [Property2]:[Type] …")
            print("hackman generate collection_view_cell [Name] [Property1]:[Type] [Property2]:[Type] …")
            print("hackman generate view_controller_table [Name] [Property1]:[Type] [Property2]:[Type] …")
            print("hackman generate table_view_cell [Name] [Property1]:[Type] [Property2]:[Type] …")
            print("hackman generate view_controller_detail [Name] [Property1]:[Type] [Property2]:[Type] …")
            print("hackman generate view_controller_web")
            print("hackman generate view_controller_information")
            print("hackman generate scaffold [Name] [Property1]:[Type] [Property2]:[Type] …")
        }
    }
}
