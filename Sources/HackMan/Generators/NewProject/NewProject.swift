import Stencil
import FileProvider
import Foundation
import PathKit

class NewProject: Generator {
    func generate(projectName: String, options: [String]?) {
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
        
        let path = Path("\(Bundle.main.bundlePath)/Sources/HackMan/Generators/\(String(describing: type(of: self)))")
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader, extensions: [ext])
        let rendered = try! environment.renderTemplate(name: "project.yml", context: context)
        
        try? FileManager().createDirectory(atPath: "\(projectName)", withIntermediateDirectories: true, attributes: nil)
        try? rendered.write(toFile: "\(projectName)/project.yml", atomically: true, encoding: String.Encoding.utf8)
        
        let rendered2 = try! environment.renderTemplate(name: "gitignore", context: context)
        try? rendered2.write(toFile: "\(projectName)/.gitignore", atomically: true, encoding: String.Encoding.utf8)
        
        print(rendered)
    }
}
