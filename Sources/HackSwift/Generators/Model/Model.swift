import Stencil
import FileProvider

class Model: Generator {
    func generate(resourceName: String, properties: [Property], options: [String]?) {
        let strings = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven"]
        let mocks = strings.map { (string) in return "\(resourceName)(\( properties.map { return "\($0.name): \($0.mock(string: string))" }.joined(separator: ", ") ))" }
        
        let context: [String: Any] = [
            "resourceName": resourceName,
            "properties": properties,
            "mocks": mocks
        ]
        
        let loader = FileSystemLoader(paths: ["Sources/HackSwift/Generators/Model"])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "Model.stf", context: context)
        
        try? FileManager().createDirectory(atPath: "../App/Source/Models", withIntermediateDirectories: true, attributes: nil)
        try? rendered.write(toFile: "../App/Source/Models/\(resourceName).swift", atomically: true, encoding: String.Encoding.utf8)
        
        print(rendered)
    }
}
