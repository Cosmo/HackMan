import Foundation
import PathKit

@objc(AssetCatalog)
class AssetCatalog: NSObject, Generator {
    required override init() {}

    func generate(arguments: [String], options: [String]) {
        let path = Path("\(Bundle.main.bundlePath)/Sources/HackManLib/Generators/\(String(describing: type(of: self)))/Assets.xcassets")
        try! path.copy("Source/Assets.xcassets")
    }
}
