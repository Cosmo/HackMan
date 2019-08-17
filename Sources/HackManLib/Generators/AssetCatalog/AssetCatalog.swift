import Foundation
import PathKit

@objc(AssetCatalog)
class AssetCatalog: NSObject, Generator {
    required override init() {}

    func generate(arguments: [String], options: [String]) {
        let url = URL(fileURLWithPath: "\(path)/Assets.xcassets")
        
        let contentsUrl1 = url.appendingPathComponent("Contents.json")
        let contents = try! String(contentsOf: contentsUrl1, encoding: String.Encoding.utf8)
        Writer.createFile("Source/Assets.xcassets/Contents.json", contents: contents)
        
        let contentsUrl2 = url.appendingPathComponent("AppIcon.appiconset/Contents.json")
        let contents2 = try! String(contentsOf: contentsUrl2, encoding: String.Encoding.utf8)
        Writer.createFile("Source/Assets.xcassets/AppIcon.appiconset/Contents.json", contents: contents2)
        
    }
}
