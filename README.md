#  DeviceModel-Swift

## Supported OS:
Both macOS, Mac Catalyst are not supported.

- iOS & iPadOS: 12.0 ~
- tvOS: 12.0 ~
- visionOS: 1.0 ~

## Why used?
When trying to retrieve the model name currently in use in a UIKit-based app

## Adaptation
1. (at Xcode top bar) -> File -> Add Package Dependencies
2. shown new window -> in textfield with placeholder "Search or Enter Package URL", copy and paste this git repository URL.
3. And then, click "Copy Dependency" on that window. 

## How to use?
In commonly, you can just use like below usages in code using UIKit after adaptation of this package.

1) Returns an enumeration instance of the currently running device:
'''Swift
DeviceModel.type    // (DeviceModel) iPhone15Pro
'''  

2) Returns the actual model name as a string:
'''Swift
DeviceModel.type.rawValue // "iPhone 15 Pro"
'''
