import Foundation
import Stencil
import GrammaticalNumber

@objc(ViewController)
class ViewController: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        guard !arguments.isEmpty else {
            type(of: self).help()
            exit(0)
        }
        
        let containsCoordinator = options.contains("-c") || options.contains("--coordinator")
        
        
        var mutableArguments = arguments
        let resource = Resource(
            name: mutableArguments.removeFirst(),
            properties: Property.createList(inputStrings: mutableArguments)
        )
        let context: [String: Any] = [
            "resource": resource,
            "coordinator": containsCoordinator
        ]
        
        let rendered = try! environment.renderTemplate(name: "ViewController.stf", context: context)
        
        Writer.createFile("\(Writer.extractSourcePath(options: options))/ViewControllers/\(resource.name)/\(resource.name)ViewController.swift", contents: rendered, options: options)
        
        if containsCoordinator {
            let rendered2 = try! environment.renderTemplate(name: "ChildCoordinator.stf", context: context)
            Writer.createFile("\(Writer.extractSourcePath(options: options))/Coordinator/\(resource.name)Coordinator.swift", contents: rendered2, options: options)
        }
    }
    
    static func help() {
        print("Usage: hackman generate \(singleLineUsage())")
        print()
        print("Example:")
        print("  hackman generate view_controller song")
    }
    
    static func singleLineUsage() -> String {
        return "view_controller NAME"
    }
}
