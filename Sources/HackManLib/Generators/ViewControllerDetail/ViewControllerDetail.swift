import Foundation
import Stencil
import GrammaticalNumber

@objc(ViewControllerDetail)
class ViewControllerDetail: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        guard !arguments.isEmpty else {
            printUsage()
            exit(0)
        }
        
        var arguments = arguments
        let resourceName = arguments.removeFirst().camelCasedIfNeeded(.upper)
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
        let rendered = try! environment.renderTemplate(name: "ViewControllerDetail.stf", context: context)
        Writer.createFile("\(Writer.extractSourcePath(options: options))/ViewControllers/\(resourceName.pluralized().camelCasedIfNeeded(.upper))/\(resourceName)ViewController.swift", contents: rendered, options: options)
    }
    
    func printUsage() {
        print("Usage: hackman generate view_controller_detail NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …")
        print()
        print("Example:")
        print("  hackman generate view_controller_detail song title:string artist_name:string album_name:string")
    }
    
    func help() {
        printUsage()
    }
}
