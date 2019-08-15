import Stencil
import FileProvider
import PathKit

@objc(ViewController)
class ViewController: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        var arguments = arguments
        let resourceName = arguments.removeFirst().camelCased(.upper)
        
        let context = [
            "resourceName": resourceName,
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
        let rendered = try! environment.renderTemplate(name: "ViewController.stf", context: context)
        
        try? FileManager().createDirectory(atPath: "Source/ViewControllers", withIntermediateDirectories: true, attributes: nil)
        try? FileManager().createDirectory(atPath: "Source/ViewControllers/\(resourceName.pluralized)", withIntermediateDirectories: true, attributes: nil)
        try? rendered.write(toFile: "Source/ViewControllers/\(resourceName.pluralized)/\(resourceName.pluralized)ViewController.swift", atomically: true, encoding: String.Encoding.utf8)
    }
}
