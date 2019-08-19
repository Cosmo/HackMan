<img src="https://github.com/Cosmo/HackMan/raw/master/HackMan-Banner.png" alt=" text" width="100%" />

# HackMan

[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager) [![License MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](http://www.opensource.org/licenses/MIT)

HackMan is a simple tool for generating boilerplate code directly via the command line.

Let `hackman` do the boring work and save some time.
Hackman is heavily inspired by the `rails` command.

## Installation

### Clone and build

```sh
git clone git@github.com:Cosmo/HackMan.git
cd HackMan
swift build -c release
```

### Add `hackman` executable to your `PATH`.

```sh
PATH=$PATH:$(pwd)/.build/release
```

or make it persistent

For `zsh` Users (default on macOS Catalina)
```sh
echo "export PATH=\"\$PATH:$(pwd)/.build/release\"" >> ~/.zshrc
```

For `bash` Users (default on macOS Mojave)
```sh
echo "export PATH=\"\$PATH:$(pwd)/.build/release\"" >> ~/.bashrc
```

## Usage

### New Project

```sh
# Create new project directory including a "project.yml" for xcodegen
hackman new APP_NAME

# Change into your project directory
cd APP_NAME
```

### Generators

Run these generators inside of your project directory.

```sh
# Create an AppDelegate
hackman generate app_delegate

Options
  --coordinator, -c
    Adds coordinator support

  --force, -f
    Force override existing files
```
```sh
# Create an empty AssetCatalog
hackman generate asset_catalog

Options
  --force, -f
    Force override existing files
```
```sh
# Create a LaunchScreen-Storyboard
hackman generate launch_screen

Options
  --force, -f
    Force override existing files
```
```sh
# Create a ReusableView protocol and useful extensions for UICollectionViews and UITableViews
hackman generate reusable_view

Options
  --force, -f
    Force override existing files
```
```sh
# Create a Coordinator protocol
hackman generate coordinator

Options
  --force, -f
    Force override existing files
```
```sh
# Create a MainCoordinator
hackman generate coordinator_main NAME NAME …

Options
  --force, -f
    Force override existing files

  --include=NAME,NAME,…
    Include ViewControllers that were not generated via scaffold.
    Names must be separated with commas. Spaces between names are not allowed.
```
```sh
# Create a Child-Coordinator with the given name
hackman generate coordinator_child NAME

Options
  --force, -f
    Force override existing files
```
```sh
# Create a Model with the given name and properties
hackman generate model NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …

Options
  --force, -f
    Force override existing files
```
```sh
# Create a UIViewController-Subclass with the given name
hackman generate view_controller NAME

Options
  --coordinator, -c
    Adds coordinator support

  --force, -f
    Force override existing files
```
```sh
# Create a ViewControllerCollection (UIViewController-Subclass with a UICollectionView) and UICollectionViewDataSource
hackman generate view_controller_collection NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …

Options
  --coordinator, -c
    Adds coordinator support

  --force, -f
    Force override existing files
```
```sh
# Create a UICollectionViewCell-Subclass with the given namen and properties as UILabels
hackman generate collection_view_cell NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …

Options
  --force, -f
    Force override existing files
```
```sh
# Create a ViewControllerTable (UIViewController-Subclass with a UITableView) and UITableViewDataSource
hackman generate view_controller_table NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …

Options
  --coordinator, -c
    Adds coordinator support

  --force, -f
    Force override existing files
```
```sh
# Create a UITableViewCell-Subclass with the given namen and properties as UILabels
hackman generate table_view_cell NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …

Options
  --force, -f
    Force override existing files
```
```sh
# Create a ViewControllerDetail (UIViewController-Subclass) with the given namen and properties as UILabels
hackman generate view_controller_detail NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …

Options
  --coordinator, -c
    Adds coordinator support

  --force, -f
    Force override existing files
```
```sh
# Create a UIViewController-Subclass with a UIWebView
hackman generate view_controller_web

Options
  --coordinator, -c
    Adds coordinator support

  --force, -f
    Force override existing files
```
```sh
# Create a UIViewController-Subclass with entry points for legal documents
hackman generate view_controller_information

Options
  --coordinator, -c
    Adds coordinator support
  
  --force, -f
    Force override existing files
```
```sh
# Create Model, UICollectionView/UITableView Extensions, UIViewController with UICollectionView/UITableView, ViewControllerDetail, ChildCoordinator, Coordinator Protocol and ReusableView Protocol
hackman generate scaffold NAME [PROPERTY[:TYPE] PROPERTY[:TYPE]] …

# By default, the scaffold will be UICollectionView based.
# In order to create UITableView based scaffolds, pass the --view=table at the end.
# Like so:
hackman generate scaffold song title:string year:int --view=table

Options
  --coordinator, -c
    Adds coordinator support
    
  --force, -f
    Force override existing files
```

You can also write `hackman g` instead of `hackman generate`.

### Properties

When creating scaffolds, models, controllers you can also specify multiple fields to be generated automatically

```sh
hackman g scaffold author name:string birthday:date
```
This commands creates among other things a struct of type `Author` with the following properties.
```swift
    let name: String
    let birthday: Date
```

You can also reference to your custom types.
```sh
hackman g scaffold Article title:string body:string published_at:date author:author
```
This will generate the following properties inside of the `Article` model.
```swift
    let title: String
    let body: String
    let publishedAt: Date
    let author: Author
```

If you omit the property type, `hackman` assumes you want a property of type `String`.
```sh
hackman g scaffold article title body published_at:date author:author
```


### An example of a fully working app

```sh
hackman new MusicApp
cd MusicApp
hackman g app_delegate --coordinator
hackman g asset_catalog
hackman g launch_screen
hackman g scaffold artist name --coordinator
hackman g scaffold song title year:int --coordinator
hackman g scaffold album name uuid artist:artist created_at:date updated_at:date --coordinator
hackman g view_controller_information --coordinator
hackman g coordinator_main song artist album --include=information
xcodegen
open MusicApp.xcodeproj
```

#### Demo

![Demo](https://github.com/Cosmo/HackMan/blob/master/HackMan-Preview.gif?raw=true)

## Requirements

* Xcode 10
* Swift 5

## Todos

* [ ] Easier setup
* [ ] Easy support for custom generators
* [ ] Support for `help [command]`
* [ ] SwiftUI based templates
* [ ] Generator for localization

## Contact

* Devran "Cosmo" Uenal
* Twitter: [@maccosmo](http://twitter.com/maccosmo)

## License

HackMan is released under the [MIT License](http://www.opensource.org/licenses/MIT).
