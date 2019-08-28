//
//  File.swift
//  
//
//  Created by Devran on 15.08.19.
//

import Foundation

public struct CommandLineRunner {
    public enum Command {
        case new
        case generate
        case help
        case unknown(name: String)
        
        init(name: String) {
            switch name.lowercased() {
            case "new": self = .new
            case "generate", "g": self = .generate
            case "help": self = .help
            default: self = .unknown(name: name)
            }
        }
    }
    
    public init(arguments: [String], options: [String]) throws {
        var arguments = arguments
        let options = options
        
        // No need for executable name
        arguments.removeFirst()
        
        guard !arguments.isEmpty else {
            throw CommandError.noCommand
        }
        
        let command = Command(name: arguments.removeFirst().lowercased())
        
        if options.contains("--verbose") {
            print("Command: \(command)")
            print("Arguments: \(arguments)")
            print("Options: \(options)")
            print()
        }
        
        switch command {
        case .new:
            NewProject().generate(arguments: arguments, options: options)
        case .generate:
            guard !arguments.isEmpty else { throw GeneratorCommandError.noGenerator }
            let generatorName = arguments.removeFirst().camelCasedIfNeeded(.upper)
            guard let generator = NSClassFromString(generatorName) as? Generator.Type else {
                throw GeneratorCommandError.unknownGenerator
            }
            generator.init().generate(arguments: arguments, options: options)
            Writer.finish()
            
            Bash.exec(commands: "xcodegen")
            
        case .help:
            print("Find help on: https://github.com/Cosmo/HackMan")
        case .unknown(let name):
            throw CommandError.unknownCommand(name: name)
        }
    }
}

extension CommandLineRunner {
    public enum CommandError: Error {
        case noCommand
        case unknownCommand(name: String)
    }
    
    public static func printCommandUsage() {
        print("Usage: hackman COMMAND")
        print()
        print("Commands:")
        print("  new APP_NAME")
        print("  generate")
        print()
        print("Example:")
        print("  hackman new AwesomeApp")
        print("  hackman generate")
    }
}

extension CommandLineRunner {
    public enum GeneratorCommandError: Error {
        case noGenerator
        case unknownGenerator
    }
    
    public static func printGeneratorUsage() {
        print("Usage: hackman generate GENERATOR")
        print()
        print("Generators:")
        print("  scaffold NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …")
        print("  app_delegate")
        print("  asset_catalog")
        print("  launch_screen")
        print("  reusable_view")
        print("  coordinator")
        print("  coordinator_main")
        print("  coordinator_child NAME")
        print("  model NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …")
        print("  view_controller NAME")
        print("  view_controller_collection NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …")
        print("  collection_view_cell NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …")
        print("  view_controller_table NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …")
        print("  table_view_cell NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …")
        print("  view_controller_detail NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …")
        print("  view_controller_web")
        print("  view_controller_information")
        print()
        print("Example:")
        print("  hackman generate scaffold song title:string artist_name:string album_name:string")
        print()
        print("Make sure to run generators inside of your project directory.")
    }
}
