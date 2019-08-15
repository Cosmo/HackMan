import Stencil
import FileProvider
import Foundation
import PathKit

@objc(NewProject)
class NewProject: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
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
        Writer.write(contents: rendered, toFile: "\(projectName)/project.yml")
        
        let rendered2 = try! environment.renderTemplate(name: "gitignore", context: context)
        Writer.write(contents: rendered2, toFile: "\(projectName)/.gitignore")
    }
}
