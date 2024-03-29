import Foundation
import Stencil

@objc(ReusableView)
class ReusableView: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        let rendered = try! environment.renderTemplate(name: "ReusableView.stf")
        Writer.createFile("\(Writer.extractSourcePath(options: options))/Protocols/ReusableView.swift", contents: rendered, options: options)
        
        let rendered2 = try! environment.renderTemplate(name: "UICollectionViewExtensions.stf")
        Writer.createFile("\(Writer.extractSourcePath(options: options))/Protocols/UICollectionViewExtensions.swift", contents: rendered2, options: options)
        
        let rendered3 = try! environment.renderTemplate(name: "UITableViewExtensions.stf")
        Writer.createFile("\(Writer.extractSourcePath(options: options))/Protocols/UITableViewExtensions.swift", contents: rendered3, options: options)
    }
    
    static func help() {
        print("Usage: hackman generate \(singleLineUsage())")
        print()
        print("Example:")
        print("  hackman generate reusable_view")
    }
    
    static func singleLineUsage() -> String {
        return "reusable_view"
    }
}
