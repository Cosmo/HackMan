<img src="https://github.com/Cosmo/HackMan/raw/master/HackMan-Banner.png" alt=" text" width="100%" />

# HackMan

[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager) [![License MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](http://www.opensource.org/licenses/MIT)

HackMan is a simple tool for generating boilerplate code directly via the command line.

Let `hackman` do the boring work and save some time.
Hackman is heavily inspired by the `rails` command.

## Installation

Clone and build
```
git clone git@github.com:Cosmo/HackMan.git
cd HackMan
swift build -c release
```

Add the `hackman` executable to your path.
```
PATH=$PATH:$(pwd)/.build/release
```

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

# Create a Model with the given name and properties
hackman generate model [Name] [Property1]:[Type] [Property2]:[Type] …

# Create a UIViewController-Subclass with the given name
hackman generate view_controller [Name]

# Create a ViewControllerCollection (UIViewController-Subclass with a UICollectionView) and UICollectionViewDataSource
hackman generate view_controller_collection [Name] [Property1]:[Type] [Property2]:[Type] …

# Create a UICollectionViewCell-Subclass with the given namen and properties as UILabels
hackman generate collection_view_cell [Name] [Property1]:[Type] [Property2]:[Type] …

# Create a ViewControllerTable (UIViewController-Subclass with a UITableView) and UITableViewDataSource
hackman generate view_controller_table [Name] [Property1]:[Type] [Property2]:[Type] …

# Create a UITableViewCell-Subclass with the given namen and properties as UILabels
hackman generate table_view_cell [Name] [Property1]:[Type] [Property2]:[Type] …

# Create a ViewControllerDetail (UIViewController-Subclass) with the given namen and properties as UILabels
hackman generate view_controller_detail [Name] [Property1]:[Type] [Property2]:[Type] …

# Create a UIViewController-Subclass with a UIWebView
hackman generate view_controller_web

# Create a UIViewController-Subclass with entry points for legal documents
hackman generate view_controller_information

# Create AppDelegate, Model, UICollectionView/UITableView Extensions, UIViewController with UICollectionView/UITableView, ViewControllerDetail, MainCoordinator, ChildCoordinator, Coordinator Protocol and ReusableView Protocol
hackman generate scaffold [Name] [Property1]:[Type] [Property2]:[Type] …
# By default, the scaffold will be UICollectionView based.
# In order to create UITableView based scaffolds, pass the --view=table at the end.
# Like so:
hackman generate scaffold Song title:string year:Int --view=table
```

You can also write `hackman g` instead of `hackman generate`.

### Properties

When creating scaffolds, models, controllers you can also specify multiple fields to be generated automatically

```
hackman g scaffold Author name:string birthday:date
```
This commands creates among other things a struct of type `Author` with the following properties.
```
    let name: String
    let birthday: Date
```

You can also reference to your custom types.
```
hackman g scaffold Article title:string body:string published_at:date author:author
```
This will generate the following properties inside of the `Article` model.
```
    let title: String
    let body: String
    let publishedAt: Date
    let author: Author
```

If you omit the property type, `hackman` assumes you want a property of type `String`.
```
hackman g scaffold Article title body published_at:date author:author
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

#### Demo

![Demo](https://github.com/Cosmo/HackMan/blob/master/HackMan-Preview.gif?raw=true)

## Requirements

* Xcode 10
* Swift 5

## Contact

* Devran "Cosmo" Uenal
* Twitter: [@maccosmo](http://twitter.com/maccosmo)

## License

HackMan is released under the [MIT License](http://www.opensource.org/licenses/MIT).
