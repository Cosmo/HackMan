import Foundation
import Stencil
import GrammaticalNumber
import StringCase

@objc(CoordinatorMain)
class CoordinatorMain: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        let resources = arguments.map { Resource(name: $0, properties: nil) }
        var children = resources.map { "\($0.pluralizedName)Coordinator(navigationController: UINavigationController())" }
        
        if let result = (options.filter { $0.contains("include") }).first?.split(separator: "=").last {
            for additionalControllerName in result.split(separator: ",") {
                let additionalControllerName = String(additionalControllerName).upperCamelCased()
                children.append("\(additionalControllerName)Coordinator(navigationController: UINavigationController())")
            }
        }
        
        let context: [String: Any] = [
            "resources": resources,
            "children": children
        ]
        
        let rendered = try! environment.renderTemplate(name: "CoordinatorMain.stf", context: context)
        
        Writer.createFile("\(Writer.extractSourcePath(options: options))/Coordinators/MainCoordinator.swift", contents: rendered, options: options)
    }
    
    static func help() {
        print("Usage: hackman generate \(singleLineUsage())")
        print()
        print("Example:")
        print("  hackman generate coordinator_main")
    }
    
    static func singleLineUsage() -> String {
        return "coordinator_main"
    }
}
