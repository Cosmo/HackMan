# HackMan

HackMan is a simple tool for generating a working iOS app via the command line.
Inspired by the rails command line tools, HackMan features the following commands:

## Commands

```
hackman new [AppName]

hackman generate app_delegate
hackman generate asset_catalog
hackman generate launch_screen
hackman generate coordinator
hackman generate reusable_view

hackman generate coordinator_child [ResourceName]
hackman generate model [ResourceName]

hackman generate view_controller [ResourceName]

hackman generate view_controller_collection [ResourceName]
hackman generate collection_view_cell [ResourceName]

hackman generate view_controller_table [ResourceName]
hackman generate table_view_cell [ResourceName] 

hackman generate view_controller_detail [ResourceName]
hackman generate view_controller_web
hackman generate view_controller_information

hackman generate scaffold [ResourceName]
```

## An example of a fully working app

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
