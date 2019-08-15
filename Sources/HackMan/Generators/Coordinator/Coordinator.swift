import Stencil
import FileProvider
import PathKit

class Coordinator: Generator {
    func generate(options: [String]?) {
        let path = Path("\(Bundle.main.bundlePath)/Sources/HackMan/Generators/\(String(describing: type(of: self)))")
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "Coordinator.stf")
        
        try? FileManager().createDirectory(atPath: "Source/Protocols", withIntermediateDirectories: true, attributes: nil)
        try? rendered.write(toFile: "Source/Protocols/Coordinator.swift", atomically: true, encoding: String.Encoding.utf8)
        
        print(rendered)
    }
}
