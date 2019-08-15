import Foundation
import PathKit

@objc(LaunchScreen)
class LaunchScreen: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        let path = Path("\(Bundle.main.bundlePath)/Sources/HackManLib/Generators/\(String(describing: type(of: self)))/LaunchScreen.storyboard")
        try! path.copy("Source/LaunchScreen.storyboard")
    }
}
