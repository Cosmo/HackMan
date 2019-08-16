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

if options.contains("-v") {
    print("1.0")
    exit(0)
}

guard arguments.count > 0 else { fatalError("No path.") }
let path = arguments.removeFirst()

guard arguments.count > 0 else { fatalError("No arguments.") }
let command = arguments.removeFirst()

if options.contains("--verbose") {
    print("Verbose!")
    print("Path: \(path)")
    print("Command: \(command)")
    print("Options: \(options)")
    print("Arguments: \(arguments)")
}

Command(command: command).run(arguments: arguments, options: options)
