//
//  File.swift
//
//
//  Created by Devran on 15.08.19.
//

import Foundation
import PathKit

protocol Writeable {
    var path: String { get }
    func create()
}

struct Writer {
    struct Directory: Writeable, Hashable {
        var path: String
        func create() {
            guard let directory = path.split(separator: "/").last else { fatalError() }
            
            let depth = path.split(separator: "/").count
            let indention = String(repeating: "  ", count: depth)

            if Path(path).exists {
                print("   skip \(indention)\(directory)")
            } else {
                try? FileManager().createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                print(" create \(indention)\(directory)")
            }
        }
    }

    struct File: Writeable, Hashable {
        var path: String
        var contents: String
        func create() {
            let paths = path.split(separator: "/")
            
            if let file = paths.last {
                let indention = String(repeating: "  ", count: paths.count)
                print(" create \(indention)\(file)")
            }
            
            try? contents.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
        }
    }
    
    static var creatables: [Writeable] = []
    
    static func basePath(of filePath: String) -> String {
        var directories = filePath.split(separator: "/")
        directories.removeLast()
        return directories.joined(separator: "/")
    }
    
    static func createPath(_ path: String) {
        var previousPath: String?
        for path in path.split(separator: "/") {
            let nextPath = [previousPath, String(path)].compactMap { $0 }.joined(separator: "/")
            
            let directory = Directory(path: nextPath)
            if !creatables.contains(where: { $0.path == directory.path }) {
                creatables.append(directory)
            }
            
            previousPath = nextPath
        }
    }
    
    static func createFile(_ path: String, contents: String) {
        createPath(basePath(of: path))
        creatables.append(File(path: path, contents: contents))
    }
    
    static func finish() {
        for creatable in creatables.sorted(by: { $0.path < $1.path }) {
            creatable.create()
        }
    }
}
