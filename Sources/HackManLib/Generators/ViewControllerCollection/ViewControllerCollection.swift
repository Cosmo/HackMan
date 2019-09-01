import Foundation
import Stencil
import GrammaticalNumber

@objc(ViewControllerCollection)
class ViewControllerCollection: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        guard !arguments.isEmpty else {
            printUsage()
            exit(0)
        }
        
        var arguments = arguments
        let resourceName = arguments.removeFirst().upperCamelCased()
        let properties = Property.createList(inputStrings: arguments)
        
        let containsCoordinator = options.contains("-c") || options.contains("--coordinator")
        
        let context: [String: Any] = [
            "resourceName": resourceName,
            "properties": properties,
            "coordinator": containsCoordinator
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
                return value.upperCamelCased()
            }
            return value
        }
        ext.registerFilter("lowerCamelCased") { (value: Any?) in
            if let value = value as? String {
                return value.lowerCamelCased()
            }
            return value
        }
        
        let loader = FileSystemLoader(paths: [basePath])
        let environment = Environment(loader: loader, extensions: [ext])
        
        let rendered = try! environment.renderTemplate(name: "ViewControllerCollection.stf", context: context)
        Writer.createFile("\(Writer.extractSourcePath(options: options))/ViewControllers/\(resourceName.pluralized().upperCamelCased())/\(resourceName.pluralized().upperCamelCased())ViewController.swift", contents: rendered, options: options)
        
        let rendered2 = try! environment.renderTemplate(name: "ResultsViewController.stf", context: context)
        Writer.createFile("\(Writer.extractSourcePath(options: options))/ViewControllers/\(resourceName.pluralized().upperCamelCased())/\(resourceName)ResultsViewController.swift", contents: rendered2, options: options)
    }
    
    func printUsage() {
        print("Usage: hackman generate view_controller_collection NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …")
        print()
        print("Example:")
        print("  hackman generate view_controller_collection song title:string artist_name:string album_name:string")
    }
    
    func help() {
        printUsage()
    }
}
