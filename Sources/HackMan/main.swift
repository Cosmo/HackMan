import Stencil
import Foundation

func unknownCommand() {
    print("Unknown command.")
    print("Try one of those commands:")
    print("app new MusicApp")
    print("app g scaffold Album name uuid artist:Artist createdAt:Date updatedAt:Date -f")
    print("app g view_controller_information -f")
    print("app g coordinator_main Song Artist Album --include=Information -f")
    print("app g asset_catalog -f")
    print("app g launch_screen -f")
    print("app g localization -l=de,en")
    print("app g write -f")
}

var arguments = CommandLine.arguments

guard arguments.count > 0 else { fatalError("No path.") }
let path = arguments.removeFirst()

guard arguments.count > 0 else { fatalError("No arguments.") }
let command = arguments.removeFirst()

let options = arguments.filter { $0.starts(with: "-") }
arguments = arguments.filter { !options.contains($0) }

//if options.filter { $0.start } {
//    print("Verbose!")
//    print("Path: \(path)")
//    print("Command: \(command)")
//    print("Options: \(options)")
//    print("Arguments: \(arguments)")
//}

if CommandLine.arguments.count > 1 {
    switch command {
    case "new":
        print("new")
        if arguments.count > 0 {
            let projectName = arguments.removeFirst()
            print(projectName)
            print(Bundle.main.bundlePath)
            print("heyo")
            NewProject().generate(projectName: projectName, options: options)
        } else {
            print("No project name provided.")
            print("app new [project_name]")
        }
    case "localize", "l":
        Localization().generate(options: options)
    case "generate", "g":
        print("generate")
        if arguments.count > 0 {
            let generator = arguments.removeFirst()
            switch generator {
            case "app_delegate":
                AppDelegate().generate(options: options)
            case "asset_catalog":
                AssetCatalog().generate(options: options)
            case "collection_view_cell":
                let resourceName = arguments.removeFirst().camelCased(.upper)
                let properties = Property.createList(inputStrings: arguments)
                CollectionViewCell().generate(resourceName: resourceName, properties: properties, options: options)
            case "coordinator":
                Coordinator().generate(options: options)
            case "coordinator_child":
                let resourceName = arguments.removeFirst().camelCased(.upper)
                CoordinatorChild().generate(resourceName: resourceName, options: options)
            case "coordinator_main":
                CoordinatorMain().generate(resourceNames: arguments, options: options)
            case "launch_screen":
                LaunchScreen().generate(options: options)
            case "model":
                let resourceName = arguments.removeFirst().camelCased(.upper)
                let properties = Property.createList(inputStrings: arguments)
                Model().generate(resourceName: resourceName, properties: properties, options: options)
            case "reusable_view":
                ReusableView().generate(options: options)
            case "scaffold":
                let resourceName = arguments.removeFirst().camelCased(.upper)
                let properties = Property.createList(inputStrings: arguments)
                Scaffold().generate(resourceName: resourceName, properties: properties, options: options)
            case "view_controller":
                let resourceName = arguments.removeFirst().camelCased(.upper)
                ViewController().generate(resourceName: resourceName, options: options)
            case "view_controller_detail":
                let resourceName = arguments.removeFirst().camelCased(.upper)
                let properties = Property.createList(inputStrings: arguments)
                ViewControllerDetail().generate(resourceName: resourceName, properties: properties, options: options)
            case "view_controller_information":
                ViewControllerInformation().generate(options: options)
            case "view_controller_web":
                ViewControllerWeb().generate(options: options)
            default:
                print("Unknown generator.")
            }
        } else {
            print("No generator name provided.")
            print("app generate [generator]")
            print("or")
            print("app g [generator]")
        }
    default:
        unknownCommand()
    }
} else {
    unknownCommand()
}
