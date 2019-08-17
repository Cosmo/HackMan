import Foundation
import Stencil

@objc(ReusableView)
class ReusableView: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "ReusableView.stf")
        Writer.createFile("Source/Protocols/ReusableView.swift", contents: rendered)
        
        let rendered2 = try! environment.renderTemplate(name: "UICollectionViewExtensions.stf")
        Writer.createFile("Source/Protocols/UICollectionViewExtensions.swift", contents: rendered2)
        
        let rendered3 = try! environment.renderTemplate(name: "UITableViewExtensions.stf")
        Writer.createFile("Source/Protocols/UITableViewExtensions.swift", contents: rendered3)
    }
}
