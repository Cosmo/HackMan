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
        let resourceName = arguments.removeFirst().camelCased(.upper)
        let properties = Property.createList(inputStrings: arguments)
        
        let context: [String: Any] = [
            "resourceName": resourceName,
            "properties": properties
        ]
        
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "TableViewCell.stf", context: context)
        
        Writer.write(contents: rendered, toFile: "Source/Views/Cells/\(resourceName)TableViewCell.swift")
    }
    
    func printUsage() {
        print("Usage: hackman generate table_view_cell NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …")
        print()
        print("Example:")
        print("  hackman generate table_view_cell song title:string artist_name:string album_name:string")
    }
}
