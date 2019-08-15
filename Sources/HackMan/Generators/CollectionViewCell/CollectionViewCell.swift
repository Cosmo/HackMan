import Stencil
import FileProvider
import PathKit

class CollectionViewCell: Generator {
    func generate(resourceName: String, properties: [Property], options: [String]?) {
        let context: [String: Any] = [
            "resourceName": resourceName,
            "properties": properties
        ]
        
        let path = Path("\(Bundle.main.bundlePath)/Sources/HackMan/Generators/\(String(describing: type(of: self)))")
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "CollectionViewCell.stf", context: context)
        
        try? FileManager().createDirectory(atPath: "Source/Views/Cells", withIntermediateDirectories: true, attributes: nil)
        try? rendered.write(toFile: "Source/Views/Cells/\(resourceName)CollectionViewCell.swift", atomically: true, encoding: String.Encoding.utf8)
        
        print(rendered)
    }
}
