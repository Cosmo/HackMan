//
//  File.swift
//  
//
//  Created by Devran Uenal on 04.06.19.
//

import Foundation
import PathKit

public protocol Generator {
    init()
    func generate(arguments: [String], options: [String])
    func help()
}

extension Generator {
    var path: Path {
        var bundlePath = Bundle.main.bundlePath.split(separator: "/")
        bundlePath.removeLast(2)
        let generatorsPath = bundlePath.joined(separator: "/")
        return Path("/\(generatorsPath)/Sources/HackManLib/Generators/\(String(describing: type(of: self)))")
    }
    
    func showHelpIfNeeded(options: [String]) {
        if options.contains("-h") || options.contains("--help") {
            help()
            exit(0)
        }
    }
}
