import Foundation
import Stencil
import GrammaticalNumber

@objc(ViewControllerDetail)
class ViewControllerDetail: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        guard !arguments.isEmpty else {
            printUsage()
            exit(0)
        }
        
        let containsCoordinator = options.contains("-c") || options.contains("--coordinator")
        var arguments = arguments
        let resource = Resource(
            name: arguments.removeFirst(),
            properties: Property.createList(inputStrings: arguments)
        )
        let context: [String: Any] = [
            "resource": resource,
            "coordinator": containsCoordinator
        ]
        
        let rendered = try! environment.renderTemplate(name: "ViewControllerDetail.stf", context: context)
        Writer.createFile("\(Writer.extractSourcePath(options: options))/ViewControllers/\(resource.pluralizedName)/\(resource.name)ViewController.swift", contents: rendered, options: options)
    }
    
    func printUsage() {
        print("Usage: hackman generate view_controller_detail NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …")
        print()
        print("Example:")
        print("  hackman generate view_controller_detail song title:string artist_name:string album_name:string")
    }
    
    func help() {
        printUsage()
    }
}
