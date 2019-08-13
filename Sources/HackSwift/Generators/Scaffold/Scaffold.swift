import Stencil
import FileProvider

class Scaffold: Generator {
    func generate(resourceName: String, properties: [Property], options: [String]?) {
        AppDelegate().generate(options: nil)
        ReusableView().generate(options: nil)
        Coordinator().generate(options: nil)
        Model().generate(resourceName: resourceName, properties: properties, options: nil)
        ViewControllerCollection().generate(resourceName: resourceName, properties: properties, options: nil)
        ViewControllerDetail().generate(resourceName: resourceName, properties: properties, options: nil)
        CollectionViewCell().generate(resourceName: resourceName, properties: properties, options: nil)
        CoordinatorMain().generate(resourceNames: [resourceName], options: nil)
        CoordinatorChild().generate(resourceName: resourceName, options: nil)
    }
}
