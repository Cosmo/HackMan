# HackMan

HackMan is a simple tool for generating a working iOS app via the command line.
Inspired by the rails command line tools, HackMan features the following commands:

## Usage

### New Project

```
# Create new project directory including a "project.yml" for xcodegen
hackman new [AppName]

# Change into your project directory
cd [AppName]
```

### Generators

Run these generators inside of your project directory.

```
# Create an AppDelegate
hackman generate app_delegate

# Create an empty AssetCatalog
hackman generate asset_catalog

# Create a LaunchScreen-Storyboard
hackman generate launch_screen

# Create a ReusableView protocol and useful extensions for UICollectionViews and UITableViews
hackman generate reusable_view

# Create a Coordinator protocol
hackman generate coordinator

# Create a MainCoordinator
hackman generate coordinator_main

# Create a Child-Coordinator with the given name
hackman generate coordinator_child [Name]

# Create a Model with the given name and fields
hackman generate model [Name] [Field1]:[Type] [Field2]:[Type] …

# Create a UIViewController-Subclass with the given name
hackman generate view_controller [Name]

# Create a ViewControllerCollection (UIViewController-Subclass with a UICollectionView) and UICollectionViewDataSource
hackman generate view_controller_collection [Name] [Field1]:[Type] [Field2]:[Type] …

# Create a UICollectionViewCell-Subclass with the given namen and fields as UILabels
hackman generate collection_view_cell [Name] [Field1]:[Type] [Field2]:[Type] …

# Create a ViewControllerTable (UIViewController-Subclass with a UITableView) and UITableViewDataSource
hackman generate view_controller_table [Name] [Field1]:[Type] [Field2]:[Type] …

# Create a UITableViewCell-Subclass with the given namen and fields as UILabels
hackman generate table_view_cell [Name] [Field1]:[Type] [Field2]:[Type] …

# Create a ViewControllerDetail (UIViewController-Subclass) with the given namen and fields as UILabels
hackman generate view_controller_detail [Name] [Field1]:[Type] [Field2]:[Type] …

# Create a UIViewController-Subclass with a UIWebView
hackman generate view_controller_web

# Create a UIViewController-Subclass with entry points for legal documents
hackman generate view_controller_information

# Create AppDelegate, Model, UICollectionView/UITableView Extensions, UIViewController with UICollectionView/UITableView, ViewControllerDetail, MainCoordinator, ChildCoordinator, Coordinator Protocol and ReusableView Protocol
hackman generate scaffold [Name] [Field1]:[Type] [Field2]:[Type] …
```


### An example of a fully working app

* `hackman new MusicApp`
* `cd MusicApp`
* `hackman g scaffold artist name`
* `hackman g scaffold song title year:int`
* `hackman g scaffold album name uuid artist:artist created_at:date updated_at:date`
* `hackman g view_controller_information`
* `hackman g coordinator_main song artist album --include=information`
* `hackman g asset_catalog`
* `hackman g launch_screen`
* `xcodegen`
* `open MusicApp.xcodeproj`
* `cd ..`
