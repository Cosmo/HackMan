import Foundation
import Stencil

@objc(ViewControllerTable)
class ViewControllerTable: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        guard !arguments.isEmpty else {
            printUsage()
            exit(0)
        }
        
        let containsCoordinator = options.contains("-c") || options.contains("--coordinator")
        var arguments = arguments
        let resource = Resource(
            name: arguments.removeFirst(),
            properties: Property.createList(inputStrings: arguments)
        )
        let context: [String: Any] = [
            "resource": resource,
            "coordinator": containsCoordinator
        ]
        
        
        let rendered = try! environment.renderTemplate(name: "ViewControllerTable.stf", context: context)
        Writer.createFile("\(Writer.extractSourcePath(options: options))/ViewControllers/\(resource.pluralizedName)/\(resource.pluralizedName)ViewController.swift", contents: rendered, options: options)
        
        let rendered2 = try! environment.renderTemplate(name: "ResultsViewController.stf", context: context)
        Writer.createFile("\(Writer.extractSourcePath(options: options))/ViewControllers/\(resource.pluralizedName)/\(resource.name)ResultsViewController.swift", contents: rendered2, options: options)
    }
    
    func printUsage() {
        print("Usage: hackman generate view_controller_table NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …")
        print()
        print("Example:")
        print("  hackman generate view_controller_table song title:string artist_name:string album_name:string")
    }
    
    func help() {
        printUsage()
    }
}
