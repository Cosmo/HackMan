import Foundation
import Stencil
import GrammaticalNumber

@objc(SearchResultsController)
class SearchResultsController: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        guard !arguments.isEmpty else {
            type(of: self).help()
            exit(0)
        }
        
        var mutableArguments = arguments
        let resource = Resource(
            name: mutableArguments.removeFirst(),
            properties: Property.createList(inputStrings: mutableArguments)
        )
        let context: [String: Any] = [
            "resource": resource
        ]
        
        let rendered = try! environment.renderTemplate(name: "SearchResultsController.stf", context: context)
        Writer.createFile("\(Writer.extractSourcePath(options: options))/ViewControllers/\(resource.pluralizedName)/\(resource.name)SearchResultsViewController.swift", contents: rendered, options: options)
    }
    
    static func help() {
        print("Usage: hackman generate \(singleLineUsage())")
        print()
        print("Example:")
        print("  search_results_controller song")
    }
    
    static func singleLineUsage() -> String {
        return "search_results_controller NAME"
    }
}
