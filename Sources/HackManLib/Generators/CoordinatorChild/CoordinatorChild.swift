import Foundation
import Stencil
import GrammaticalNumber

@objc(CoordinatorChild)
class CoordinatorChild: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        guard !arguments.isEmpty else {
            type(of: self).help()
            exit(0)
        }
        
        var mutableArguments = arguments
        let resource = Resource(
            name: mutableArguments.removeFirst(),
            properties: Property.createList(inputStrings: mutableArguments)
        )
        let context: [String: Any] = [
            "resource": resource
        ]
        
        let rendered = try! environment.renderTemplate(name: "CoordinatorChild.stf", context: context)
        
        Writer.createFile("\(Writer.extractSourcePath(options: options))/Coordinator/\(resource.pluralizedName)Coordinator.swift", contents: rendered, options: options)
    }
    
    static func help() {
        print("Usage: hackman generate \(singleLineUsage())")
        print()
        print("Example:")
        print("  hackman generate coordinator_child song")
    }
    
    static func singleLineUsage() -> String {
        return "coordinator_child NAME"
    }
}
