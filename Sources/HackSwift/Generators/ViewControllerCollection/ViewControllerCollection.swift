import Stencil
import FileProvider

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
        
        let loader = FileSystemLoader(paths: ["Sources/HackSwift/Generators/ViewControllerCollection"])
        let environment = Environment(loader: loader, extensions: [ext])
        let rendered = try! environment.renderTemplate(name: "ViewControllerCollection.stf", context: context)
        
        try? FileManager().createDirectory(atPath: "../App/Source/ViewControllers", withIntermediateDirectories: true, attributes: nil)
        try? FileManager().createDirectory(atPath: "../App/Source/ViewControllers/\(resourceName.pluralized)", withIntermediateDirectories: true, attributes: nil)
        try? rendered.write(toFile: "../App/Source/ViewControllers/\(resourceName.pluralized)/\(resourceName.pluralized)ViewController.swift", atomically: true, encoding: String.Encoding.utf8)
        
        let rendered2 = try! environment.renderTemplate(name: "ResultsViewController.stf", context: context)
        try? rendered2.write(toFile: "../App/Source/ViewControllers/\(resourceName.pluralized)/\(resourceName)ResultsViewController.swift", atomically: true, encoding: String.Encoding.utf8)
        
        print(rendered)
    }
}
