import Foundation
import Stencil

@objc(TableViewCell)
class TableViewCell: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        guard !arguments.isEmpty else {
            printUsage()
            exit(0)
        }
        
        var arguments = arguments
        let resource = Resource(
            name: arguments.removeFirst(),
            properties: Property.createList(inputStrings: arguments)
        )
        let context: [String: Any] = [
            "resource": resource
        ]
        
        let loader = FileSystemLoader(paths: [basePath])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "TableViewCell.stf", context: context)
        
        Writer.createFile("\(Writer.extractSourcePath(options: options))/Views/Cells/\(resource.name)TableViewCell.swift", contents: rendered, options: options)
    }
    
    func printUsage() {
        print("Usage: hackman generate table_view_cell NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …")
        print()
        print("Example:")
        print("  hackman generate table_view_cell song title:string artist_name:string album_name:string")
    }
    
    func help() {
        printUsage()
    }
}
