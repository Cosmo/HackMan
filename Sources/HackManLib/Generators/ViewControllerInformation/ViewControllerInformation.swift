import Stencil
import FileProvider
import PathKit

@objc(ViewControllerInformation)
class ViewControllerInformation: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        let path = Path("\(Bundle.main.bundlePath)/Sources/HackManLib/Generators/\(String(describing: type(of: self)))")
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "ViewControllerInformation.stf")
        Writer.write(contents: rendered, toFile: "Source/ViewControllers/InformationViewController.swift")
        
        let rendered2 = try! environment.renderTemplate(name: "ChildCoordinator.stf")
        Writer.write(contents: rendered2, toFile: "Source/Coordinator/InformationCoordinator.swift")
        
        ViewControllerWeb().generate(arguments: arguments, options: options)
    }
}
