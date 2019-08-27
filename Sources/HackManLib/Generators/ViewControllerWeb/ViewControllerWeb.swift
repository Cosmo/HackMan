import Foundation
import Stencil

@objc(ViewControllerWeb)
class ViewControllerWeb: NSObject, Generator {
    required override init() {}

    func generate(arguments: [String], options: [String]) {
        showHelpIfNeeded(options: options)
        
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader)
        let containsCoordinator = options.contains("-c") || options.contains("--coordinator")
        let context: [String: Any] = [
            "coordinator": containsCoordinator
        ]
        
        let rendered = try! environment.renderTemplate(name: "ViewControllerWeb.stf", context: context)
        
        Writer.createFile("\(Writer.extractSourcePath(options: options))/ViewControllers/Generic/WebViewController.swift", contents: rendered, options: options)
    }
    
    func help() {
        print("Usage: hackman generate view_controller_web")
        print()
        print("Example:")
        print("  hackman generate view_controller_web")
    }
}
