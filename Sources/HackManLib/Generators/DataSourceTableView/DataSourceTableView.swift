import Foundation
import Stencil
import GrammaticalNumber

@objc(DataSourceTableView)
class DataSourceTableView: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        guard !arguments.isEmpty else {
            type(of: self).help()
            exit(0)
        }
        
        let containsCoordinator = options.contains("-c") || options.contains("--coordinator")
        
        var mutableArguments = arguments
        let resourceName = mutableArguments.removeFirst()
        
        let resource = Resource(
            name: resourceName,
            properties: Property.createList(inputStrings: mutableArguments)
        )
        let context: [String: Any] = [
            "resource": resource,
            "coordinator": containsCoordinator
        ]
        
        let rendered = try! environment.renderTemplate(name: "DataSourceTableView.stf", context: context)
        Writer.createFile("\(Writer.extractSourcePath(options: options))/DataSources/\(resource.pluralizedName)/\(resource.pluralizedName)TableViewDataSource.swift", contents: rendered, options: options)
    }
    
    static func help() {
        print("Usage: hackman generate \(singleLineUsage())")
        print()
        print("Example:")
        print("  hackman generate data_source_table_view song title:string artist_name:string album_name:string")
    }
    
    static func singleLineUsage() -> String {
        return "data_source_table_view NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …"
    }
}
