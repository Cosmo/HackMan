import Foundation
import Stencil
import GrammaticalNumber

@objc(CoordinatorChild)
class CoordinatorChild: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        guard !arguments.isEmpty else {
            printUsage()
            exit(0)
        }
        
        var arguments = arguments
        let resource = Resource(
            name: arguments.removeFirst(),
            properties: Property.createList(inputStrings: arguments)
        )
        let context: [String: Any] = [
            "resource": resource
        ]
        
        let rendered = try! environment.renderTemplate(name: "CoordinatorChild.stf", context: context)
        
        Writer.createFile("\(Writer.extractSourcePath(options: options))/Coordinator/\(resource.pluralizedName)Coordinator.swift", contents: rendered, options: options)
    }
    
    func printUsage() {
        print("Usage: hackman generate coordinator_child NAME")
        print()
        print("Example:")
        print("  hackman generate coordinator_child song")
    }
    
    func help() {
        printUsage()
    }
}
