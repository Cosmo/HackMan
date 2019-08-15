import Stencil
import FileProvider
import PathKit

@objc(ViewControllerCollection)
class ViewControllerCollection: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        var arguments = arguments
        let resourceName = arguments.removeFirst().camelCased(.upper)
        let properties = Property.createList(inputStrings: arguments)
        
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
        
        let path = Path("\(Bundle.main.bundlePath)/Sources/HackManLib/Generators/\(String(describing: type(of: self)))")
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader, extensions: [ext])
        
        let rendered = try! environment.renderTemplate(name: "ViewControllerCollection.stf", context: context)
        Writer.write(contents: rendered, toFile: "Source/ViewControllers/\(resourceName.pluralized)/\(resourceName.pluralized)ViewController.swift")
        
        let rendered2 = try! environment.renderTemplate(name: "ResultsViewController.stf", context: context)
        Writer.write(contents: rendered2, toFile: "Source/ViewControllers/\(resourceName.pluralized)/\(resourceName)ResultsViewController.swift")
    }
}
