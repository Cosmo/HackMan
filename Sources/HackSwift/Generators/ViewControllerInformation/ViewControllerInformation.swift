import Stencil
import FileProvider

class ViewControllerInformation: Generator {
    func generate(options: [String]?) {
        let loader = FileSystemLoader(paths: ["Sources/HackSwift/Generators/ViewControllerInformation"])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "ViewControllerInformation.stf")
        
        try? FileManager().createDirectory(atPath: "../App/Source/ViewControllers", withIntermediateDirectories: true, attributes: nil)
        try? FileManager().createDirectory(atPath: "../App/Source/ViewControllers/Generic", withIntermediateDirectories: true, attributes: nil)
        try? rendered.write(toFile: "../App/Source/ViewControllers/InformationViewController.swift", atomically: true, encoding: String.Encoding.utf8)
        
        let rendered2 = try! environment.renderTemplate(name: "ChildCoordinator.stf")
        try? FileManager().createDirectory(atPath: "../App/Source/Coordinator", withIntermediateDirectories: true, attributes: nil)
        try? rendered2.write(toFile: "../App/Source/Coordinator/InformationCoordinator.swift", atomically: true, encoding: String.Encoding.utf8)
        
        ViewControllerWeb().generate(options: nil)
        
        print(rendered)
    }
}
