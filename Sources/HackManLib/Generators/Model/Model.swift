import Foundation
import Stencil

@objc(Model)
class Model: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        guard !arguments.isEmpty else {
            type(of: self).help()
            exit(0)
        }
        
        let strings = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven"]
        
        var arguments = arguments
        let resource = Resource(
            name: arguments.removeFirst(),
            properties: Property.createList(inputStrings: arguments)
        )
        
        let mocks = strings.map { (string) in
            return "\(resource.name)(\( (resource.properties ?? []).map { return "\($0.name): \($0.stringForMockContent(placeholder: string))" }.joined(separator: ", ") ))"
        }
        
        let context: [String: Any] = [
            "resource": resource,
            "mocks": mocks
        ]
        
        let rendered = try! environment.renderTemplate(name: "Model.stf", context: context)
        
        Writer.createFile("\(Writer.extractSourcePath(options: options))/Models/\(resource.name).swift", contents: rendered, options: options)
    }
    
    static func help() {
        print("Usage: hackman generate \(singleLineUsage())")
        print()
        print("Example:")
        print("  hackman generate model song title:string artist_name:string album_name:string")
    }
    
    static func singleLineUsage() -> String {
        return "model NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …."
    }
}
