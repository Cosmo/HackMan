import Stencil

if CommandLine.arguments.count > 1 {
    var arguments = CommandLine.arguments
    let path = arguments.removeFirst()
    let command = arguments.removeFirst()
    let options = arguments.filter { $0.starts(with: "-") }
    arguments = arguments.filter { !options.contains($0) }
    
    print("HackMan")
    print("path: \(path)")
    print("command: \(command)")
    print("options: \(options)")
    print("arguments: \(arguments)")
    print("-----------------------")
    
    switch command {
    case "inventory":
        print("inventory")
    case "new":
        print("new")
        if arguments.count > 0 {
            let projectName = arguments.removeFirst()
            print(projectName)
        } else {
            print("No project name provided.")
            print("app new [project_name]")
        }
    case "localize", "l":
        Localization()
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
                print("No idea what to do!")
            }
        } else {
            print("No generator name provided.")
            print("app generate [generator]")
        }
    default:
        print("something")
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
}
