import Foundation

@objc(AssetCatalog)
class AssetCatalog: NSObject, Generator {
    required override init() {}

    func generate(arguments: [String], options: [String]) {
        let url = URL(fileURLWithPath: "\(path)/Assets.xcassets")
        
        let contentsUrl1 = url.appendingPathComponent("Contents.json")
        let contents = try! String(contentsOf: contentsUrl1, encoding: String.Encoding.utf8)
        Writer.createFile("\(Writer.extractSourcePath(options: options))/Assets.xcassets/Contents.json", contents: contents, options: options)
        
        let contentsUrl2 = url.appendingPathComponent("AppIcon.appiconset/Contents.json")
        let contents2 = try! String(contentsOf: contentsUrl2, encoding: String.Encoding.utf8)
        Writer.createFile("\(Writer.extractSourcePath(options: options))/Assets.xcassets/AppIcon.appiconset/Contents.json", contents: contents2, options: options)
        
    }
}
