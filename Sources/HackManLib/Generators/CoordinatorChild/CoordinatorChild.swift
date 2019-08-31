import Foundation
import Stencil
import GrammaticalNumber

@objc(CoordinatorChild)
class CoordinatorChild: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        showHelpIfNeeded(options: options)
        
        guard !arguments.isEmpty else {
            printUsage()
            exit(0)
        }
        
        var arguments = arguments
        let resourceName = arguments.removeFirst().camelCasedIfNeeded(.upper)
        
        let context: [String: Any] = [
            "resourceName": resourceName
        ]
        
        let ext = Extension()
        ext.registerFilter("pluralized") { (value: Any?) in
            if let value = value as? String {
                return value.pluralized()
            }
            return value
        }
        ext.registerFilter("upperCamelCased") { (value: Any?) in
            if let value = value as? String {
                return value.camelCasedIfNeeded(.upper)
            }
            return value
        }
        ext.registerFilter("lowerCamelCased") { (value: Any?) in
            if let value = value as? String {
                return value.camelCasedIfNeeded(.lower)
            }
            return value
        }
        
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader, extensions: [ext])
        let rendered = try! environment.renderTemplate(name: "CoordinatorChild.stf", context: context)
        
        Writer.createFile("\(Writer.extractSourcePath(options: options))/Coordinator/\(resourceName.pluralized())Coordinator.swift", contents: rendered, options: options)
    }
    
    func printUsage() {
        print("Usage: hackman generate coordinator_child NAME")
        print()
        print("Example:")
        print("  hackman generate coordinator_child song")
    }
    
    func help() {
        printUsage()
    }
}
