import Stencil
import FileProvider

class Coordinator: Generator {
    func generate(options: [String]?) {
        let loader = FileSystemLoader(paths: ["Sources/HackSwift/Generators/Coordinator"])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "Coordinator.stf")
        
        try? FileManager().createDirectory(atPath: "../App/Source/Protocols", withIntermediateDirectories: true, attributes: nil)
        try? rendered.write(toFile: "../App/Source/Protocols/Coordinator.swift", atomically: true, encoding: String.Encoding.utf8)
        
        print(rendered)
    }
}
