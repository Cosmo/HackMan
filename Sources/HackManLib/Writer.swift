//
//  File.swift
//  
//
//  Created by Devran on 15.08.19.
//

import Foundation

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
            print(nextPath)
            try? FileManager().createDirectory(atPath: nextPath, withIntermediateDirectories: true, attributes: nil)
            previousPath = nextPath
        }
    }
    
    static func write(contents: String, toFile filePath: String) {
        createPath(basePath(of: filePath))
        try? contents.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
    }
}

