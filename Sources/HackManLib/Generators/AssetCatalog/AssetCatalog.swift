import Foundation
import PathKit

@objc(AssetCatalog)
class AssetCatalog: NSObject, Generator {
    required override init() {}

    func generate(arguments: [String], options: [String]) {
        let sourcePath = Path("\(path)/Assets.xcassets")
        
        Writer.createPath("Source")
        
        try! sourcePath.copy("Source/Assets.xcassets")
    }
}
