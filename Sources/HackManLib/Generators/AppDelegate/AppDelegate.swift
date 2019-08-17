import Foundation
import Stencil

@objc(AppDelegate)
class AppDelegate: NSObject, Generator {
    required override init() {}

    func generate(arguments: [String], options: [String]) {
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "AppDelegate.stf")
        
        Writer.createFile("Source/AppDelegate.swift", contents: rendered)
    }
}
