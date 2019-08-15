import Stencil
import FileProvider
import PathKit

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
        
        let path = Path("\(Bundle.main.bundlePath)/Sources/HackMan/Generators/\(String(describing: type(of: self)))")
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader, extensions: [ext])
        let rendered = try! environment.renderTemplate(name: "CoordinatorChild.stf", context: context)
        
        try? FileManager().createDirectory(atPath: "Source/Coordinator", withIntermediateDirectories: true, attributes: nil)
        try? rendered.write(toFile: "Source/Coordinator/\(resourceName.pluralized)Coordinator.swift", atomically: true, encoding: String.Encoding.utf8)
        
        print(rendered)
    }
}
