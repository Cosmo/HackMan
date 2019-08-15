import Stencil
import FileProvider

@objc(Scaffold)
class Scaffold: NSObject, Generator {
    required override init() {}
    
    func generate(arguments: [String], options: [String]) {
        AppDelegate().generate(arguments: arguments, options: options)
        ReusableView().generate(arguments: arguments, options: options)
        Coordinator().generate(arguments: arguments, options: options)
        Model().generate(arguments: arguments, options: options)
        ViewControllerCollection().generate(arguments: arguments, options: options)
        ViewControllerDetail().generate(arguments: arguments, options: options)
        CollectionViewCell().generate(arguments: arguments, options: options)
        CoordinatorMain().generate(arguments: arguments, options: options)
        CoordinatorChild().generate(arguments: arguments, options: options)
    }
}
