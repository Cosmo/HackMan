//
//  File.swift
//
//
//  Created by Devran on 15.08.19.
//

import Foundation
import PathKit

public protocol Writeable {
    var path: String { get }
    func create()
}

public struct Writer {
    static var creatables: [Writeable] = []
    
    public static func extractSourcePath(options: [String]) -> String {
        if let result = (options.filter { $0.contains("--source") || $0.contains("-s") }).first?.split(separator: "=").last {
            return String(result)
        } else {
            return "Source"
        }
    }
    
    public struct Directory: Writeable, Hashable {
        public var path: String
        public func create() {
            guard let directoryName = path.split(separator: "/").last else { fatalError() }
            
            let depth = path.split(separator: "/").count
            let indention = String(repeating: "  ", count: depth)
            
            if Path(path).exists {
                print("    \("invoke".colored(.white)) \(indention)\(directoryName)")
            } else {
                try? FileManager().createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                print("    \("create".colored(.green)) \(indention)\(directoryName)")
            }
        }
    }

    public struct File: Writeable, Hashable {
        public var path: String
        var contents: String
        var isForced: Bool = false
        
        public func create() {
            let paths = path.split(separator: "/")
            guard let fileName = paths.last else { return }
            let indention = String(repeating: "  ", count: paths.count)
            var isAllowedToWrite = false
            var isConflictPresent = false
            
            if Path(path).exists {
                if let oldContents: String = try? Path(path).read(String.Encoding.utf8), oldContents == contents {
                    print(" \("identical".colored(.green)) \(indention)\(fileName)")
                } else if isForced {
                    print("    \("forced".colored(.red)) \(indention)\(fileName)")
                    isAllowedToWrite = true
                } else {
                    print("  \("conflict".colored(.red)) \(indention)\(fileName)")
                    isConflictPresent = true
                }
            } else {
                print("    \("create".colored(.green)) \(indention)\(fileName)")
                isAllowedToWrite = true
            }
            
            if isConflictPresent {
                print("Overwrite \(fileName)? Enter [y/n]: ", terminator: "")
                if readLine() == "y" {
                    print(" \("overwrite".colored(.yellow)) \(indention)\(fileName)")
                    isAllowedToWrite = true
                }
            }
            
            guard isAllowedToWrite else { return }
            try? contents.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
        }
    }
    
    public static func basePath(of filePath: String) -> String {
        var directories = filePath.split(separator: "/")
        directories.removeLast()
        return directories.joined(separator: "/")
    }
    
    public static func createPath(_ path: String) {
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
    
    public static func createFile(_ path: String, contents: String, options: [String] = []) {
        createPath(basePath(of: path))
        
        let isForced = options.contains("--force") || options.contains("-f")
        
        creatables.append(File(path: path, contents: contents, isForced: isForced))
    }
    
    public static func finish() {
        for creatable in creatables.sorted(by: { $0.path < $1.path }) {
            creatable.create()
        }
    }
}
