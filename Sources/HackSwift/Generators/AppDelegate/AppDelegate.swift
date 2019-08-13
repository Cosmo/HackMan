import Stencil
import FileProvider

class AppDelegate: Generator {
    func generate(options: [String]?) {
        let loader = FileSystemLoader(paths: ["Sources/HackSwift/Generators/AppDelegate"])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "AppDelegate.stf")
        
        try? FileManager().createDirectory(atPath: "../App/Source", withIntermediateDirectories: true, attributes: nil)
        try? rendered.write(toFile: "../App/Source/AppDelegate.swift", atomically: true, encoding: String.Encoding.utf8)
        
        print(rendered)
    }
}
