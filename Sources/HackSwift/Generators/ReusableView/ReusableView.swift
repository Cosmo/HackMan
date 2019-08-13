import Stencil
import FileProvider

class ReusableView: Generator {
    func generate(options: [String]?) {
        let loader = FileSystemLoader(paths: ["Sources/HackSwift/Generators/ReusableView"])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "ReusableView.stf")
        
        try? FileManager().createDirectory(atPath: "../App/Source/Protocols", withIntermediateDirectories: true, attributes: nil)
        try? rendered.write(toFile: "../App/Source/Protocols/ReusableView.swift", atomically: true, encoding: String.Encoding.utf8)
        
        
        let rendered2 = try! environment.renderTemplate(name: "UICollectionViewExtensions.stf")
        
        try? FileManager().createDirectory(atPath: "../App/Source/Protocols", withIntermediateDirectories: true, attributes: nil)
        try? rendered2.write(toFile: "../App/Source/Protocols/UICollectionViewExtensions.swift", atomically: true, encoding: String.Encoding.utf8)
        
        print(rendered)
    }
}
