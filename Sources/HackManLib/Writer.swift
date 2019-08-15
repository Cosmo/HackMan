//
//  File.swift
//  
//
//  Created by Devran on 15.08.19.
//

import Foundation
import PathKit

struct Writer {
    static func basePath(of filePath: String) -> String {
        var directories = filePath.split(separator: "/")
        directories.removeLast()
        return directories.joined(separator: "/")
    }
    
    static func createPath(_ path: String) {
        var previousPath: String?
        for path in path.split(separator: "/") {
            let nextPath = [previousPath, String(path)].compactMap { $0 }.joined(separator: "/")
            
            if Path(nextPath).exists {
                print("\(nextPath)/ skipped.")
            } else {
                try? FileManager().createDirectory(atPath: nextPath, withIntermediateDirectories: true, attributes: nil)
                print("\(nextPath)/ created.")
            }
            
            previousPath = nextPath
        }
    }
    
    static func write(contents: String, toFile filePath: String) {
        createPath(basePath(of: filePath))
        let paths = filePath.split(separator: "/")
        
        if let file = paths.last {
            let spaces = String(repeating: "  ", count: paths.count > 0 ? paths.count - 1 : 0)
            print("\(spaces)\(file) created.")
        }
        
        try? contents.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
    }
}

