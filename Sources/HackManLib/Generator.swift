//
//  File.swift
//  
//
//  Created by Devran Uenal on 04.06.19.
//

import Foundation
import PathKit

protocol Generator {
    init()
    func generate(arguments: [String], options: [String])
}

extension Generator {
    var path: Path {
        var bundlePath = Bundle.main.bundlePath.split(separator: "/")
        bundlePath.removeLast(2)
        let generatorsPath = bundlePath.joined(separator: "/")
        return Path("/\(generatorsPath)/Sources/HackManLib/Generators/\(String(describing: type(of: self)))")
    }
}
