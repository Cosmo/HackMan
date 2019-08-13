import Stencil
import FileProvider

class ViewControllerWeb: Generator {
    func generate(options: [String]?) {
        let loader = FileSystemLoader(paths: ["Sources/HackSwift/Generators/ViewControllerWeb"])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "ViewControllerWeb.stf")
        
        try? FileManager().createDirectory(atPath: "../App/Source/ViewControllers", withIntermediateDirectories: true, attributes: nil)
        try? FileManager().createDirectory(atPath: "../App/Source/ViewControllers/Generic", withIntermediateDirectories: true, attributes: nil)
        try? rendered.write(toFile: "../App/Source/ViewControllers/WebViewController.swift", atomically: true, encoding: String.Encoding.utf8)
        
        print(rendered)
    }
}
