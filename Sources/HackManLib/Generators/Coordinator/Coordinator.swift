import Foundation
import Stencil

@objc(Coordinator)
class Coordinator: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        let rendered = try! environment.renderTemplate(name: "Coordinator.stf")
        
        Writer.createFile("\(Writer.extractSourcePath(options: options))/Protocols/Coordinator.swift", contents: rendered, options: options)
    }
    
    func help() {
        print("Usage: hackman generate coordinator")
        print()
        print("Example:")
        print("  hackman generate coordinator")
    }

}
