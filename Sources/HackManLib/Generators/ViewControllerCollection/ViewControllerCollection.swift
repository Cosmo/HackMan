import Foundation
import Stencil

@objc(ViewControllerCollection)
class ViewControllerCollection: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        guard !arguments.isEmpty else {
            printUsage()
            exit(0)
        }
        
        var arguments = arguments
        let resourceName = arguments.removeFirst().camelCased(.upper)
        let properties = Property.createList(inputStrings: arguments)
        
        let context: [String: Any] = [
            "resourceName": resourceName,
            "properties": properties
        ]
        
        let ext = Extension()
        ext.registerFilter("pluralized") { (value: Any?) in
            if let value = value as? String {
                return value.pluralized
            }
            return value
        }
        ext.registerFilter("upperCamelCased") { (value: Any?) in
            if let value = value as? String {
                return value.camelCased(.upper)
            }
            return value
        }
        ext.registerFilter("lowerCamelCased") { (value: Any?) in
            if let value = value as? String {
                return value.camelCased(.lower)
            }
            return value
        }
        
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader, extensions: [ext])
        
        let rendered = try! environment.renderTemplate(name: "ViewControllerCollection.stf", context: context)
        Writer.write(contents: rendered, toFile: "Source/ViewControllers/\(resourceName.pluralized)/\(resourceName.pluralized)ViewController.swift")
        
        let rendered2 = try! environment.renderTemplate(name: "ResultsViewController.stf", context: context)
        Writer.write(contents: rendered2, toFile: "Source/ViewControllers/\(resourceName.pluralized)/\(resourceName)ResultsViewController.swift")
    }
    
    func printUsage() {
        print("Usage: hackman generate view_controller_collection NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …")
        print()
        print("Example:")
        print("  hackman generate view_controller_collection song title:string artist_name:string album_name:string")
    }
}
