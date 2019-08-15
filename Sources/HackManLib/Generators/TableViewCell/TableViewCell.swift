import Stencil
import FileProvider
import PathKit

@objc(TableViewCell)
class TableViewCell: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
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
}
