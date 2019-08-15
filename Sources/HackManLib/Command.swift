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
                print("app new [project_name]")
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
                print("app generate [generator]")
                print("or")
                print("app g [generator]")
            }
        default:
            print("Unknown command.")
            print("Try one of those commands:")
            print("app new MusicApp")
            print("app g scaffold Album name uuid artist:Artist createdAt:Date updatedAt:Date -f")
            print("app g view_controller_information -f")
            print("app g coordinator_main Song Artist Album --include=Information -f")
            print("app g asset_catalog -f")
            print("app g launch_screen -f")
            print("app g localization -l=de,en")
            print("app g write -f")
        }
    }
}
