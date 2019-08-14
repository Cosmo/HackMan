import Stencil
import FileProvider

class CoordinatorMain: Generator {
    func generate(resourceNames: [String], options: [String]?) {
        let resources = resourceNames
            .map { $0.camelCased(.upper) }
            .map { ["name": $0, "pluralName": String($0).pluralized, "className": String($0) + "ViewController" ] }
        
        let children = resources
            .map { "\($0["pluralName"] ?? "")Coordinator(navigationController: UINavigationController())" }
        
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
        
        let loader = FileSystemLoader(paths: ["Sources/HackSwift/Generators/CoordinatorMain"])
        let environment = Environment(loader: loader, extensions: [ext])
        let rendered = try! environment.renderTemplate(name: "CoordinatorMain.stf", context: context)
        
        try? FileManager().createDirectory(atPath: "../App/Source/Coordinator", withIntermediateDirectories: true, attributes: nil)
        try? rendered.write(toFile: "../App/Source/Coordinator/MainCoordinator.swift", atomically: true, encoding: String.Encoding.utf8)
        
        print(rendered)
    }
}
