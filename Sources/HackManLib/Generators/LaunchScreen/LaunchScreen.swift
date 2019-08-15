import Foundation
import PathKit

@objc(LaunchScreen)
class LaunchScreen: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        let sourcePath = Path("\(Bundle.main.bundlePath)/Sources/HackManLib/Generators/\(String(describing: type(of: self)))/LaunchScreen.storyboard")
        
        Writer.createPath("Source")
        
        try! sourcePath.copy("Source/LaunchScreen.storyboard")
    }
}
