import Stencil
import FileProvider
import PathKit

class ViewControllerCollection: Generator {
    func generate(resourceName: String, properties: [Property], options: [String]?) {
        let context: [String: Any] = [
            "resourceName": resourceName,
            "properties": properties
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
        let rendered = try! environment.renderTemplate(name: "ViewControllerCollection.stf", context: context)
        
        try? FileManager().createDirectory(atPath: "Source/ViewControllers", withIntermediateDirectories: true, attributes: nil)
        try? FileManager().createDirectory(atPath: "Source/ViewControllers/\(resourceName.pluralized)", withIntermediateDirectories: true, attributes: nil)
        try? rendered.write(toFile: "Source/ViewControllers/\(resourceName.pluralized)/\(resourceName.pluralized)ViewController.swift", atomically: true, encoding: String.Encoding.utf8)
        
        let rendered2 = try! environment.renderTemplate(name: "ResultsViewController.stf", context: context)
        try? rendered2.write(toFile: "Source/ViewControllers/\(resourceName.pluralized)/\(resourceName)ResultsViewController.swift", atomically: true, encoding: String.Encoding.utf8)
        
        print(rendered)
    }
}
