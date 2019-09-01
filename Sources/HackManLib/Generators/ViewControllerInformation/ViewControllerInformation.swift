import Foundation
import Stencil

@objc(ViewControllerInformation)
class ViewControllerInformation: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        let loader = FileSystemLoader(paths: [basePath])
        let environment = Environment(loader: loader)
        
        let containsCoordinator = options.contains("-c") || options.contains("--coordinator")
        
        let context: [String: Any] = [
            "coordinator": containsCoordinator
        ]
        
        let rendered = try! environment.renderTemplate(name: "ViewControllerInformation.stf", context: context)
        Writer.createFile("\(Writer.extractSourcePath(options: options))/ViewControllers/InformationViewController.swift", contents: rendered, options: options)
        
        if containsCoordinator {
            let rendered2 = try! environment.renderTemplate(name: "ChildCoordinator.stf")
            Writer.createFile("\(Writer.extractSourcePath(options: options))/Coordinator/InformationCoordinator.swift", contents: rendered2, options: options)
        }
        
        ViewControllerWeb().generate(arguments: arguments, options: options)
    }
    
    func help() {
        print("Usage: hackman generate view_controller_information")
        print()
        print("Example:")
        print("  hackman generate view_controller_information")
    }
}
