# TOSegmentedTabBarController

<p align="center">
<img src="https://github.com/TimOliver/TOSegmentedTabBarController/raw/master/screenshot.jpg" width="890" style="margin:0 auto" />
</p>

[![CocoaPods](https://img.shields.io/cocoapods/dt/TOSegmentedTabBarController.svg?maxAge=3600)](https://cocoapods.org/pods/TOSegmentedTabBarController)
[![Version](https://img.shields.io/cocoapods/v/TOSegmentedTabBarController.svg?style=flat)](http://cocoadocs.org/docsets/TOSegmentedTabBarController)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/TimOliver/TOSegmentedTabBarController/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/TOSegmentedTabBarController.svg?style=flat)](http://cocoadocs.org/docsets/TOSegmentedTabBarController)
[![PayPal](https://img.shields.io/badge/paypal-donate-blue.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=M4RKULAVKV7K8)
[![Twitch](https://img.shields.io/badge/twitch-timXD-6441a5.svg)](http://twitch.tv/timXD)


`TOSegmentedTabBarController` is an open-source `UIViewController` subclass to serve as a modal tab bar controller in instances where it's desirable to also include action buttons in the bottom bar.

This library is a component of `TOFileKit` and as such, it was hastily built to suit just that library's needs. Feedback and PRs are welcome!

## Features
* Swap between view controllers using a `UISegmentedControl`.
* Optionally, can show two view controllers side by side on regular size devices.
* Properly responds to size class changes.

## System Requirements
iOS 9.0 or above

## Installation

#### As a CocoaPods Dependency

Add the following to your Podfile:
``` ruby
pod 'TOSegmentedTabBarController'
```

#### As a Carthage Dependency

Carthage support hasn't been implemented yet. Please open an issue if you want it.

#### Manual Installation

All of the necessary source and resource files for `TOSegmentedTabBarController` are in the `TOSegmentedTabBarController` folder. Simply copy this folder to your project, and import it into Xcode.

## Examples
Using `TOSegmentedTabBarController` is very straightforward. Simply create a new instance, and pass along the view controllers you want to display.

For a complete working example, check out the sample app included in this repo.

### Basic Implementation

```objc
	TOSegmentedTabBarController *segmentedController = [[TOSegmentedTabBarController alloc] initWithControllers:@[firstController, secondController]];
   
	[self presentViewController:segmentedController animated:YES completion:nil];
```

## Credits
`TOSegmentedTabBarController` was originally created by [Tim Oliver](http://twitter.com/TimOliverAU) as a component for [iComics](http://icomics.co), a comic reader app for iOS.

iOS Device mockups used in the screenshot created by [Pixeden](http://www.pixeden.com).

## License
TOSegmentedTabBarController is licensed under the MIT License, please see the [LICENSE](LICENSE) file. ![analytics](https://ga-beacon.appspot.com/UA-5643664-16/TOSegmentedTabBarController/README.md?pixel)
