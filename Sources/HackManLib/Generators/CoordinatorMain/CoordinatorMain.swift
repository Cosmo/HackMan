import Stencil
import FileProvider
import PathKit

@objc(CoordinatorMain)
class CoordinatorMain: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        let resourceNames = arguments
        let resources = resourceNames
            .map { $0.camelCased(.upper) }
            .map { ["name": $0, "pluralName": String($0).pluralized, "className": String($0) + "ViewController" ] }
        
        var children = resources
            .map { "\($0["pluralName"] ?? "")Coordinator(navigationController: UINavigationController())" }
        
        if let result = (options.filter { $0.contains("include") }).first?.split(separator: "=").last {
            for additionalControllerName in result.split(separator: ",") {
                let additionalControllerName = String(additionalControllerName).camelCased(.upper)
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
                return value.pluralized
            }
            return value
        }
        ext.registerFilter("upperCamelCased") { (value: Any?) in
            if let value = value as? String {
                return value.camelCased(.upper)
            }
            return value
        }
        ext.registerFilter("lowerCamelCased") { (value: Any?) in
            if let value = value as? String {
                return value.camelCased(.lower)
            }
            return value
        }
        
        let path = Path("\(Bundle.main.bundlePath)/Sources/HackManLib/Generators/\(String(describing: type(of: self)))")
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader, extensions: [ext])
        let rendered = try! environment.renderTemplate(name: "CoordinatorMain.stf", context: context)
        
        try? FileManager().createDirectory(atPath: "Source/Coordinator", withIntermediateDirectories: true, attributes: nil)
        try? rendered.write(toFile: "Source/Coordinator/MainCoordinator.swift", atomically: true, encoding: String.Encoding.utf8)
    }
}
