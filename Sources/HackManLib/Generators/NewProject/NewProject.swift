import Foundation
import Stencil

@objc(NewProject)
class NewProject: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        guard !arguments.isEmpty else {
            printUsage()
            exit(0)
        }
        
        var arguments = arguments
        let projectName = arguments.removeFirst()
        
        let context = [
            "projectName": projectName,
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
        
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader, extensions: [ext])
        let rendered = try! environment.renderTemplate(name: "project.yml", context: context)
        Writer.createFile("\(projectName)/project.yml", contents: rendered)
        
        let rendered2 = try! environment.renderTemplate(name: "gitignore", context: context)
        Writer.createFile("\(projectName)/.gitignore", contents: rendered2)
        
        print()
        print("Now go to your project directory (\"cd \(projectName)\") to run other commands (hackman generate).")
    }
    
    func printUsage() {
        print("Usage: hackman new APP_NAME")
        print()
        print("Example:")
        print("  hackman new AwesomeApp")
    }
}
