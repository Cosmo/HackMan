//
//  File.swift
//  
//
//  Created by Devran on 15.08.19.
//

import Foundation

struct Writer {
    static func write(contents: String, toFile filePath: String) {
        var paths = filePath.split(separator: "/")
        paths.removeLast()
        
        _ = paths.reduce("") {(result, next) -> String in
            if result == "" { return String(next) }
            
            let nextPath = result + "/" + next
            try? FileManager().createDirectory(atPath: nextPath, withIntermediateDirectories: true, attributes: nil)
            
            return nextPath
        }
        
        try? contents.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
    }
}

