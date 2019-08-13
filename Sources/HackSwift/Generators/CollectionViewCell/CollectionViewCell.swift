import Stencil
import FileProvider

class CollectionViewCell: Generator {
    func generate(resourceName: String, properties: [Property], options: [String]?) {
        let context: [String: Any] = [
            "resourceName": resourceName,
            "properties": properties
        ]
        
        let loader = FileSystemLoader(paths: ["Sources/HackSwift/Generators/CollectionViewCell"])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "CollectionViewCell.stf", context: context)
        
        try? FileManager().createDirectory(atPath: "../App/Source/Views/Cells", withIntermediateDirectories: true, attributes: nil)
        try? rendered.write(toFile: "../App/Source/Views/Cells/\(resourceName)CollectionViewCell.swift", atomically: true, encoding: String.Encoding.utf8)
        
        print(rendered)
    }
}
