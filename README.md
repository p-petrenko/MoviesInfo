# {{cookiecutter.app_name}}

Supports: iOS 11.x and above

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `YourLibrary` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!
pod 'YourLibrary'
```

To get the full benefits import `YourLibrary` wherever you import UIKit

``` swift
import UIKit
import YourLibrary
```

## Project structure:

* Resources - fonts, strings, images, generated files etc.
* SupportingFiles - configuration plist files
* Model - model objects
* View - files for view configuration: view controllers, cells, storyboards
* ViewModel - view models for binding model with view
* Common - protocols, extension and utility classes
