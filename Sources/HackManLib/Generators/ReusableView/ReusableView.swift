import Stencil
import FileProvider
import PathKit

@objc(ReusableView)
class ReusableView: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        let path = Path("\(Bundle.main.bundlePath)/Sources/HackManLib/Generators/\(String(describing: type(of: self)))")
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "ReusableView.stf")
        
        try? FileManager().createDirectory(atPath: "Source/Protocols", withIntermediateDirectories: true, attributes: nil)
        try? rendered.write(toFile: "Source/Protocols/ReusableView.swift", atomically: true, encoding: String.Encoding.utf8)
        
        
        let rendered2 = try! environment.renderTemplate(name: "UICollectionViewExtensions.stf")
        
        try? FileManager().createDirectory(atPath: "Source/Protocols", withIntermediateDirectories: true, attributes: nil)
        try? rendered2.write(toFile: "Source/Protocols/UICollectionViewExtensions.swift", atomically: true, encoding: String.Encoding.utf8)
        
        
        let rendered3 = try! environment.renderTemplate(name: "UITableViewExtensions.stf")
        
        try? FileManager().createDirectory(atPath: "Source/Protocols", withIntermediateDirectories: true, attributes: nil)
        try? rendered3.write(toFile: "Source/Protocols/UITableViewExtensions.swift", atomically: true, encoding: String.Encoding.utf8)
    }
}
