import Foundation
import Stencil

@objc(AppDelegate)
class AppDelegate: NSObject, Generator {
    required override init() {}

    func generate(arguments: [String], options: [String]) {
        let containsCoordinator = options.contains("-c") || options.contains("--coordinator")
        if containsCoordinator {
            Coordinator().generate(arguments: arguments, options: options)
            CoordinatorMain().generate(arguments: arguments, options: options)
        }
        
        let context: [String: Any] = [
            "coordinator": containsCoordinator
        ]
        
        let rendered = try! environment.renderTemplate(name: "AppDelegate.stf", context: context)
        
        Writer.createFile("\(Writer.extractSourcePath(options: options))/AppDelegate.swift", contents: rendered, options: options)
    }
    
    static func help() {
        print("Usage: hackman generate \(singleLineUsage())")
        print()
        print("Example:")
        print("  hackman generate app_delegate")
    }
    
    static func singleLineUsage() -> String {
        return "app_delegate"
    }
}
