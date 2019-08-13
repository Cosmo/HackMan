import Foundation

class Mapper {
    let mapping: [String: AnyClass] = [
        "LaunchScreen": LaunchScreen.self,
        "ViewControllerInformation": ViewControllerInformation.self,
        "AssetCatalog": AssetCatalog.self,
        "CollectionViewCell": CollectionViewCell.self,
        "ReusableView": ReusableView.self,
        "Coordinator": Coordinator.self,
        "CoordinatorMain": CoordinatorMain.self,
        "CoordinatorChild": CoordinatorChild.self,
        "ViewControllerWeb": ViewControllerWeb.self,
        "Model": Model.self,
        "AppDelegate": AppDelegate.self,
        "Scaffold": Scaffold.self,
        "ViewController": ViewController.self,
        "ViewControllerDetail": ViewControllerDetail.self,
        "Localization": Localization.self
    ]
}
