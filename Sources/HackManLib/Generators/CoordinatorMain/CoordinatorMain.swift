import Foundation
import Stencil
import GrammaticalNumber

@objc(CoordinatorMain)
class CoordinatorMain: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        let resourceNames = arguments
        let resources = resourceNames
            .map { $0.upperCamelCased() }
            .map { ["name": $0, "pluralName": String($0).pluralized().upperCamelCased(), "className": String($0) + "ViewController" ] }
        
        var children = resources
            .map { "\($0["pluralName"] ?? "")Coordinator(navigationController: UINavigationController())" }
        
        if let result = (options.filter { $0.contains("include") }).first?.split(separator: "=").last {
            for additionalControllerName in result.split(separator: ",") {
                let additionalControllerName = String(additionalControllerName).upperCamelCased()
                children.append("\(additionalControllerName)Coordinator(navigationController: UINavigationController())")
            }
        }
        
        let context: [String: Any] = [
            "resourceNames": resourceNames,
            "resources": resources,
            "children": children
        ]
        
        let ext = Extension()
        ext.registerFilter("pluralized") { (value: Any?) in
            if let value = value as? String {
                return value.pluralized()
            }
            return value
        }
        ext.registerFilter("upperCamelCased") { (value: Any?) in
            if let value = value as? String {
                return value.upperCamelCased()
            }
            return value
        }
        ext.registerFilter("lowerCamelCased") { (value: Any?) in
            if let value = value as? String {
                return value.lowerCamelCased()
            }
            return value
        }
        
        let loader = FileSystemLoader(paths: [basePath])
        let environment = Environment(loader: loader, extensions: [ext])
        let rendered = try! environment.renderTemplate(name: "CoordinatorMain.stf", context: context)
        
        Writer.createFile("\(Writer.extractSourcePath(options: options))/Coordinator/MainCoordinator.swift", contents: rendered, options: options)
    }
    
    func help() {
        print("Usage: hackman generate coordinator_main")
        print()
        print("Example:")
        print("  hackman generate coordinator_main")
    }
}
