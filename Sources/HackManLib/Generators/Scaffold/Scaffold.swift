import Foundation
import Stencil

@objc(Scaffold)
class Scaffold: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        guard !arguments.isEmpty else {
            printUsage()
            exit(0)
        }
        
        ReusableView().generate(arguments: arguments, options: options)
        Model().generate(arguments: arguments, options: options)
        ViewControllerDetail().generate(arguments: arguments, options: options)

        if options.contains("--view=table") {
            ViewControllerTable().generate(arguments: arguments, options: options)
            TableViewCell().generate(arguments: arguments, options: options)
        } else {
            ViewControllerCollection().generate(arguments: arguments, options: options)
            CollectionViewCell().generate(arguments: arguments, options: options)
        }
        
        let containsCoordinator = options.contains("-c") || options.contains("--coordinator")
        if containsCoordinator {
            CoordinatorChild().generate(arguments: arguments, options: options)
        }
    }
    
    func printUsage() {
        print("Usage: hackman generate scaffold NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …")
        print()
        print("Example:")
        print("  hackman generate scaffold song title:string artist_name:string album_name:string")
    }
    
    func help() {
        printUsage()
    }
}
