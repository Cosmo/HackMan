import Foundation
import Stencil

@objc(TableViewCell)
class TableViewCell: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        guard !arguments.isEmpty else {
            type(of: self).help()
            exit(0)
        }
        
        var mutableArguments = arguments
        let resource = Resource(
            name: mutableArguments.removeFirst(),
            properties: Property.createList(inputStrings: mutableArguments)
        )
        let context: [String: Any] = [
            "resource": resource
        ]
        
        let rendered = try! environment.renderTemplate(name: "TableViewCell.stf", context: context)
        
        Writer.createFile("\(Writer.extractSourcePath(options: options))/Views/Cells/\(resource.name)TableViewCell.swift", contents: rendered, options: options)
    }
    
    static func help() {
        print("Usage: hackman generate \(singleLineUsage())")
        print()
        print("Example:")
        print("  hackman generate table_view_cell song title:string artist_name:string album_name:string")
    }
    
    static func singleLineUsage() -> String {
        return "table_view_cell NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …"
    }
}
