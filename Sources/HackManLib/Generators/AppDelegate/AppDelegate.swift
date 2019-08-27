import Foundation
import Stencil

@objc(AppDelegate)
class AppDelegate: NSObject, Generator {
    required override init() {}

    func generate(arguments: [String], options: [String]) {
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader)
        
        let containsCoordinator = options.contains("-c") || options.contains("--coordinator")
        if containsCoordinator {
            Coordinator().generate(arguments: arguments, options: options)
            CoordinatorMain().generate(arguments: arguments, options: options)
        }
        
        let context: [String: Any] = [
            "coordinator": containsCoordinator
        ]
        
        let rendered = try! environment.renderTemplate(name: "AppDelegate.stf", context: context)
        
        Writer.createFile("\(Writer.extractSourcePath(options: options))/AppDelegate.swift", contents: rendered, options: options)
    }
}
