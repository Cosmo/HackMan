//
//  File.swift
//  
//
//  Created by Devran on 15.08.19.
//

import Stencil
import Foundation
import HackManLib

var arguments = CommandLine.arguments

let options = arguments.filter { $0.starts(with: "-") }
arguments = arguments.filter { !options.contains($0) }

do {
    try _ = CommandLineRunner(arguments: arguments, options: options)
} catch let error as CommandLineRunner.CommandError {
    switch error {
    case CommandLineRunner.CommandError.noCommand:
        CommandLineRunner.printCommandUsage()
    case .unknownCommand(let name):
        print("Unknown command \"\(name)\".")
        print()
        CommandLineRunner.printCommandUsage()
    }
} catch let error as CommandLineRunner.GeneratorCommandError {
    switch error {
    case .noGenerator:
        CommandLineRunner.printGeneratorUsage()
    case .unknownGenerator:
        print("Unknown generator.")
        print()
        CommandLineRunner.printGeneratorUsage()
    }
}
