import Foundation
import PathKit

@objc(LaunchScreen)
class LaunchScreen: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        let url = URL(fileURLWithPath: "\(path)/LaunchScreen.storyboard")
        let contents = try! String(contentsOf: url, encoding: String.Encoding.utf8)
        
        Writer.createPath("Source")
        Writer.createFile("Source/LaunchScreen.storyboard", contents: contents)
    }
}
