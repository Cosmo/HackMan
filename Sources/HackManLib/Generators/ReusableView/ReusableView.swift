import Stencil
import FileProvider
import PathKit

@objc(ReusableView)
class ReusableView: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "ReusableView.stf")
        Writer.write(contents: rendered, toFile: "Source/Protocols/ReusableView.swift")
        
        let rendered2 = try! environment.renderTemplate(name: "UICollectionViewExtensions.stf")
        Writer.write(contents: rendered2, toFile: "Source/Protocols/UICollectionViewExtensions.swift")
        
        let rendered3 = try! environment.renderTemplate(name: "UITableViewExtensions.stf")
        Writer.write(contents: rendered3, toFile: "Source/Protocols/UITableViewExtensions.swift")
    }
}
