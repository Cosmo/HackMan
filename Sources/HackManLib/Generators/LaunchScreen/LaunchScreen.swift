import Foundation
import PathKit

@objc(LaunchScreen)
class LaunchScreen: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        let sourcePath = Path("\(path)/LaunchScreen.storyboard")
        
        Writer.createPath("Source")
        
        try! sourcePath.copy("Source/LaunchScreen.storyboard")
    }
}
