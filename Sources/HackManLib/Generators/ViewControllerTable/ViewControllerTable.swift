import Foundation
import Stencil

@objc(ViewControllerTable)
class ViewControllerTable: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        guard !arguments.isEmpty else {
            type(of: self).help()
            exit(0)
        }
        
        let containsCoordinator = options.contains("-c") || options.contains("--coordinator")
        var mutableArguments = arguments
        let resource = Resource(
            name: mutableArguments.removeFirst(),
            properties: Property.createList(inputStrings: mutableArguments)
        )
        let context: [String: Any] = [
            "resource": resource,
            "coordinator": containsCoordinator
        ]
        
        let rendered = try! environment.renderTemplate(name: "ViewControllerTable.stf", context: context)
        Writer.createFile("\(Writer.extractSourcePath(options: options))/ViewControllers/\(resource.pluralizedName)/\(resource.pluralizedName)ViewController.swift", contents: rendered, options: options)
        
        SearchResultsController().generate(arguments: arguments, options: options)
        DataSourceTableView().generate(arguments: arguments, options: options)
        DataSourceTableViewSearchResults().generate(arguments: arguments, options: options)
    }
    
    static func help() {
        print("Usage: hackman generate \(singleLineUsage())")
        print()
        print("Example:")
        print("  hackman generate view_controller_table song title:string artist_name:string album_name:string")
    }
    
    static func singleLineUsage() -> String {
        return "view_controller_table NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …"
    }
}
