//
//  File.swift
//  
//
//  Created by Devran Uenal on 04.06.19.
//

import Foundation
import PathKit
import Stencil

public protocol Generator {
    init()
    func generate(arguments: [String], options: [String])
    func help()
}

extension Generator {
    var generatorName: String {
        return String(describing: type(of: self))
    }
    
    var basePath: Path {
        var bundlePath = Bundle.main.bundlePath.split(separator: "/")
        bundlePath.removeLast(2)
        let generatorsPath = bundlePath.joined(separator: "/")
        return Path("/\(generatorsPath)/Sources/HackManLib/Generators/\(generatorName)")
    }
    
    var loader: FileSystemLoader {
        return FileSystemLoader(paths: [basePath])
    }
    
    var environment: Environment {
        Environment(loader: loader)
    }
}
