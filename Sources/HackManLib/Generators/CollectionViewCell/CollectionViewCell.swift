import Foundation
import Stencil

@objc(CollectionViewCell)
class CollectionViewCell: NSObject, Generator {
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
        
        let rendered = try! environment.renderTemplate(name: "CollectionViewCell.stf", context: context)
        
        Writer.createFile("\(Writer.extractSourcePath(options: options))/Views/Cells/\(resource.name)CollectionViewCell.swift", contents: rendered, options: options)
    }
    
    func printUsage() {
        print("Usage: hackman generate collection_view_cell NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …")
        print()
        print("Example:")
        print("  hackman generate collection_view_cell song title:string artist_name:string album_name:string")
    }
    
    func help() {
        printUsage()
    }
}
