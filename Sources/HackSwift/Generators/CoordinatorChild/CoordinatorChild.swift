import Stencil
import FileProvider

class CoordinatorChild: Generator {
    func generate(resourceName: String, options: [String]?) {
        let context: [String: Any] = [
            "resourceName": resourceName
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
        
        let loader = FileSystemLoader(paths: ["Sources/HackSwift/Generators/CoordinatorChild"])
        let environment = Environment(loader: loader, extensions: [ext])
        let rendered = try! environment.renderTemplate(name: "CoordinatorChild.stf", context: context)
        
        try? FileManager().createDirectory(atPath: "../App/Source/Coordinator", withIntermediateDirectories: true, attributes: nil)
        try? rendered.write(toFile: "../App/Source/Coordinator/\(resourceName.pluralized)Coordinator.swift", atomically: true, encoding: String.Encoding.utf8)
        
        print(rendered)
    }
}
