//
//  File.swift
//  
//
//  Created by Devran on 15.08.19.
//

import Foundation
import StringCase

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
            Writer.finish()
        case .generate:
            guard !arguments.isEmpty else { throw GeneratorCommandError.noGenerator }
            let generatorName = arguments.removeFirst().upperCamelCased()
            guard let generator = NSClassFromString(generatorName) as? Generator.Type else {
                throw GeneratorCommandError.unknownGenerator
            }
            
            if options.contains("-h") || options.contains("--help") {
                generator.help()
            } else {
                generator.init().generate(arguments: arguments, options: options)
            }
            
            Writer.finish()
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
        let generators: [Generator.Type] = [
            AppDelegate.self,
            AssetCatalog.self,
            CollectionViewCell.self,
            Coordinator.self,
            CoordinatorChild.self,
            CoordinatorMain.self,
            LaunchScreen.self,
            Model.self,
            ReusableView.self,
            Scaffold.self,
            TableViewCell.self,
            ViewController.self,
            ViewControllerCollection.self,
            ViewControllerDetail.self,
            ViewControllerInformation.self,
            ViewControllerTable.self,
            ViewControllerWeb.self,
        ]
        
        print("Usage: hackman generate GENERATOR")
        print()
        print("Generators:")
        for generator in generators {
            print("  \(generator.singleLineUsage())")
        }
        print()
        print("Example:")
        print("  hackman generate scaffold song title:string artist_name:string album_name:string")
        print()
        print("Make sure to run generators inside of your project directory.")
    }
}
