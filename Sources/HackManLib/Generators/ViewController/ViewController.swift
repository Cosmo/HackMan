import Foundation
import Stencil
import GrammaticalNumber

@objc(ViewController)
class ViewController: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        guard !arguments.isEmpty else {
            printUsage()
            exit(0)
        }
        
        let containsCoordinator = options.contains("-c") || options.contains("--coordinator")
        
        
        var arguments = arguments
        let resource = Resource(
            name: arguments.removeFirst(),
            properties: Property.createList(inputStrings: arguments)
        )
        let context: [String: Any] = [
            "resource": resource,
            "coordinator": containsCoordinator
        ]
        
        let loader = FileSystemLoader(paths: [basePath])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "ViewController.stf", context: context)
        
        Writer.createFile("\(Writer.extractSourcePath(options: options))/ViewControllers/\(resource.name)/\(resource.name)ViewController.swift", contents: rendered, options: options)
        
        if containsCoordinator {
            let rendered2 = try! environment.renderTemplate(name: "ChildCoordinator.stf", context: context)
            Writer.createFile("\(Writer.extractSourcePath(options: options))/Coordinator/\(resource.name)Coordinator.swift", contents: rendered2, options: options)
        }
    }
    
    func printUsage() {
        print("Usage: hackman generate view_controller NAME")
        print()
        print("Example:")
        print("  hackman generate view_controller song")
    }
    
    func help() {
        printUsage()
    }
}
