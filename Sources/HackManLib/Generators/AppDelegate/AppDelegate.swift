import Stencil
import FileProvider
import PathKit

@objc(AppDelegate)
class AppDelegate: NSObject, Generator {
    required override init() {}

    func generate(arguments: [String], options: [String]) {
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "AppDelegate.stf")
        
        Writer.write(contents: rendered, toFile: "Source/AppDelegate.swift")
    }
}
