import Foundation
import Stencil

@objc(ViewControllerWeb)
class ViewControllerWeb: NSObject, Generator {
    required override init() {}

    func generate(arguments: [String], options: [String]) {
        let loader = FileSystemLoader(paths: [path])
        let environment = Environment(loader: loader)
        let rendered = try! environment.renderTemplate(name: "ViewControllerWeb.stf")
        
        Writer.createFile("Source/ViewControllers/Generic/WebViewController.swift", contents: rendered)
    }
}
