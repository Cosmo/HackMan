import Foundation
import Stencil
import GrammaticalNumber
import StringCase

@objc(NewProject)
class NewProject: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        guard !arguments.isEmpty else {
            type(of: self).help()
            exit(0)
        }
        
        var mutableArguments = arguments
        let projectName = mutableArguments.removeFirst()
        
        let context = [
            "projectName": projectName,
            "source": Writer.extractSourcePath(options: options),
            "bundleIdPrefix": "com.\(projectName.upperCamelCased())"
        ]
        
        let rendered = try! environment.renderTemplate(name: "project.yml", context: context)
        Writer.createFile("\(projectName)/project.yml", contents: rendered, options: options)
        
        let rendered2 = try! environment.renderTemplate(name: "gitignore", context: context)
        Writer.createFile("\(projectName)/.gitignore", contents: rendered2, options: options)
        
        print()
        print("Now go to your project directory (\"cd \(projectName)\") to run other commands (hackman generate).")
    }
    
    static func help() {
        print("Usage: hackman generate \(singleLineUsage())")
        print()
        print("Example:")
        print("  hackman new AwesomeApp")
    }
    
    static func singleLineUsage() -> String {
        return "new APP_NAME"
    }
}
