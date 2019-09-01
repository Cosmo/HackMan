import Foundation

@objc(LaunchScreen)
class LaunchScreen: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        let url = URL(fileURLWithPath: "\(basePath)/LaunchScreen.storyboard")
        let contents = try! String(contentsOf: url, encoding: String.Encoding.utf8)
        
        Writer.createPath("Source")
        Writer.createFile("\(Writer.extractSourcePath(options: options))/LaunchScreen.storyboard", contents: contents, options: options)
    }
    
    func help() {
        print("Usage: hackman generate launch_screen")
        print()
        print("Example:")
        print("  hackman generate launch_screen")
    }
}
