import Foundation
import PathKit

class AssetCatalog: Generator {
    func generate(options: [String]?) {
        let path = Path("\(Bundle.main.bundlePath)/Sources/HackMan/Generators/\(String(describing: type(of: self)))/Assets.xcassets")
        try! path.copy("Source/Assets.xcassets")
    }
}
