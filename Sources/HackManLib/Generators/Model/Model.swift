import Stencil
import FileProvider
import PathKit

@objc(Model)
class Model: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
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
        
        let path = Path("\(Bundle.main.bundlePath)/Sources/HackManLib/Generators/\(String(describing: type(of: self)))")
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "Model.stf", context: context)
        
        try? FileManager().createDirectory(atPath: "Source/Models", withIntermediateDirectories: true, attributes: nil)
        try? rendered.write(toFile: "Source/Models/\(resourceName).swift", atomically: true, encoding: String.Encoding.utf8)
    }
}
