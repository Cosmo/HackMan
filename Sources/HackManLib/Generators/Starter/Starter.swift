import Foundation
import Stencil

@objc(Starter)
class Starter: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        AppDelegate().generate(arguments: arguments, options: options)
        LaunchScreen().generate(arguments: arguments, options: options)
        AssetCatalog().generate(arguments: arguments, options: options)
    }
    
    static func help() {
        print("Usage: hackman generate \(singleLineUsage())")
        print()
        print("Example:")
        print("  hackman generate starter")
    }
    
    static func singleLineUsage() -> String {
        return "starter"
    }
}
