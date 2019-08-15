import Stencil
import FileProvider
import PathKit

@objc(Coordinator)
class Coordinator: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "Coordinator.stf")
        
        Writer.write(contents: rendered, toFile: "Source/Protocols/Coordinator.swift")
    }
}
