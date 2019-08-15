import Foundation
import PathKit

class LaunchScreen: Generator {
    func generate(options: [String]?) {
        let path = Path("\(Bundle.main.bundlePath)/Sources/HackMan/Generators/\(String(describing: type(of: self)))/LaunchScreen.storyboard")
        try! path.copy("Source/LaunchScreen.storyboard")
    }
}
