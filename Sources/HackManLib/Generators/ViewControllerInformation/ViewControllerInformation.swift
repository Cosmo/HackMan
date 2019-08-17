import Foundation
import Stencil

@objc(ViewControllerInformation)
class ViewControllerInformation: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "ViewControllerInformation.stf")
        Writer.createFile("Source/ViewControllers/InformationViewController.swift", contents: rendered)
        
        let rendered2 = try! environment.renderTemplate(name: "ChildCoordinator.stf")
        Writer.createFile("Source/Coordinator/InformationCoordinator.swift", contents: rendered2)
        
        ViewControllerWeb().generate(arguments: arguments, options: options)
    }
}
