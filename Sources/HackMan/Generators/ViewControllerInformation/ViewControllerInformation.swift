import Stencil
import FileProvider
import PathKit

class ViewControllerInformation: Generator {
    func generate(options: [String]?) {
        let path = Path("\(Bundle.main.bundlePath)/Sources/HackMan/Generators/\(String(describing: type(of: self)))")
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "ViewControllerInformation.stf")
        
        try? FileManager().createDirectory(atPath: "Source/ViewControllers", withIntermediateDirectories: true, attributes: nil)
        try? FileManager().createDirectory(atPath: "Source/ViewControllers/Generic", withIntermediateDirectories: true, attributes: nil)
        try? rendered.write(toFile: "Source/ViewControllers/InformationViewController.swift", atomically: true, encoding: String.Encoding.utf8)
        
        let rendered2 = try! environment.renderTemplate(name: "ChildCoordinator.stf")
        try? FileManager().createDirectory(atPath: "Source/Coordinator", withIntermediateDirectories: true, attributes: nil)
        try? rendered2.write(toFile: "Source/Coordinator/InformationCoordinator.swift", atomically: true, encoding: String.Encoding.utf8)
        
        ViewControllerWeb().generate(options: nil)
        
        print(rendered)
    }
}
