import Foundation
import Stencil

@objc(Model)
class Model: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        guard !arguments.isEmpty else {
            printUsage()
            exit(0)
        }
        
        var arguments = arguments
        let resourceName = arguments.removeFirst().camelCased(.upper)
        let properties = Property.createList(inputStrings: arguments)
        
        let strings = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven"]
        let mocks = strings.map { (string) in return "\(resourceName)(\( properties.map { return "\($0.name): \($0.mock(string: string))" }.joined(separator: ", ") ))" }
        
        let context: [String: Any] = [
            "resourceName": resourceName,
            "properties": properties,
            "mocks": mocks
        ]
        
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "Model.stf", context: context)
        
        Writer.write(contents: rendered, toFile: "Source/Models/\(resourceName).swift")
    }
    
    func printUsage() {
        print("Usage: hackman generate model NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …")
        print()
        print("Example:")
        print("  hackman generate model song title:string artist_name:string album_name:string")
    }
}
