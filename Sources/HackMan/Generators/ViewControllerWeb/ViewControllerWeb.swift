import Stencil
import FileProvider
import PathKit

class ViewControllerWeb: Generator {
    func generate(options: [String]?) {
        let path = Path("\(Bundle.main.bundlePath)/Sources/HackMan/Generators/\(String(describing: type(of: self)))")
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "ViewControllerWeb.stf")
        
        try? FileManager().createDirectory(atPath: "Source/ViewControllers", withIntermediateDirectories: true, attributes: nil)
        try? FileManager().createDirectory(atPath: "Source/ViewControllers/Generic", withIntermediateDirectories: true, attributes: nil)
        try? rendered.write(toFile: "Source/ViewControllers/WebViewController.swift", atomically: true, encoding: String.Encoding.utf8)
        
        print(rendered)
    }
}
