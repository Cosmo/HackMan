import Foundation
import Stencil
import GrammaticalNumber
import StringCase

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
    
    func printUsage() {
        print("Usage: hackman new APP_NAME")
        print()
        print("Example:")
        print("  hackman new AwesomeApp")
    }
    
    func help() {
        printUsage()
    }
}
