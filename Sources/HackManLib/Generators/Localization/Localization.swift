import Foundation

@objc(Localization)
class Localization: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        showHelpIfNeeded(options: options)
        
        print("NOT IMPLEMENTED!")
    }
    
    func help() {
        print("Not implemented.")
    }
}
