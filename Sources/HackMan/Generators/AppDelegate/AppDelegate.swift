import Stencil
import FileProvider
import PathKit

class AppDelegate: Generator {
    func generate(options: [String]?) {
        let path = Path("\(Bundle.main.bundlePath)/Sources/HackMan/Generators/\(String(describing: type(of: self)))")
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "AppDelegate.stf")
        
        try? FileManager().createDirectory(atPath: "Source", withIntermediateDirectories: true, attributes: nil)
        try? rendered.write(toFile: "Source/AppDelegate.swift", atomically: true, encoding: String.Encoding.utf8)
        
        print(rendered)
    }
}
